/****************************************************************************
**
** Copyright (C) 2017 Pelagicore AG
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:GPL-QTAS$
** Commercial License Usage
** Licensees holding valid commercial Qt Automotive Suite licenses may use
** this file in accordance with the commercial license agreement provided
** with the Software or, alternatively, in accordance with the terms
** contained in a written agreement between you and The Qt Company.  For
** licensing terms and conditions see https://www.qt.io/terms-conditions.
** For further information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
** SPDX-License-Identifier: GPL-3.0
**
****************************************************************************/

#include "sqltabledatasource.h"
#include "sqltablemodel.h"

#include <QtCore/QtDebug>
#include <QtCore/QStandardPaths>
#include <QtCore/QDir>
#include <QtSql/QSqlError>


SqlTableDataSource::SqlTableDataSource(QObject *parent)
    : QObject(parent)
    , m_model(nullptr)
    , m_status(Null)
    , m_componentCompleted(false)
{
}

QString SqlTableDataSource::table() const
{
    return m_tableName;
}

QString SqlTableDataSource::database() const
{
    return m_databaseName;
}

QAbstractItemModel *SqlTableDataSource::model() const
{
    return m_model;
}

int SqlTableDataSource::count() const
{
    return m_model ? m_model->rowCount() : 0;
}

SqlTableDataSource::Status SqlTableDataSource::status() const
{
    return m_status;
}

void SqlTableDataSource::setStatus(SqlTableDataSource::Status status)
{
    if (m_status != status) {
        m_status = status;
        emit statusChanged(status);
    }
}

QString SqlTableDataSource::filter() const
{
    return m_model ? m_model->filter() : QString();
}

QVariantMap SqlTableDataSource::get(int index) const
{
    return m_model ? m_model->get(index) : QVariantMap();
}

void SqlTableDataSource::classBegin()
{
}

void SqlTableDataSource::componentComplete()
{
    qDebug() << "componentComplete";
    m_componentCompleted = true;
    updateModel();
}

QString SqlTableDataSource::storageLocation() const
{
    return QDir::homePath();
}

void SqlTableDataSource::setFilter(const QString &filter)
{
    qDebug() << "SqlTableDataSource::setFilter(): " << filter;
    if (m_model && (m_model->filter() != filter)) {
        m_model->setFilter(filter);
        m_model->select();
        emit filterChanged(filter);
    }
}

void SqlTableDataSource::setTable(const QString &tableName)
{
    if (m_tableName != tableName) {
        m_tableName = tableName;
        updateModel();
        emit tableChanged(tableName);
    }
}

void SqlTableDataSource::setDatabase(const QString &databaseName)
{
    if (m_databaseName != databaseName) {
        m_databaseName = databaseName;
        updateModel();
        emit databaseChanged(databaseName);
    }
}


void SqlTableDataSource::updateModel()
{
    if (!m_componentCompleted)
        return;
    qDebug() << "SqlTableDataSource::updateModel()";
    if (m_databaseName.isEmpty() || m_tableName.isEmpty()) {
        setStatus(Null);
        qDebug() << "  not configure; return";
        return;
    }
    if (!m_databaseName.isEmpty()) {
        if (QSqlDatabase::contains(m_databaseName)) {
            qDebug() << "  found existing db connection";
            m_database = QSqlDatabase::database(m_databaseName);
        } else {
            qDebug() << "  init new db connection";
            m_database = QSqlDatabase::addDatabase("QSQLITE", m_databaseName);
            QString databasePath = QDir(QStandardPaths::writableLocation(QStandardPaths::HomeLocation)).filePath(m_databaseName + ".db");
            m_database.setDatabaseName(databasePath);
            qDebug() << "database path: " << databasePath;
        }
        if (!m_database.isOpen()) {
            qDebug() << "  open database";
            m_database.open();
            qDebug() << " tables: " << m_database.tables();
        }
    }
    if (m_database.isValid() && !m_tableName.isEmpty()) {
        if (!m_model || (m_model->tableName() != m_tableName)) {
            if (m_model) {
                delete m_model;
                m_model = nullptr;
                emit modelChanged(m_model);
            }
            m_model = new SqlTableModel(this, m_database);
            emit modelChanged(m_model);
        }
        qDebug() << "  update table";
        setStatus(Loading);
        m_model->setTable(m_tableName);
        qDebug() << "  update role names";
        m_model->updateRoleNames();
        qDebug() << "  select data";
        if (!m_model->select())
            qDebug() << " error: select data from model";
        while (m_model->canFetchMore())
            m_model->fetchMore(QModelIndex());
        qDebug() << "  finish select data";
        if (m_model->lastError().isValid()) {
            qDebug() << "  error: " << m_model->lastError().text();
            setStatus(Error);
        } else {
            qDebug() << "  ready";
            setStatus(Ready);
        }
    }
    qDebug() << "update model: " << count();
    emit modelChanged(m_model);
    emit countChanged(count());
}


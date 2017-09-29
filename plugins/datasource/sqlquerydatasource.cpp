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

#include <QtCore/QDir>
#include <QtCore/QDebug>
#include <QtSql/QSqlError>

#include "logging.h"
#include "sqlquerydatasource.h"
#include "sqlquerymodel.h"

SqlQueryDataSource::SqlQueryDataSource(QObject *parent)
    : QObject(parent)
    , m_storageLocation(QDir::homePath())
    , m_model(new SqlQueryModel(this))
    , m_status(SqlQueryDataSource::Null)
{
    connect(m_model, &SqlQueryModel::rowsInserted, this, &SqlQueryDataSource::countChanged);
    connect(m_model, &SqlQueryModel::rowsRemoved, this, &SqlQueryDataSource::countChanged);
    connect(m_model, &SqlQueryModel::layoutChanged, this, &SqlQueryDataSource::countChanged);
    connect(m_model, &SqlQueryModel::modelReset, this, &SqlQueryDataSource::countChanged);
}

QVariantMap SqlQueryDataSource::get(int index) const
{
    return m_model ? m_model->get(index) : QVariantMap();
}

QString SqlQueryDataSource::database() const
{
    return m_database.connectionName();
}

SqlQueryDataSource::Status SqlQueryDataSource::status() const
{
    return m_status;
}

int SqlQueryDataSource::count() const
{
    return m_model ? m_model->rowCount() : 0;
}

QString SqlQueryDataSource::query() const
{
    if (!m_query.isValid())
        return QString();
    return m_query.lastQuery();
}

void SqlQueryDataSource::setQuery(const QString &queryString)
{
    qCDebug(dataSource) << "SqlQueryDataSource::setQuery()" << queryString;
    if (m_queryString != queryString) {
        m_queryString = queryString;
        updateModel();
        emit queryChanged(queryString);
    }
}

void SqlQueryDataSource::setDatabase(const QString &databaseName)
{
    if (m_databaseName != databaseName) {
        m_databaseName = databaseName;
        updateModel();
        emit databaseChanged(databaseName);
    }
}

void SqlQueryDataSource::updateModel()
{
    if (m_databaseName.isEmpty() || m_queryString.isEmpty()) {
        setStatus(Null);
        return;
    }
    if (!m_databaseName.isEmpty()) {
        if (QSqlDatabase::contains(m_databaseName)) {
            m_database = QSqlDatabase::database(m_databaseName);
        } else {
            m_database = QSqlDatabase::addDatabase("QSQLITE", m_databaseName);
            QString databasePath = QDir(m_storageLocation).filePath(m_databaseName + ".db");
            m_database.setDatabaseName(databasePath);
            qCDebug(dataSource) << "database path:" << databasePath;
        }
        if (!m_database.isOpen())
            m_database.open();
    }
    if (m_database.isValid() && !m_queryString.isEmpty()) {
        setStatus(Loading);
        m_query = QSqlQuery(m_queryString, m_database);
        m_model->setQuery(m_query);
        m_model->updateRoleNames();
        if (m_query.lastError().isValid()) {
            qCDebug(dataSource) << "Error" << m_query.lastError().text();
            setStatus(Error);
        } else {
            setStatus(Ready);
        }
    }
    emit modelChanged(m_model);
}


QObject *SqlQueryDataSource::model() const
{
    return m_model;
}


void SqlQueryDataSource::setStatus(SqlQueryDataSource::Status arg)
{
    if (m_status != arg) {
        m_status = arg;
        emit statusChanged(arg);
    }
}

QString SqlQueryDataSource::storageLocation() const
{
    return m_storageLocation;
}

void SqlQueryDataSource::setStorageLocation(const QString &path)
{
    m_storageLocation = QDir(path).absolutePath();
}

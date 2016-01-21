/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
** Contact: http://www.qt.io/ or http://www.pelagicore.com/
**
** This file is part of the Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:GPL3-PELAGICORE$
** Commercial License Usage
** Licensees holding valid commercial Pelagicore Neptune IVI UI
** licenses may use this file in accordance with the commercial license
** agreement provided with the Software or, alternatively, in accordance
** with the terms contained in a written agreement between you and
** Pelagicore. For licensing terms and conditions, contact us at:
** http://www.pelagicore.com.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU General Public License version 3 requirements will be
** met: http://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
** SPDX-License-Identifier: GPL-3.0
**
****************************************************************************/

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
    if (!m_model) { return QVariantMap(); }
    return m_model->get(index);
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
    if (!m_model) { return 0; }
    return m_model->rowCount();
}

QString SqlQueryDataSource::query() const
{
    if (!m_query.isValid()) {
        return QString();
    }
    return m_query.lastQuery();
}

void SqlQueryDataSource::setQuery(QString queryString)
{
    qDebug() << "SqlQueryDataSource::setQuery() " << queryString;
    if (m_queryString != queryString) {
        m_queryString = queryString;
        updateModel();
        emit queryChanged(queryString);
    }
}

void SqlQueryDataSource::setDatabase(QString databaseName)
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
            qDebug() << "database path: " << databasePath;
        }
        if (!m_database.isOpen()) {
            m_database.open();
        }
    }
    if (m_database.isValid() && !m_queryString.isEmpty()) {
        setStatus(Loading);
        m_query = QSqlQuery(m_queryString, m_database);
        m_model->setQuery(m_query);
        m_model->updateRoleNames();
        if (m_query.lastError().isValid()) {
            qDebug() << "Error" << m_query.lastError().text();
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

void SqlQueryDataSource::setStorageLocation(QString path)
{
    m_storageLocation = QDir(path).absolutePath();
}


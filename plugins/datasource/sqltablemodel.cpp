/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
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

#include "sqltablemodel.h"

#include <QtCore/QtDebug>
#include <QtSql/QSqlRecord>

SqlTableModel::SqlTableModel(QObject *parent, QSqlDatabase db) :
    QSqlTableModel(parent, db)
{
    connect(this, SIGNAL(rowsAboutToBeInserted(QModelIndex,int,int)), this, SLOT(notifyCount()));
    connect(this, SIGNAL(rowsAboutToBeRemoved(QModelIndex,int,int)), this, SLOT(notifyCount()));

}

void SqlTableModel::updateRoleNames()
{
    qDebug() << "SqlTableModel::updateRoleNames()";
    m_roleNames.clear();
    for (int i = 0; i < record().count(); i++) {
        m_roleNames[Qt::UserRole + i + 1] = record().fieldName(i).toLatin1();
    }
    qDebug() << "  role names: " << m_roleNames.values();
}


QHash<int, QByteArray> SqlTableModel::roleNames() const
{
    return m_roleNames;
}


QVariantMap SqlTableModel::get(int row) const
{
    QVariantMap map;
    QModelIndex index = createIndex(row, 0);
    foreach (int role, m_roleNames.keys()) {
        map.insert(m_roleNames.value(role), data(index, role));
    }
    return map;
}

QVariant SqlTableModel::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlTableModel::data(index, role);
    if (role < Qt::UserRole) {
        value = QSqlTableModel::data(index, role);
    } else {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlTableModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}

int SqlTableModel::count() const
{
    return rowCount();
}

void SqlTableModel::notifyCount()
{
    emit countChanged(rowCount());
}


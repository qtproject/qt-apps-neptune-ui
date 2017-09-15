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

#ifndef SQLTABLEMODEL_H
#define SQLTABLEMODEL_H

#include <QtSql/QSqlTableModel>

class SqlTableModel : public QSqlTableModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count NOTIFY countChanged)
public:
    explicit SqlTableModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());

    void updateRoleNames();
    QHash<int, QByteArray> roleNames() const;
    Q_INVOKABLE QVariantMap get(int row) const;
    QVariant data(const QModelIndex &index, int role) const;
    int count() const;
private slots:
    void notifyCount();
signals:
    void countChanged(int count);

private:
    QHash<int, QByteArray> m_roleNames;
};

#endif // SQLTABLEMODEL_H

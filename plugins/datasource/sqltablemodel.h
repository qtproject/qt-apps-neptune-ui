/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
** Contact: http://www.pelagicore.com/
**
** This file is part of Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Neptune IVI UI licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Pelagicore. For licensing terms
** and conditions see http://www.pelagicore.com.
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
****************************************************************************/

#ifndef SQLTABLEMODEL_H
#define SQLTABLEMODEL_H

#include <QtSql/QSqlTableModel>

class SqlTableModel : public QSqlTableModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count NOTIFY countChanged)
public:
    explicit SqlTableModel(QObject *parent = 0, QSqlDatabase db = QSqlDatabase());

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

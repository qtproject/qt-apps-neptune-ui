/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
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

#ifndef SQLQUERYDATASOURCE_H
#define SQLQUERYDATASOURCE_H

#include <QtCore>
#include <QtSql>

class SqlQueryModel;

class SqlQueryDataSource : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString query READ query WRITE setQuery NOTIFY queryChanged)
    Q_PROPERTY(QString database READ database WRITE setDatabase NOTIFY databaseChanged)
    Q_PROPERTY(QObject* model READ model NOTIFY modelChanged)
    Q_PROPERTY(int count READ count NOTIFY countChanged)
    Q_PROPERTY(Status status READ status NOTIFY statusChanged)
    Q_PROPERTY(QString storageLocation READ storageLocation WRITE setStorageLocation NOTIFY storageLocationChanged)
    Q_ENUMS(Status)

public:
    enum Status { Null, Loading, Ready, Error };
    explicit SqlQueryDataSource(QObject *parent = 0);

    void setQuery(QString queryString);
    QString query() const;

    QString database() const;
    void setDatabase(QString databaseName);

    int count() const;
    Q_INVOKABLE QVariantMap get(int index) const;

    QObject* model() const;

    Status status() const;

   QString storageLocation() const;
   void setStorageLocation(QString path);
private:
    void updateModel();
    void setStatus(Status arg);


signals:
    void countChanged();
    void queryChanged(QString query);

    void databaseChanged(QString arg);
    void statusChanged(Status arg);

    void modelChanged(QObject* model);
    void storageLocationChanged();

private:
    QString m_queryString;
    QString m_databaseName;
    QString m_storageLocation;
    SqlQueryModel *m_model;
    QSqlQuery m_query;
    QSqlDatabase m_database;
    Status m_status;
};



#endif // SQLQUERYMODEL_H

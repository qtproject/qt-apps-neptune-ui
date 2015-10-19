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
    Q_PROPERTY(QString storageLocation READ storageLocation CONSTANT)
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
private:
    void updateModel();
    void setStatus(Status arg);


signals:
    void countChanged();
    void queryChanged(QString query);

    void databaseChanged(QString arg);
    void statusChanged(Status arg);

    void modelChanged(QObject* model);

private:
    QString m_queryString;
    QString m_databaseName;
    SqlQueryModel *m_model;
    QSqlQuery m_query;
    QSqlDatabase m_database;
    Status m_status;
};



#endif // SQLQUERYMODEL_H

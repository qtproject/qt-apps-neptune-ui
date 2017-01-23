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

#ifndef SQLTABLEDATASOURCE_H
#define SQLTABLEDATASOURCE_H

#include <QtCore/QAbstractItemModel>
#include <QtSql/QSqlDatabase>
#include <QtQml/QQmlParserStatus>

class SqlTableModel;

class SqlTableDataSource : public QObject, public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)
    Q_PROPERTY(QString database READ database WRITE setDatabase NOTIFY databaseChanged)
    Q_PROPERTY(QString table READ table WRITE setTable NOTIFY tableChanged)
    Q_PROPERTY(QString filter READ filter WRITE setFilter NOTIFY filterChanged)
    Q_PROPERTY(QObject* model READ model NOTIFY modelChanged)
    Q_PROPERTY(int count READ count NOTIFY countChanged)
    Q_PROPERTY(QString storageLocation READ storageLocation CONSTANT)
    Q_PROPERTY(Status status READ status NOTIFY statusChanged)
    Q_ENUMS(Status)

public:
    enum Status { Null, Loading, Ready, Error };
    explicit SqlTableDataSource(QObject *parent = 0);

    QString table() const;
    void setTable(QString tableName);

    QString database() const;
    void setDatabase(QString databaseName);

    QAbstractItemModel* model() const;
    int count() const;
    Status status() const;
    void setStatus(Status status);
    QString filter() const;

    Q_INVOKABLE QVariantMap get(int index) const;
    // parser status
    void classBegin();
    void componentComplete();

    QString storageLocation() const;

public slots:
    void setFilter(QString filter);

signals:
    void tableChanged(QString table);
    void databaseChanged(QString database);
    void countChanged(int count);
    void statusChanged(Status status);
    void modelChanged(QObject* model);
    void filterChanged(QString arg);

private:
    void updateModel();
private:
    QString m_tableName;
    QString m_databaseName;
    QSqlDatabase m_database;
    SqlTableModel* m_model;
    Status m_status;
    QString m_filter;
    bool m_componentCompleted;
};

#endif // SQLTABLEDATASOURCE_H

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

#ifndef SCREENMANAGER_H
#define SCREENMANAGER_H

#include <QtCore/QObject>
#include <QWindow>

class ScreenManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QList<QScreen*> availableScreens READ availableScreens NOTIFY availableScreensChanged)

public:
    explicit ScreenManager(QObject *parent = 0);

    Q_INVOKABLE int screenCount() const;
    Q_INVOKABLE void setScreen(QWindow * window, int screen);
    QList<QScreen*> availableScreens() const;

signals:
    void availableScreensChanged();
};

#endif // SCREENMANAGER_H

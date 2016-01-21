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

pragma Singleton
import QtQuick 2.0
import service.settings 1.0

Item {
    id: root

    property string clusterTitle: ""
    property int pageIndicatorSize: 3
    property int currentPage: 0

    property var indicators: [
        { name: "battery", active: true },
        { name: "wifi",  active: true },
        { name: "break", active: false },
        { name: "bluetooth", active: SettingsService.bluetoothOption.active }
    ]

    property var currentDate: new Date();

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            currentDate = new Date();
        }
    }

    visible: false
}

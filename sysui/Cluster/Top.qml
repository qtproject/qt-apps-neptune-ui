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

import QtQuick 2.1
import utils 1.0
import controls 1.0
import service.climate 1.0
import service.settings 1.0
import service.statusbar 1.0

Item {
    width: background.width
    height: background.height

    Behavior on y {
        NumberAnimation { duration: 200}
    }

    Image {
        id: background
        source: Style.gfx("cluster/top_bar")
        Tracer {}
    }

    Label {
        id: timeText
        anchors.verticalCenter: background.verticalCenter
        anchors.left: background.left
        anchors.verticalCenterOffset: 0
        anchors.leftMargin: 162

        font.pixelSize: 37
        font.bold: true

        text: Qt.formatTime(StatusBarService.currentDate, SettingsService.clockOption.format)
    }

    Item {
        anchors.verticalCenter: background.verticalCenter
        anchors.horizontalCenter: background.horizontalCenter

        Row {
            id: row
            property int radius: 7
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -16
            spacing: 8

            Repeater {
                model: StatusBarService.pageIndicatorSize
                delegate: Rectangle {
                    height: row.radius * 2
                    width: row.radius * 2
                    radius: row.radius
                    color: StatusBarService.currentPage === index ? Style.colorWhite : "#4d4d4d"
                }
            }
        }

        Label {
            id: navText

            anchors.centerIn: parent
            anchors.verticalCenterOffset: 17
            horizontalAlignment: Text.AlignHCenter
            text: StatusBarService.clusterTitle
            font.pixelSize: 32
        }
    }

    Label {
        id: temperatureText
        anchors.verticalCenter: background.verticalCenter
        anchors.left: background.right
        anchors.verticalCenterOffset: 0
        anchors.leftMargin: -248

        font.pixelSize: 37

        text: ClimateService.outsideTempText
    }

    //Component.onCompleted: layoutTarget = navText
}

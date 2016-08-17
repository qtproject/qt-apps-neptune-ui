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

import QtQuick 2.1
import utils 1.0
import controls 1.0
import service.climate 1.0
import service.settings 1.0
import service.statusbar 1.0

Item {
    width: 0.37 * Style.clusterWidth
    height: 0.12 * Style.clusterHeight

    Behavior on y {
        NumberAnimation { duration: 200}
    }

    Image {
        id: background
        width: parent.width
        height: parent.height
        source: Style.gfx("cluster/top_bar")
        Tracer {}
    }

    Label {
        id: timeText
        anchors.verticalCenter: background.verticalCenter
        anchors.left: background.left
        anchors.leftMargin: 0.2 * background.width

        font.pixelSize: 0.42 * background.height
        font.bold: true

        text: Qt.formatTime(StatusBarService.currentDate, SettingsService.clockOption.format)
    }

    Item {
        id: navigator

        width: 0.25 * background.width
        height: background.height
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

            width: parent.width
            height: parent.height - row.height
            anchors.top: row.bottom
            horizontalAlignment: Text.AlignHCenter
            text: StatusBarService.clusterTitle
            font.pixelSize: 0.32 * background.height
        }
    }

    Label {
        id: temperatureText
        anchors.verticalCenter: background.verticalCenter
        anchors.left: navigator.right
        anchors.leftMargin: 15

        font.pixelSize: 0.42 * background.height
        font.bold: true

        text: ClimateService.outsideTempText
    }

    //Component.onCompleted: layoutTarget = navText
}

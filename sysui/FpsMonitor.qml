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
import QtApplicationManager 1.0


Rectangle {
    id: root
    color: "white"

    property int currentFps: 0

    Connections {
        target: SystemMonitor
        onFpsReportingChanged: { root.currentFps = Math.floor(average) }
    }

    onVisibleChanged: {
        SystemMonitor.reportingInterval = 200
        SystemMonitor.reportingRange = 10 * 1000
        SystemMonitor.fpsReportingEnabled = visible
        SystemMonitor.cpuLoadReportingEnabled = visible
    }

    Item {
        id: yscale
        width: childrenRect.width
        height: parent.height

        Text {
            anchors {
                right: parent.right
                top: parent.top
                topMargin: parent.height / 8 * 2
            }
            text: "60"
        }
        Text {
            anchors {
                bottom: yscale.bottom
                right: parent.right
            }
            text: "0"
        }
    }

    Rectangle {
        id: ybar
        width: 1
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: yscale.right
            leftMargin: 4
        }
        color: "black"
    }

    ListView {
        id: graph
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            left: ybar.right
            leftMargin: 4
        }

        model: SystemMonitor
        orientation: ListView.Horizontal
        interactive: false

        delegate: Item {
            width: graph.width / graph.model.count
            height: graph.height
            Rectangle {
                width: parent.width
                height: (model.averageFps/80)*parent.height
                anchors.bottom: parent.bottom
                color: "yellow"
            }
            Rectangle {
                width: parent.width
                y: parent.height - (model.minimumFps/80)*parent.height
                height: 2
                color: "red"
                opacity: 0.5
            }
            Rectangle {
                width: parent.width
                y: parent.height - (model.maximumFps/80)*parent.height
                height: 2
                color: "green"
                opacity: 0.5
                visible: model.maximumFps < 80
            }
            Rectangle {
                width: parent.width
                height: (model.cpuLoad * parent.height)
                anchors.top: parent.top
                color: "blue"
            }
        }
        Text {
            id: currentFps
            anchors.centerIn: parent
            text: root.currentFps + " fps"
            font.italic: true
            font.pixelSize: parent.height / 6
        }
    }
}



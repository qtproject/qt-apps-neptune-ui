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

import QtQuick 2.6
import QtQuick.Controls 2.2
import utils 1.0
import controls 1.0
import QtApplicationManager 1.0

UIPage {
    id: root

    onVisibleChanged: {
        if (!visible)
            applicationModel.model = undefined
        else
            applicationModel.model = ApplicationManager
        if (!SystemMonitor.memoryReportingEnabled && visible)
            SystemMonitor.memoryReportingEnabled = true
    }

    Item {
        id: processContainer
        width: root.width/2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: root.height/4

        ListView {
            id: applicationModel
            anchors.fill: parent
            clip: true
            spacing: 5

            delegate: ListView {
                id: processGraph
                height: processContainer.height/4 - 10
                width: processContainer.width

                property string appId: applicationId
                property bool reportingActive: ApplicationManager.get(index).isRunning
                property real pssMemoryUsed: 0
                property real memoryUsed: 0
                property real memoryUsagePercentage: 0

                model: processMon
                orientation: ListView.Horizontal
                interactive: false
                delegate: Item {
                    width: processGraph.width / processGraph.model.count
                    height: processGraph.height - 10

                    Rectangle {
                        objectName: "AppPanel::RectangleGray"
                        width: parent.width
                        height: parent.height // vmSize referent point
                        anchors.bottom: parent.bottom
                        color: Style.colorGrey
                        opacity: 0.8
                    }

                    Rectangle {
                        objectName: "AppPanel::RectangleGreen"
                        width: parent.width
                        height: (memoryRss.total/memoryVirtual.total)*parent.height
                        anchors.bottom: parent.bottom
                        color: "green"
                    }

                    Rectangle {
                        objectName: "AppPanel::RectangleOrange"
                        width: parent.width
                        height: (memoryPss.total/memoryVirtual.total)*parent.height
                        anchors.bottom: parent.bottom
                        color: Style.colorOrange
                    }

                    Rectangle {
                        objectName: "AppPanel::RectangleYellow"
                        width: parent.width
                        height: (memoryVirtual.heap/memoryVirtual.total)*parent.height
                        anchors.bottom: parent.bottom
                        color: "yellow"
                    }
                }

                ProcessMonitor {
                    id: processMon
                    applicationId: processGraph.appId
                    reportingInterval: 1000
                    memoryReportingEnabled: processGraph.reportingActive

                    onMemoryReportingChanged: {
                        processGraph.memoryUsagePercentage = (memoryVirtual.total/SystemMonitor.totalMemory * 100).toFixed(1)
                        processGraph.memoryUsed = (memoryVirtual.total/1e6).toFixed(1)
                        processGraph.pssMemoryUsed = (memoryPss.total/1e6).toFixed(1)
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 2
                    anchors.bottom: parent.bottom
                    color: Style.colorWhite
                }

                Label {
                    width: processGraph.width - processGraph.width/3
                    anchors.top: processGraph.top

                    anchors.right: processGraph.right
                    text: applicationId + " VSize: " + processGraph.memoryUsed + "MB, " + processGraph.memoryUsagePercentage + "%\nPSS: " + processGraph.pssMemoryUsed + "MB"
                    font.pixelSize: Style.fontSizeXXS
                }
            }
        }
    }

    Column {
        anchors.top: parent.top
        anchors.topMargin: root.height/4
        anchors.left: parent.left
        anchors.leftMargin: 80

        Label {
            id: vmText
            objectName: "AppPanel::VMText"
            text: "VMemory-ref point"
            font.pixelSize: Style.fontSizeXXS
            color: Style.colorGrey
        }

        Label {
            id: rssText
            objectName: "AppPanel::RSSText"
            text: "RSS"
            color: "green"
            font.pixelSize: Style.fontSizeXXS
        }

        Label {
            id: pssText
            objectName: "AppPanel::PSSText"
            text: "PSS"
            color: Style.colorOrange
            font.pixelSize: Style.fontSizeXXS
        }

        Label {
            id: heapText
            objectName: "AppPanel::HeapText"
            text: "Heap"
            color: "yellow"
            font.pixelSize: Style.fontSizeXXS
        }
    }

}

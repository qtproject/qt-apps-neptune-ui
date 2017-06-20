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

import QtQuick 2.0
import QtQuick.Controls 2.2
import utils 1.0
import controls 1.0
import QtApplicationManager 1.0

UIPage {
    id: root

    property bool mergeReport: false

    onVisibleChanged: {
        SystemMonitor.cpuLoadReportingEnabled = visible
        SystemMonitor.fpsReportingEnabled = visible
        if (!SystemMonitor.memoryReportingEnabled)
            SystemMonitor.memoryReportingEnabled = true
    }

    Connections {
        target: SystemMonitor
        onFpsReportingChanged: {
            redLegend.text = "Minimum FPS: " + Math.floor(minimum)
            greenLegend.text = "Maximum FPS: " + Math.floor(maximum)
            yellowLegend.text = "Average FPS: " + Math.floor(average)
        }

        onCpuLoadReportingChanged: {
            whiteLegend.text = "CPU load: " + (load * 100).toFixed(2) + "%"
        }

        onMemoryReportingChanged: {
            greyLegend.text = "RAM load:" + (used/SystemMonitor.totalMemory * 100).toFixed(2) + "%"
        }
    }

    CPUGraph {
        id: cpuContainer
        width: root.width/2
        height: root.mergeReport ? 0 : root.height/7
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: root.top
        anchors.topMargin: root.height/12
        opacity: root.mergeReport ? 0: 1

        Behavior on height {
            NumberAnimation { duration: 200 }
        }

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }

    MemoryGraph {
        id: memoryContainer
        width: root.width/2
        height: root.mergeReport ? 0 : root.height/7
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: cpuContainer.bottom
        anchors.topMargin: root.height/12
        opacity: root.mergeReport ? 0: 1

        Behavior on height {
            NumberAnimation { duration: 200 }
        }

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }


    Item {
        id: graphContainer
        width: root.width/2
        height: root.height/7
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: memoryContainer.bottom
        anchors.topMargin: root.height/12

        Item {
            id: fpsScaleContainer
            anchors.bottom: parent.bottom
            width: 5
            height: parent.height

            Rectangle {
                id: fpsScale
                width: 2
                height: parent.height
                color: Style.colorOrange
            }

            Label {
                width: 60
                anchors.bottom: fpsScale.bottom
                anchors.right: fpsScale.right
                text: "0"
                font.pixelSize: Style.fontSizeXS
            }

            Label {
                width: 60
                anchors.top: fpsScale.top
                anchors.topMargin: 0.25*fpsScale.height - height/2
                anchors.right: fpsScale.right
                text: "60"
                font.pixelSize: Style.fontSizeXS
            }

            Label {
                width: 60
                anchors.top: fpsScale.top
                anchors.topMargin: - height/2
                anchors.right: fpsScale.right
                text: "80"
                font.pixelSize: Style.fontSizeXS
            }
        }


        ListView {
            id: graph
            anchors.top: fpsScaleContainer.top
            anchors.right: graphContainer.right
            anchors.bottom: fpsScaleContainer.bottom
            anchors.left: fpsScaleContainer.right

            model: SystemMonitor
            orientation: ListView.Horizontal
            interactive: false
            delegate: Item {
                width: graph.width / graph.model.count
                height: graph.height

                Item {
                    id: fpsDelegate
                    anchors.fill: parent
                    visible: SystemMonitor.fpsReportingEnabled
                    opacity: 0.8

                    Rectangle {
                        width: parent.width
                        height: (model.averageFps/80)*parent.height
                        anchors.bottom: parent.bottom
                        color: Style.colorOrange
                    }

                    Rectangle {
                        width: parent.width
                        y: parent.height - (model.minimumFps/80)*parent.height
                        height: 3
                        color: "red"
                        opacity: 0.5
                    }

                    Rectangle {
                        id: valueContainer
                        width: parent.width
                        y: parent.height - (model.maximumFps/80)*parent.height
                        height: 3
                        color: "green"
                        opacity: 0.5
                        visible: model.maximumFps < 80
                    }
                }

                Item {
                    id: cpuDelegateInside
                    anchors.fill: parent
                    visible: root.mergeReport
                    opacity: 0.8

                    Rectangle {
                        width: parent.width
                        height: model.cpuLoad * parent.height
                        anchors.bottom: parent.bottom
                        color: "white"
                    }
                }

                Item {
                    id: memoryDelegateInside
                    anchors.fill: parent
                    visible: root.mergeReport
                    opacity: 0.6

                    Rectangle {
                        width: parent.width
                        height: (model.memoryUsed/model.memoryTotal)*parent.height
                        anchors.bottom: parent.bottom
                        color: Style.colorGrey
                    }
                }
            }
        }

        Rectangle {
            width: graph.width + 5
            height: 2

            anchors.top: graph.bottom
            anchors.left: graph.left
            anchors.leftMargin: -5
            color: Style.colorOrange
        }

        Label {
            id: redLegend
            width: graph.width/5
            anchors.top: graph.bottom
            anchors.left: graph.left
            anchors.leftMargin: -10
            text: "Min FPS"
            font.pixelSize: Style.fontSizeXS
            color: "red"
        }

        Label {
            id: greenLegend
            width: graph.width/5
            anchors.top: graph.bottom
            anchors.left: redLegend.right
            anchors.leftMargin: -10
            text: "Max FPS"
            font.pixelSize: Style.fontSizeXS
            color: "green"
        }

        Label {
            id: yellowLegend
            width: graph.width/5
            anchors.top: graph.bottom
            anchors.left: greenLegend.right
            anchors.leftMargin: -10
            text: "Average FPS"
            font.pixelSize: Style.fontSizeXS
            color: Style.colorOrange
        }

        Label {
            id: whiteLegend
            width: graph.width/5
            anchors.top: graph.bottom
            anchors.left: yellowLegend.right
            anchors.leftMargin: -10
            text: "CPU load: "
            font.pixelSize: Style.fontSizeXS
            color: "white"
        }

        Label {
            id: greyLegend
            width: graph.width/5
            anchors.top: graph.bottom
            anchors.left: whiteLegend.right
            anchors.leftMargin: -10
            text: "RAM load: "
            font.pixelSize: Style.fontSizeXS
            color: Style.colorGrey
        }

    }

    Rectangle {
        id: rotatingBox
        width: 60
        height: 60
        anchors.top: root.top
        anchors.topMargin: 50
        anchors.left: root.left
        anchors.leftMargin: 150
        color: "white"

        RotationAnimation {
            id: animator
            target: rotatingBox;
            from: 0;
            to: 360;
            loops: Animation.Infinite
            duration: 1000
            running: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: animator.running = !animator.running
        }
    }

    Button {
        width: Style.hspan(3)
        anchors.left: parent.left
        anchors.leftMargin: 100
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        text: "Merge Report"
        onClicked: root.mergeReport = !root.mergeReport
    }
}

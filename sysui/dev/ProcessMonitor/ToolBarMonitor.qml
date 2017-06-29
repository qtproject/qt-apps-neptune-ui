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
import QtQuick.Window 2.2
import controls 1.0
import utils 1.0
import QtApplicationManager 1.0
import models.application 1.0

Rectangle {
    id: root

    anchors.fill: parent
    clip: true
    color: "#273033"
    opacity: 0.95

    property int currentFps: 0
    property int ram: 0
    property real ramUsed: 0
    property int cpu: 0
    property var rootWindow
    property var applicationWindows: []
    property int reportingInterval: 1000
    property int modelCount: 12

    onVisibleChanged: initialize()

    Component.onCompleted: initialize()

    function initialize() {
        SystemMonitor.reportingInterval = root.reportingInterval
        SystemMonitor.count = root.modelCount
        SystemMonitor.cpuLoadReportingEnabled = root.visible
        root.rootWindow = Window.window
    }

    function getApplicationWindows() {
        root.applicationWindows = []
        if (ApplicationManagerModel.activeAppId === "")
            return
        for (var i = 0; i < WindowManager.count; i++) {
            if (WindowManager.get(i).applicationId === ApplicationManagerModel.activeAppId)
                root.applicationWindows.push(WindowManager.get(i).windowItem)
        }
    }

    Connections {
        target: SystemMonitor
        onCpuLoadReportingChanged: root.cpu = (load * 100).toFixed(0)
    }

    ProcessMonitor {
        id: processMon
        applicationId: ApplicationManagerModel.activeAppId
        reportingInterval: root.reportingInterval
        count: root.modelCount

        memoryReportingEnabled: root.visible
        frameRateReportingEnabled: root.visible
        monitoredWindows: (applicationId === "" || ApplicationManager.singleProcess) ? [root.rootWindow] : root.applicationWindows
        onMemoryReportingChanged: {
            root.ram = (memoryPss.total/SystemMonitor.totalMemory * 100).toFixed(0)
            root.ramUsed = (memoryPss.total / 1e6).toFixed(0);
        }
        onFrameRateReportingChanged: {
            fpsMonitor.valueText = ""
            for (var i in frameRate) {
                fpsMonitor.valueText += "|"
                fpsMonitor.valueText += frameRate[i].average.toFixed(0)
                fpsMonitor.valueText += "|"
            }
        }
        onApplicationIdChanged: getApplicationWindows()
    }

    Row {
        FpsMonitor {
            id: fpsMonitor
            model: processMon
        }

        Rectangle {
            width: 2
            height: root.height
            color: "#4d4d4d"
        }

        CpuMonitor {
            valueText: root.cpu + "%"
        }

        Rectangle {
            width: 2
            height: root.height
            color: "#4d4d4d"
        }

        RamMonitor {
            model: processMon
            valueText: root.ram + "% " + root.ramUsed + "MB"
        }
    }
}

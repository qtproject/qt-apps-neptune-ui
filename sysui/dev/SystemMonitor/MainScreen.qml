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

import QtQuick 2.0
import utils 1.0
import controls 1.0
import QtApplicationManager 1.0
import models 1.0

UIScreen {
    id: root

    property int timeInterval: 200

    Component.onCompleted: checkReporting()

    onBackScreen: {
        SystemMonitor.cpuLoadReportingEnabled = false
        SystemMonitor.fpsReportingEnabled = false
        SystemMonitor.memoryReportingEnabled = false
        ApplicationManagerInterface.releaseApplicationSurface(root)
    }

    function checkReporting() {
        SystemMonitor.reportingInterval = root.timeInterval
        SystemMonitor.count = 50
    }

    TabView {
        id: tabView
        vspan: root.vspan - 3
        hspan: root.hspan
        anchors.centerIn: parent
        horizontalAlignment: true
        tabWidth: 5
        tabs: [
            { title : "Info", url : infoPanel, properties : {} },
            { title : "CPU/FPS", url : systemPanel, properties : {} },
            { title : "RAM", url : appPanel, properties : {} },
        ]

    }

    InfoPanel {
        id: infoPanel
        visible: false

    }

    SystemPanel {
        id: systemPanel
        visible: false
    }

    AppPanel {
        id: appPanel
        visible: false
    }
}

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

import controls 1.0
import utils 1.0
import climate 1.0
import statusbar 1.0
import notification 1.0
import popup 1.0
import windowoverview 1.0

import models.system 1.0
import models.startup 1.0

Item {
    id: root

    width: 1280
    height: 800

    // Content Elements
    StatusBar {
        id: statusBar
    }

    StageLoader {
        id: launcherControllerLoader
        width: Style.screenWidth
        height: Style.vspan(20)
        anchors.top: statusBar.bottom
        active: StagedStartupModel.loadRest
        source: "LaunchController.qml"
        onLoaded: menuScreenLoader.active = true
    }

    StageLoader {
        id: menuScreenLoader
        anchors.top: statusBar.bottom
        width: Style.hspan(24)
        height: Style.vspan(19)
        asynchronous: false
        source: "MenuScreen.qml"
        onLoaded: {
            homePage.anchors.topMargin = 0
            menuScreenLoader.item.homePage = homePage
            launcherControllerLoader.item.homePage = menuScreenLoader.item
            StagedStartupModel.enterFinalState()
        }
    }

    HomePage {
        id: homePage
        anchors.top: parent.top
        anchors.topMargin: statusBar.height
        opacity: 0

        OpacityAnimator {
            target: homePage;
            from: 0;
            to: 1;
            duration: 1000
            running: true
        }
    }

    // Background Elements
    StageLoader {
        id: aboutLoader
        width: Style.screenWidth
        height: Style.vspan(20)
        active: StagedStartupModel.loadBackgroundElements
        source: "About.qml"
    }

    StageLoader {
        id: settingsLoader
        anchors.top: statusBar.bottom
        active: StagedStartupModel.loadBackgroundElements
        source: "../settings/Settings.qml"
    }

    ClimateBar {
    }

    StageLoader {
        id: toolBarMonitorLoader
        width: parent.width
        height: 200
        anchors.bottom: parent.bottom
        active: SystemModel.toolBarMonitorVisible
        source: "../dev/ProcessMonitor/ToolBarMonitor.qml"
    }

    StageLoader {
        id: windowOverviewLoader
        anchors.fill: parent
        active: StagedStartupModel.loadBackgroundElements
        source: "../windowoverview/WindowOverview.qml"
    }

    StageLoader {
        id: popupContainerLoader
        width: Style.popupWidth
        height: Style.popupHeight
        anchors.centerIn: parent
        active: StagedStartupModel.loadBackgroundElements
        source: "../popup/PopupContainer.qml"
    }

    StageLoader {
        id: notificationContainerLoader
        width: Style.screenWidth
        height: Style.vspan(2)
        active: StagedStartupModel.loadBackgroundElements
        source: "../notification/NotificationContainer.qml"
    }

    StageLoader {
        id: notificationCenterLoader
        width: Style.isPotrait ? Style.hspan(Style.notificationCenterSpan + 5) : Style.hspan(12)
        height: Style.screenHeight - Style.statusBarHeight
        anchors.top: statusBar.bottom
        active: StagedStartupModel.loadBackgroundElements
        source: "../notification/NotificationCenter.qml"
    }

    StageLoader {
        id: keyboardLoader
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        active: StagedStartupModel.loadBackgroundElements
        source: "../keyboard/Keyboard.qml"
    }

    Component.onCompleted: StagedStartupModel.enterMenuState()
}

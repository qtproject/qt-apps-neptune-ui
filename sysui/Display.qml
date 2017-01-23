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
import QtGraphicalEffects 1.0

import controls 1.0
import utils 1.0
import "Climate"
import "StatusBar"

Item {
    id: root

    width: 1280
    height: 800

    // Background Elements

    // Content Elements


    StatusBar {
        id: statusBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: Style.vspan(2)
        onClicked: {
            if (climateBar.expanded) {
                climateBar.expanded = false
            } else {
                root.state = "statusBarExpanded"
            }
        }
        onTimePressAndHold: toolBarMonitorLoader.active = !toolBarMonitorLoader.active
        onOverviewClicked: windowOverview.show()
    }


    LaunchController {
        id: launcher
        anchors.top: statusBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Style.vspan(climateBar.collapsedVspan)
        initialItem: Qt.resolvedUrl('MenuScreen.qml')
    }

    FastBlur {
        id: fastBlur
        anchors.fill: launcher
        source: launcher
        radius: 0
        visible: !launcher.visible
        enabled: visible
    }

    About {
        id: about
        anchors.bottom: parent.top; anchors.bottomMargin: height
        anchors.left: parent.left; anchors.right: parent.right
        height: Style.vspan(20)
        onClicked: {
            if (climateBar.expanded) {
                climateBar.expanded = false
            } else {
                root.state = ""
            }
        }
    }

    // Foreground Elements

    ClimateBar {
        id: climateBar
        height: Style.vspan(24) - statusBar.height
        y: expanded ? statusBar.height : root.height - Style.vspan(climateBar.collapsedVspan)
        anchors.left: parent.left
        anchors.right: parent.right

        Behavior on y {
            NumberAnimation { duration: 450; easing.type: Easing.OutCubic}
        }
    }

    Loader {
        id: toolBarMonitorLoader
        width: parent.width
        height: 200
        anchors.bottom: parent.bottom
        active: false
        source: "dev/ToolBarMonitor.qml"
    }

    WindowOverview {
        id: windowOverview
        anchors.fill: parent
    }

    NotificationContainer {
        id: notificationContainer

        anchors.centerIn: parent
    }

    Loader {
        id: keyboardLoader
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        source: "Keyboard.qml"
    }

    // States and Transitions

    states: [
        State {
            name: "statusBarExpanded"
            PropertyChanges { target: about; anchors.bottomMargin: -about.height }
            PropertyChanges { target: launcher; visible: false }
            PropertyChanges { target: fastBlur; radius: 100 }
        }
    ]

    transitions: [
        Transition {
            from: ""; to: "statusBarExpanded"
            ParallelAnimation {
                NumberAnimation { target: about; property: "anchors.bottomMargin"; duration: 500; easing.type: Easing.OutCubic }
                NumberAnimation { target: fastBlur; property: "radius"; duration: 200 }
            }
        },

        Transition {
            from: "statusBarExpanded"; to: ""
            SequentialAnimation {
                ParallelAnimation {
                    PropertyAction { target: launcher; property: "visible"; value: false }
                    NumberAnimation { target: fastBlur; property: "radius"; duration: 200 }
                    NumberAnimation { target: about; property: "anchors.bottomMargin"; duration: 500 }
                }
                PropertyAction { target: launcher; property: "visible"; value: true }
            }
        }
    ]
}

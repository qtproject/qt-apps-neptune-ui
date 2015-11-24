/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
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
import QtGraphicalEffects 1.0

import controls 1.0
import utils 1.0
import "Climate"
import "StatusBar"

Item {
    id: root

    // Background Elements

    // Content Elements

    Component {
        id: topMenu
        MenuScreen {
        }
    }

    Item {
        id: content

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: Style.vspan(24-3)

        LaunchController {
            id: launcher
            width: Style.hspan(24)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: statusBar.bottom
            anchors.bottom: parent.bottom
            initialItem: topMenu
        }


        StatusBar {
            id: statusBar
            anchors.left: parent.left
            anchors.right: parent.right
            vspan: 2
            onClicked: {
                if (climateBar.expanded) {
                    climateBar.expanded = false
                } else {
                    root.state = "statusBarExpanded"
                }
            }

            Loader {
                anchors.centerIn: parent
                width: Style.hspan(8); height: Style.vspan(2)
                sourceComponent: launcher.currentItem ? launcher.currentItem.statusItem : undefined
            }
        }
    }

    FastBlur {
        id: fastBlur
        anchors.fill: content
        source: content
        radius: 0
        visible: !content.visible
        enabled: visible
    }

    About {
        id: about
        anchors.bottom: parent.top; anchors.bottomMargin: height
        anchors.left: parent.left; anchors.right: parent.right
        vspan: 20
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
        vspan: 24-statusBar.vspan
        y: expanded ? Style.vspan(statusBar.vspan) : root.height - Style.vspan(collapsedVspan)
        anchors.left: parent.left
        anchors.right: parent.right

        Behavior on y {
            NumberAnimation { duration: 450; easing.type: Easing.OutCubic}
        }
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
            PropertyChanges { target: about; anchors.bottomMargin: -Style.vspan(about.vspan) }
            PropertyChanges { target: content; visible: false }
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
                    PropertyAction { target: content; property: "visible"; value: false }
                    NumberAnimation { target: fastBlur; property: "radius"; duration: 200 }
                    NumberAnimation { target: about; property: "anchors.bottomMargin"; duration: 500 }
                }
                PropertyAction { target: content; property: "visible"; value: true }
            }
        }
    ]
}

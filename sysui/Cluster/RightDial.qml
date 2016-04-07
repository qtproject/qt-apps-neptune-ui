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
import service.vehicle 1.0
import service.navigation 1.0

Item {
    id: root
    width: 570
    height: 720

    scale: zoom ? 0.7 : 1
    property bool zoom: false
    property int angle: zoom ? -45 : 0

    Behavior on angle {
        NumberAnimation { duration: 200 }
    }

    Behavior on x {
        NumberAnimation { duration: 200 }
    }

    Behavior on scale {
        NumberAnimation { duration: 200 }
    }

    transform: Rotation { origin.x: root.width/2; origin.y: root.height/2; axis { x: 0; y: 1; z: 0 } angle: root.angle }

    Item {
        width: parent.width/3
        height: 50
        anchors.bottom: overlay.top
        anchors.left: parent.left
        anchors.leftMargin: 110
        Image {
            id: gears
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            source: Style.gfx("cluster/P-R-N-D")

        }

        Image {
            id: plusMinus
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 50
            source: Style.gfx("cluster/+--")
        }
        Tracer {}
    }

    Image {
        id: overlay
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.topMargin: 120

        source: Style.gfx("cluster/right_dial")

        Rectangle {
            id: rect
            width: circle.width + 5
            height: width
            radius: width
            color: "transparent"
            border.color: (VehicleService.fuel < 0.4 || NavigationService.traficAlert) ? Style.colorOrange : "white"
            border.width: rect.borderWidth
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -3

            property int borderWidth: 3

            SequentialAnimation {
                running: (VehicleService.fuel < 0.4 || NavigationService.traficAlert)
                loops: Animation.Infinite
                NumberAnimation {

                    target: rect
                    properties: "borderWidth"
                    from: 3
                    to: 7
                    duration: 500
                }

                NumberAnimation {

                    target: rect
                    properties: "borderWidth"
                    from: 7
                    to: 3
                    duration: 500
                }

                onStopped: rect.borderWidth = 3

            }
        }

        Image {
            id: circle
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -6
            anchors.verticalCenterOffset: 0
            source: Style.gfx("cluster/middle-bkg")

            Image {
                id: circle_overlay
                anchors.centerIn: parent
                source: Style.gfx("cluster/middle-circle")
            }

            Image {
                id: fuelSymbol
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 5
                source: VehicleService.rightDialIcon
                scale: VehicleService.rightIconScale
            }

            Item {
                width: parent.width
                height: parent.height/2
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 40

                Rectangle {
                    id: speedText
                    width: parent.width - 80
                    height: 40
                    radius: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.darker("grey", 1.5) }
                        GradientStop { position: 0.4; color: "#0c0c0c" }
                    }

                    Label {
                        width: 100
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 36
                        font.bold: true
                        //font.letterSpacing: 2
                        color: Style.colorWhite
                        text: VehicleService.rightDialMainText
                    }

                }
                Label {
                    id: infoText
                    anchors.top: speedText.bottom
                    anchors.topMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter

                    font.pixelSize: 24
                    //font.letterSpacing: 2
                    color: Style.colorWhite
                    horizontalAlignment: Text.AlignHCenter
                    text: VehicleService.rightDialSubText
                }
            }
        }
    }

    Fuel {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -50
    }

    Dial {
        id: dial
        anchors.centerIn: overlay
        anchors.verticalCenterOffset: 3
        anchors.horizontalCenterOffset: 2
        fillImage: "cluster/dial_fill_color"
        circleRadius: "0.28"
        dialCursor: "cluster/dial_cursor_right"
        value: VehicleService.rightDialValue

    }

    Tracer {}
}

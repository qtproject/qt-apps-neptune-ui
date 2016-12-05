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
import models 1.0
import service.navigation 1.0

Item {
    id: root

    width: 0.8 * Style.clusterHeight
    height: Style.clusterHeight

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
        width: root.width/3
        height: 0.1 * root.width
        anchors.bottom: overlay.top
        anchors.left: parent.left
        anchors.leftMargin: 0.2 * root.width

        Image {
            id: gears

            width: 0.2 * root.width
            height: 0.25 * width
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            source: Style.gfx("cluster/P-R-N-D")
        }

        Image {
            id: plusMinus
            anchors.bottom: parent.bottom
            anchors.left: gears.right
            anchors.leftMargin: 10
            source: Style.gfx("cluster/+--")
        }
    }

    Image {
        id: overlay

        width: 0.91 * root.width
        height: 0.99 * width

        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.verticalCenter: parent.verticalCenter
        source: Style.gfx("cluster/right_dial")

        Rectangle {
            id: rect
            width: circle.width + 5
            height: width
            radius: width
            color: "transparent"
            border.color: VehicleModel.rightDialBorderColor
            border.width: rect.borderWidth
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -3

            property int borderWidth: 3

            SequentialAnimation {
                running: VehicleModel.warningDialAnimation
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

            width: root.width/2
            height: width
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -6
            anchors.verticalCenterOffset: 0
            source: Style.gfx("cluster/middle-bkg")

            Image {
                id: circle_overlay

                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                source: Style.gfx("cluster/middle-circle")
            }

            Image {
                id: fuelSymbol
                anchors.top: parent.top
                anchors.topMargin: 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 5
                source: VehicleModel.rightDialIcon
                scale: VehicleModel.rightIconScale
            }

            Item {
                width: parent.width
                height: parent.height/4
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
                        width: parent.width
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: text.length > 10 ? Style.fontSizeS : Style.fontSizeM
                        font.bold: true
                        text: VehicleModel.rightDialMainText
                        elide: Text.ElideMiddle
                    }
                }
            }
        }
    }

    Fuel {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0.05 * root.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -20
    }

    Dial {
        id: dial

        width: 0.69 * root.height
        height: width
        anchors.centerIn: overlay
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: -5
        fillImage: "cluster/dial_fill_color"
        circleRadius: "0.29"
        dialCursor: "cluster/dial_cursor_right"
        value: VehicleModel.rightDialValue
    }
}

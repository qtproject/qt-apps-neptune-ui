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
import QtGraphicalEffects 1.0
import utils 1.0
import service.vehicle 1.0

Item {
    id: root

    width: 570
    height: 720

    scale: zoom ? 0.7 : 1
    property bool zoom: false
    property int angle: zoom ? 45 : 0

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

    Image {
        id: overlay
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.topMargin: 120

        source: Style.gfx("cluster/left_dial")

        Tracer {}
    }

    Text {
        id: speedText

        anchors.verticalCenter: overlay.verticalCenter
        anchors.horizontalCenter: overlay.horizontalCenter
        anchors.verticalCenterOffset: -7
        anchors.horizontalCenterOffset: 5
        font.family: Style.fontFamily
        font.pixelSize: 60
        font.letterSpacing: 4
        color: Style.colorWhite
        text: VehicleService.displaySpeed
    }

    Rectangle {
        width: 60
        height: 1
        opacity: 0.4
        anchors.top: speedText.bottom
        anchors.topMargin: -8
        anchors.horizontalCenter: overlay.horizontalCenter
        anchors.horizontalCenterOffset: 2
    }

    Text {
        id: mph
        anchors.top: speedText.bottom
        anchors.topMargin: -5
        anchors.horizontalCenter: overlay.horizontalCenter
        anchors.horizontalCenterOffset: 2
        font.family: Style.fontFamily
        font.pixelSize: 24
        color: Style.colorWhite
        text: "mph"
    }


//    Text {
//        id: travelled
//        anchors.verticalCenter: parent.verticalCenter
//        anchors.verticalCenterOffset: 130
//        anchors.horizontalCenter: overlay.horizontalCenter
//        anchors.horizontalCenterOffset: 2
//        font.family: Style.fontFamily
//        font.pixelSize: 24
//        color: Style.colorWhite
//        text: "-1531mi-"
//    }



    Dial {
        anchors.centerIn: overlay
        anchors.verticalCenterOffset: 2
        fillImage: "cluster/dial_fill_color_left"
        value: VehicleService.speed / 240

        Tracer {}
    }
}

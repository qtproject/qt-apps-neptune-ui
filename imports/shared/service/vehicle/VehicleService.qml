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

pragma Singleton
import QtQuick 2.0
import utils 1.0

QtObject {
    id: root

    property bool dialAnimation: true
    property real speed: 0


    Behavior on speed {
        SmoothedAnimation {
            velocity: 6
            duration : 5000
            easing.overshoot: 0
        }
    }

    readonly property real rightDialValue: root.speed * 0.0061

    property int displaySpeed: speed
    property real fuel: 0.5 // fuel precentage min 0.0; max 1.0;
    property string rightDialIcon: Style.gfx("cluster/my_position")
    property string rightDialMainText: "0.6mi"
    property string rightDialSubText: "Service in\n200mi"
    property real rightIconScale: 1
    property var gasStationEvent
    property bool gasStationUpdateActive: false
    property Timer fuelTimer: Timer {
        interval: 5000
        onTriggered: {
            root.fuel = 0.2
            root.rightDialIcon = Style.gfx("livedrive/fuel_orange")
            root.rightIconScale = 1.4
            root.rightDialMainText = "Low Fuel"
            root.rightDialSubText = "Estimation: 5mi"
            if (root.gasStationEvent) {
                root.gasStationEvent.priority = 1
                fuelEventTimer.start()
            }
        }
    }

    property Timer fuelEventTimer: Timer {
        interval: 4000
        onTriggered: {
            root.rightDialIcon = Style.gfx("livedrive/fuel_orange")
            root.rightIconScale = 1.4
            root.rightDialMainText = root.gasStationEvent.distanceFromStart + "m"
            root.rightDialSubText = "SHELL\n2$/Gl"
            root.gasStationUpdateActive = true
        }
    }

    property Timer timer: Timer {
        running: root.dialAnimation
        repeat: true
        interval: 4000
        property bool higherValue: false
        onTriggered: {
            root.speed = higherValue ? (0) : (120)
            higherValue = !higherValue
        }
    }

}

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

pragma Singleton
import QtQuick 2.0

QtObject {
    id: root

    property QtObject leftSeat: QtObject {
        property real minValue: 16
        property real maxValue: 28
        property real stepValue: 0.5
        property real value: 21.5

        property bool heat: false
    }

    property QtObject rightSeat: QtObject {
        property real minValue: 16
        property real maxValue: 28
        property real stepValue: 0.5
        property real value: 21.5

        property bool heat: false
    }

    property QtObject frontHeat: QtObject {
        property string symbol: "front"
        property bool enabled: true
    }

    property QtObject rearHeat: QtObject {
        property string symbol: "rear"
        property bool enabled: true
    }

    property QtObject airCondition: QtObject {
        property string symbol: "ac"
        property bool enabled: false
    }

    property QtObject airQuality: QtObject {
        property string symbol: "air_quality"
        property bool enabled: false
    }

    property QtObject eco: QtObject {
        property string symbol: "eco"
        property bool enabled: false
    }

    property QtObject steeringWheelHeat: QtObject {
        property string symbol: "stearing_wheel"
        property bool enabled: false
    }

    property var climateOptions: [frontHeat, rearHeat, airCondition, airQuality, eco, steeringWheelHeat]

    property int ventilation: 2
    property int ventilationLevels: 7 // 6 + off (0)
    onVentilationChanged: console.log("Ventilation changed: " + ventilation)
}

/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
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
import QtIVIVehicleFunctions 1.0
import service.settings 1.0

QtObject {
    id: root

    property ClimateControl climateControl: ClimateControl {
        discoveryMode: ClimateControl.AutoDiscovery
    }

    property QtObject leftSeat: QtObject {
        property real minValue: calculateUnitValue(16)
        property real maxValue: calculateUnitValue(28)
        property real stepValue: calculateUnitValue(0.5)
        property real value: calculateUnitValue(climateControl.zoneAt.FrontLeft.targetTemperature.value)

        property bool heat: climateControl.zoneAt.FrontLeft.seatHeater

        onValueChanged: climateControl.zoneAt.FrontLeft.targetTemperature.value = value
        onHeatChanged: climateControl.zoneAt.FrontLeft.seatHeater = heat
    }

    property QtObject rightSeat: QtObject {
        property real minValue: calculateUnitValue(16)
        property real maxValue: calculateUnitValue(28)
        property real stepValue: calculateUnitValue(0.5)
        property real value: calculateUnitValue(climateControl.zoneAt.FrontRight.targetTemperature.value)

        property bool heat: climateControl.zoneAt.FrontRight.seatHeater

        onValueChanged: climateControl.zoneAt.FrontRight.targetTemperature.value = value
        onHeatChanged: climateControl.zoneAt.FrontRight.seatHeater = heat
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
        property bool enabled: climateControl.airConditioning.value

        onEnabledChanged: climateControl.airConditioning.value = enabled
    }

    property QtObject airQuality: QtObject {
        property string symbol: "air_quality"
        property bool enabled: climateControl.airRecirculation.value

        onEnabledChanged: climateControl.airRecirculation.value = enabled
    }

    property QtObject eco: QtObject {
        property string symbol: "eco"
        property bool enabled: false
    }

    property QtObject steeringWheelHeat: QtObject {
        property string symbol: "stearing_wheel"
        property bool enabled: climateControl.steeringWheelHeater.enabled

        onEnabledChanged: climateControl.steeringWheelHeater.enabled = enabled
    }

    property var climateOptions: [frontHeat, rearHeat, airCondition, airQuality, eco, steeringWheelHeat]

    property int outsideTemp: calculateUnitValue(15)
    property string outsideTempText: qsTr("%1" + tempSuffix).arg(outsideTemp)
    property int ventilation: climateControl.fanSpeedLevel.value
    property string tempSuffix: SettingsService.metric ? "°C" : "°F"
    property int ventilationLevels: 7 // 6 + off (0)
    onVentilationChanged: climateControl.fanSpeedLevel.value = ventilation

    function calculateUnitValue(value) {
        // Defualt value is the celsius
        return (SettingsService.unitSystem === "metric") ? value : (Math.round(value * 1.8 + 32))
    }
}

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
import QtIvi.VehicleFunctions 1.0
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

        property bool heat: climateControl.zoneAt.FrontLeft.seatHeater.value

        onValueChanged: climateControl.zoneAt.FrontLeft.targetTemperature.value = value
        onHeatChanged: climateControl.zoneAt.FrontLeft.seatHeater.value = heat
    }
    property Connections leftSeatTargetTempConnections: Connections {
        target: climateControl.zoneAt.FrontLeft.targetTemperature
        onValueChanged: leftSeat.value =
            calculateUnitValue(climateControl.zoneAt.FrontLeft.targetTemperature.value)
    }

    property QtObject rightSeat: QtObject {
        property real minValue: calculateUnitValue(16)
        property real maxValue: calculateUnitValue(28)
        property real stepValue: calculateUnitValue(0.5)
        property real value: calculateUnitValue(climateControl.zoneAt.FrontRight.targetTemperature.value)

        property bool heat: climateControl.zoneAt.FrontRight.seatHeater.value

        onValueChanged: climateControl.zoneAt.FrontRight.targetTemperature.value = value
        onHeatChanged: climateControl.zoneAt.FrontRight.seatHeater.value = heat
    }
    property Connections rightSeatTargetTempConnections: Connections {
        target: climateControl.zoneAt.FrontRight.targetTemperature
        onValueChanged: rightSeat.value =
            calculateUnitValue(climateControl.zoneAt.FrontRight.targetTemperature.value)
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

        onEnabledChanged: {
            climateControl.airConditioning.value = enabled;
            enabled = Qt.binding(function() { return climateControl.airConditioning.value; });
        }
    }

    property QtObject airQuality: QtObject {
        property string symbol: "air_quality"
        property bool enabled: climateControl.recirculationMode.value == ClimateControl.RecirculationOn

        onEnabledChanged: {
            climateControl.recirculationMode.value = enabled ? ClimateControl.RecirculationOn : ClimateControl.RecirculationOff;
            enabled = Qt.binding(function() { return climateControl.recirculationMode.value == ClimateControl.RecirculationOn });
        }
    }

    property QtObject eco: QtObject {
        property string symbol: "eco"
        property bool enabled: false
    }

    property QtObject steeringWheelHeat: QtObject {
        property string symbol: "stearing_wheel"
        property bool enabled: climateControl.steeringWheelHeater.value >= 5

        onEnabledChanged: {
            climateControl.steeringWheelHeater.value = enabled ? 10 : 0;
            enabled = Qt.binding(function() { return climateControl.steeringWheelHeater.value >= 5 });
        }
    }

    property var climateOptions: [frontHeat, rearHeat, airCondition, airQuality, eco, steeringWheelHeat]

    property int outsideTemp: calculateUnitValue(15)
    property string outsideTempText: qsTr("%1" + tempSuffix).arg(outsideTemp)
    property int ventilation: climateControl.fanSpeedLevel.value
    property string tempSuffix: SettingsService.metric ? "°C" : "°F"
    property int ventilationLevels: 7 // 6 + off (0)

    onVentilationChanged: climateControl.fanSpeedLevel.value = ventilation
    property Connections fanSpeedLevelConnections: Connections {
        target: climateControl.fanSpeedLevel
        onValueChanged: ventilation = climateControl.fanSpeedLevel.value
    }

    property QtObject stateMachine: ClimateStateMachine {
        climateControl: root.climateControl
        doorsOpen: eco.enabled // TODO use QtIVI doors/window state for this eventually
    }

    function calculateUnitValue(value) {
        // Defualt value is the celsius
        return (SettingsService.unitSystem === "metric") ? value : (Math.round(value * 1.8 + 32))
    }
}

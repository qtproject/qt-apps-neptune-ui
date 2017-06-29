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

pragma Singleton
import QtQuick 2.0
import QtIvi.VehicleFunctions 1.0
import models.settings 1.0

QtObject {
    id: root

    property string weatherIcon: "topbar_icon_rain"

    property ClimateControl climateControl: ClimateControl {
        discoveryMode: ClimateControl.AutoDiscovery
    }

    property QtObject leftSeat: QtObject {
        property real minValue: calculateUnitValue(16)
        property real maxValue: calculateUnitValue(28)
        property real stepValue: calculateUnitValue(0.5)
        property real value: calculateUnitValue(climateControl.zoneAt.FrontLeft.targetTemperature.value)

        property bool heat: climateControl.zoneAt.FrontLeft.seatHeater.value

        function setValue(newValue) {
            climateControl.zoneAt.FrontLeft.targetTemperature.value = newValue
        }

        function setHeat(newHeat) {
            climateControl.zoneAt.FrontLeft.seatHeater.value = newHeat
        }
    }

    property QtObject rightSeat: QtObject {
        property real minValue: calculateUnitValue(16)
        property real maxValue: calculateUnitValue(28)
        property real stepValue: calculateUnitValue(0.5)
        property real value: calculateUnitValue(climateControl.zoneAt.FrontRight.targetTemperature.value)

        property bool heat: climateControl.zoneAt.FrontRight.seatHeater.value

        function setValue(newValue) {
            climateControl.zoneAt.FrontRight.targetTemperature.value = newValue
        }

        function setHeat(newHeat) {
            climateControl.zoneAt.FrontRight.seatHeater.value = newHeat
        }
    }

    property QtObject frontHeat: QtObject {
        property string symbol: "front"
        property bool enabled: true

        function setEnabled(newEnabled) {
            enabled = newEnabled;
        }
    }

    property QtObject rearHeat: QtObject {
        property string symbol: "rear"
        property bool enabled: true

        function setEnabled(newEnabled) {
            enabled = newEnabled;
        }
    }

    property QtObject airCondition: QtObject {
        property string symbol: "ac"
        property bool enabled: climateControl.airConditioning.value

        function setEnabled(newEnabled) {
            climateControl.airConditioning.value = newEnabled;
        }
    }

    property QtObject airQuality: QtObject {
        property string symbol: "air_quality"
        property bool enabled: climateControl.recirculationMode.value == ClimateControl.RecirculationOn

        function setEnabled(newEnabled) {
            climateControl.recirculationMode.value = newEnabled ? ClimateControl.RecirculationOn : ClimateControl.RecirculationOff;
        }
    }

    property QtObject eco: QtObject {
        property string symbol: "eco"
        property bool enabled: false

        function setEnabled(newEnabled) {
            enabled = newEnabled;
        }
    }

    property QtObject steeringWheelHeat: QtObject {
        property string symbol: "stearing_wheel"
        property bool enabled: climateControl.steeringWheelHeater.value >= 5

        function setEnabled(newEnabled) {
            climateControl.steeringWheelHeater.value = newEnabled ? 10 : 0;
        }
    }

    property var climateOptions: [frontHeat, rearHeat, airCondition, airQuality, eco, steeringWheelHeat]

    property int outsideTemp: calculateUnitValue(15)
    property string outsideTempText: qsTr("%1" + tempSuffix).arg(outsideTemp)
    property int ventilation: climateControl.fanSpeedLevel.value
    property string tempSuffix: SettingsModel.metric ? "°C" : "°F"
    property int ventilationLevels: 7 // 6 + off (0)

    function setVentilation(newVentilation) {
        climateControl.fanSpeedLevel.value = newVentilation;
    }

    property QtObject airflowDirections: QtObject {
        property int directions: climateControl.airflowDirections.value
        property var availableDirections: climateControl.airflowDirections.availableValues
        onDirectionsChanged: climateControl.airflowDirections.value = directions
    }
    property Connections airflowDirectionsConnections: Connections {
        target: climateControl.airflowDirections
        onValueChanged: airflowDirections.directions = climateControl.airflowDirections.value
    }

    property QtObject stateMachine: ClimateStateMachine {
        climateControl: root.climateControl
        doorsOpen: eco.enabled // TODO use QtIVI doors/window state for this eventually
    }

    function calculateUnitValue(value) {
        // Defualt value is the celsius
        return (SettingsModel.unitSystem === "metric") ? value : (Math.round(value * 1.8 + 32))
    }
}

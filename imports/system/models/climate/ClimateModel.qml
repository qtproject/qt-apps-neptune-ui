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
        readonly property real minValue: 16
        readonly property real maxValue: 28
        readonly property real stepValue: 0.5
        readonly property real value: climateControl.zoneAt.FrontLeft.targetTemperature

        readonly property bool heat: climateControl.zoneAt.FrontLeft.seatHeater > 0

        function setValue(newValue) {
            climateControl.zoneAt.FrontLeft.targetTemperature = newValue
        }

        function setHeat(newHeat) {
            climateControl.zoneAt.FrontLeft.seatHeater = newHeat
        }

        // set some sane default value
        Component.onCompleted: {
            setValue(21);
        }
    }

    property QtObject rightSeat: QtObject {
        readonly property real minValue: 16
        readonly property real maxValue: 28
        readonly property real stepValue: 0.5
        readonly property real value: climateControl.zoneAt.FrontRight.targetTemperature

        readonly property bool heat: climateControl.zoneAt.FrontRight.seatHeater > 0

        function setValue(newValue) {
            climateControl.zoneAt.FrontRight.targetTemperature = newValue
        }

        function setHeat(newHeat) {
            climateControl.zoneAt.FrontRight.seatHeater = newHeat
        }

        // set some sane default value
        Component.onCompleted: {
            setValue(22.5);
        }
    }

    property QtObject frontHeat: QtObject {
        property string symbol: "front"
        readonly property bool enabled: climateControl.defrostEnabled

        function setEnabled(newEnabled) {
            climateControl.defrostEnabled = newEnabled;
        }
    }

    property QtObject rearHeat: QtObject {
        property string symbol: "rear"
        readonly property bool enabled: climateControl.heaterEnabled

        function setEnabled(newEnabled) {
            climateControl.heaterEnabled = newEnabled;
        }
    }

    property QtObject airCondition: QtObject {
        readonly property string symbol: "ac"
        readonly property bool enabled: climateControl.airConditioningEnabled

        function setEnabled(newEnabled) {
            climateControl.airConditioningEnabled = newEnabled;
        }
    }

    property QtObject airQuality: QtObject {
        readonly property string symbol: "air_quality"
        readonly property bool enabled: climateControl.recirculationMode === ClimateControl.RecirculationOn

        function setEnabled(newEnabled) {
            climateControl.recirculationMode = newEnabled ? ClimateControl.RecirculationOn : ClimateControl.RecirculationOff;
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
        readonly property string symbol: "stearing_wheel"
        readonly property bool enabled: climateControl.steeringWheelHeater >= 5

        function setEnabled(newEnabled) {
            climateControl.steeringWheelHeater = newEnabled ? 10 : 0;
        }
    }

    readonly property var climateOptions: [frontHeat, rearHeat, airCondition, airQuality, eco, steeringWheelHeat]

    property int outsideTemp: climateControl.outsideTemperature != 0 ? calculateUnitValue(climateControl.outsideTemperature)
                                                                     : calculateUnitValue(15)
    property string outsideTempText: qsTr("%1" + tempSuffix).arg(outsideTemp)
    property int ventilation: climateControl.fanSpeedLevel
    readonly property string tempSuffix: SettingsModel.metric ? "°C" : "°F"
    property int ventilationLevels: 7 // 6 + off (0)

    function setVentilation(newVentilation) {
        climateControl.fanSpeedLevel = newVentilation;
    }

    property QtObject airflowDirections: QtObject {
        property int directions: climateControl.airflowDirections
        // FIXME this is stupid, how to get the available list programatically?
        // TODO ClimateControl.Windshield missing; when added, this will get fun ;)
        readonly property var availableDirections: [ClimateControl.Dashboard, ClimateControl.Floor,
            ClimateControl.Dashboard | ClimateControl.Floor]
        onDirectionsChanged: climateControl.airflowDirections = directions
    }

    property QtObject stateMachine: ClimateStateMachine {
        climateControl: root.climateControl
        doorsOpen: eco.enabled // TODO use QtIVI doors/window state for this eventually
    }

    function calculateUnitValue(value) {
        // Default value is the celsius
        return SettingsModel.metric ? value : Math.round(value * 1.8 + 32)
    }
}

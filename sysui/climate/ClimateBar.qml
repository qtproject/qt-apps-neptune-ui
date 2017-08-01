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

import QtQuick 2.6
import QtQuick.Controls 2.0
import controls 1.0
import utils 1.0
import models.climate 1.0
import models.system 1.0
import models.startup 1.0

Control {
    id: root

    width: Style.screenWidth
    height: Style.vspan(24) - Style.statusBarHeight
    y: SystemModel.climateExpanded ? Style.statusBarHeight : Style.screenHeight - Style.climateCollapsedVspan

    Behavior on y {
        NumberAnimation { duration: 450; easing.type: Easing.OutCubic }
    }

    Pane {
        id: climatePanelBackground
        height: Style.climateCollapsedVspan
        anchors.left: parent.left
        anchors.right: parent.right
        opacity: !SystemModel.climateExpanded
        visible: opacity !== 0
        Behavior on opacity { NumberAnimation { duration: 450 } }
    }

    Item {
        id: climateBarContent
        height: Style.climateCollapsedVspan
        width: Style.hspan(23)
        anchors.horizontalCenter: parent.horizontalCenter

        TemperatureLevel {
            id: tempLevelLeft
            value: ClimateModel.calculateUnitValue(ClimateModel.leftSeat.value)
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            onClicked: SystemModel.climateExpanded = !SystemModel.climateExpanded
        }

        Tool {
            id: leftSeatHeat
            width: Style.hspan(2)
            height: Style.climateCollapsedVspan
            symbol: "seat_left"
            checked: ClimateModel.leftSeat.heat
            onClicked: ClimateModel.leftSeat.heat = !ClimateModel.leftSeat.heat
            anchors.left: tempLevelLeft.right
            anchors.leftMargin: Style.hspan(1)
            anchors.verticalCenter: parent.verticalCenter
        }

        AirFlow {
            width: Style.hspan(6)
            height: Style.climateCollapsedVspan
            anchors.left: leftSeatHeat.right
            anchors.right: rightSeatHeat.left
            anchors.centerIn: parent
            anchors.verticalCenter: parent.verticalCenter
        }

        Tool {
            id: rightSeatHeat
            width: Style.hspan(2)
            height: Style.climateCollapsedVspan
            symbol: "seat_right"
            checked: ClimateModel.rightSeat.heat
            onClicked: ClimateModel.rightSeat.heat = !ClimateModel.rightSeat.heat
            anchors.right: tempLevelRight.left
            anchors.rightMargin: Style.hspan(1)
            anchors.verticalCenter: parent.verticalCenter
        }

        TemperatureLevel {
            id: tempLevelRight
            horizontalAlignment: Qt.AlignRight
            value: ClimateModel.calculateUnitValue(ClimateModel.rightSeat.value)
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            onClicked: SystemModel.climateExpanded = !SystemModel.climateExpanded
        }
    }

    StageLoader {
        id: climatePaneLoader
        width: Style.screenWidth
        height: Style.vspan(24) - Style.statusBarHeight
        active: StagedStartupModel.loadBackgroundElements
        source: "ClimatePane.qml"
        // QtBUG: https://bugreports.qt.io/browse/QTBUG-50992 otherwise it should be asynchronous
        asynchronous: false
        onLoaded: {
            climatePaneLoader.item.climateBarItem = climateBarContent
            climatePaneLoader.item.backgroundPaneVisible = Qt.binding(function () { return climatePanelBackground.opacity !== 1 })
        }
    }

    Component.onCompleted: {
        StartupTimer.checkpoint("Climate bar created!");
        StartupTimer.createReport();
    }
}

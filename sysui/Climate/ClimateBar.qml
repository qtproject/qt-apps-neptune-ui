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
import QtQuick.Layouts 1.0
import controls 1.0
import utils 1.0
import service.climate 1.0

UIElement {
    id: root

    property bool expanded: false
    property int collapsedVspan: 3

    hspan: 24
    vspan: 24

    MouseArea {
        anchors.fill: parent
        onClicked: climateBar.expanded = !climateBar.expanded
    }

    DisplayBackground {
        anchors.fill: parent
        visible: climatePanelBackground.opacity !== 1
    }

    ClimatePanelBackground {
        id: climatePanelBackground

        vspan: collapsedVspan
        anchors.left: parent.left
        anchors.right: parent.right
        opacity: !expanded
        visible: opacity !== 0
        Behavior on opacity { NumberAnimation { duration: 450 } }
    }

    ColumnLayout {
        id: mainLayout

        spacing: 0
        anchors.horizontalCenter: parent.horizontalCenter
        width: Style.hspan(23)

        Item {
            height: Style.vspan(root.collapsedVspan)
            Layout.preferredWidth: mainLayout.width

            TemperatureLevel {
                id: tempLevelLeft
                value: ClimateService.leftSeat.value
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Tool {
                id: leftSeatHeat
                hspan: 2
                vspan: root.collapsedVspan
                name: "seat_left"
                active: ClimateService.leftSeat.heat
                onClicked: ClimateService.leftSeat.heat = !active
                anchors.left: tempLevelLeft.right
                anchors.verticalCenter: parent.verticalCenter
            }

            AirFlow {
                hspan: 6
                vspan: root.collapsedVspan
                anchors.left: leftSeatHeat.right
                anchors.right: rightSeatHeat.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Tool {
                id: rightSeatHeat
                hspan: 2
                vspan: root.collapsedVspan
                name: "seat_right"
                active: ClimateService.rightSeat.heat
                onClicked: ClimateService.rightSeat.heat = !active
                anchors.right: tempLevelRight.left
                anchors.verticalCenter: parent.verticalCenter
            }

            TemperatureLevel {
                id: tempLevelRight
                horizontalAlignment: Qt.AlignRight
                value: ClimateService.rightSeat.value
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        RowLayout {
            spacing: 0
            Layout.preferredHeight: Style.vspan(19)
            visible: climatePanelBackground.opacity !== 1

            TemperatureSlider {
                id: leftTempSlider
                hspan: 3
                Layout.fillHeight: true
                minValue: ClimateService.leftSeat.minValue
                maxValue: ClimateService.leftSeat.maxValue
                value: ClimateService.leftSeat.value
                stepValue: ClimateService.leftSeat.stepValue
                onValueChanged: ClimateService.leftSeat.value = value
            }

            Spacer {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            ColumnLayout {
                spacing: 20
                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true

                Spacer {
                    Layout.fillWidth: true
                    vspan: 2
                }

                Ventilation {
                    id: ventilation

                    Layout.alignment: Qt.AlignHCenter
                    hspan: 10
                    vspan: 2
                    levels: ClimateService.ventilationLevels
                    currentLevel: ClimateService.ventilation
                    onCurrentLevelChanged: ClimateService.ventilation = currentLevel
                }

                Spacer {
                    Layout.fillWidth: true
                    vspan: 2
                }

                ClimateOptionsGrid {
                    Layout.alignment: Qt.AlignHCenter
                    hspan: 9
                    vspan: 10

                    model: ClimateService.climateOptions
                    delegate: ClimateGridButton {
                        hspan: 3
                        vspan: 5
                        symbolName: modelData.symbol
                        active: modelData.enabled
                        onClicked: modelData.enabled = !modelData.enabled
                    }
                }
            }

            Spacer {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            TemperatureSlider {
                id: rightTempSlider
                Layout.fillHeight: true
                hspan: 3
                mirrorSlider: true
                minValue: ClimateService.rightSeat.minValue
                maxValue: ClimateService.rightSeat.maxValue
                value: ClimateService.rightSeat.value
                stepValue: ClimateService.rightSeat.stepValue
                onValueChanged: ClimateService.rightSeat.value = value
            }

        }

        Spacer {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    Connections {
        target: ClimateService.leftSeat
        onValueChanged: leftTempSlider.value = ClimateService.leftSeat.value
    }

    Connections {
        target: ClimateService.rightSeat
        onValueChanged: rightTempSlider.value = ClimateService.rightSeat.value
    }
}

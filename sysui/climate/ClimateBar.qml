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
import QtQuick.Layouts 1.0
import controls 1.0
import utils 1.0
import models.climate 1.0

Control {
    id: root

    property bool expanded: false
    property int collapsedVspan: 3

    width: Style.hspan(24)
    height: Style.vspan(24)



    BackgroundPane {
        anchors.fill: parent
        visible: climatePanelBackground.opacity !== 1
    }

    Pane {
        id: climatePanelBackground
        height: Style.vspan(root.collapsedVspan)
        anchors.left: parent.left
        anchors.right: parent.right
        opacity: !expanded
        visible: opacity !== 0
        Behavior on opacity { NumberAnimation { duration: 450 } }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.expanded = !root.expanded
    }

    ColumnLayout {
        id: mainLayout

        spacing: 0
        anchors.horizontalCenter: parent.horizontalCenter
        width: Style.hspan(23)

        Item { // This is the actual climate bar
            height: Style.vspan(root.collapsedVspan)
            Layout.preferredWidth: mainLayout.width

            TemperatureLevel {
                id: tempLevelLeft
                value: ClimateModel.leftSeat.value
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Tool {
                id: leftSeatHeat
                width: Style.hspan(2)
                height: Style.vspan(root.collapsedVspan)
                symbol: "seat_left"
                checked: ClimateModel.leftSeat.heat
                onClicked: ClimateModel.leftSeat.heat = !ClimateModel.leftSeat.heat
                anchors.left: tempLevelLeft.right
                anchors.verticalCenter: parent.verticalCenter
            }

            AirFlow {
                width: Style.hspan(6)
                height: Style.vspan(root.collapsedVspan)
                anchors.left: leftSeatHeat.right
                anchors.right: rightSeatHeat.left
                anchors.centerIn: parent
                anchors.verticalCenter: parent.verticalCenter
            }

            Tool {
                id: rightSeatHeat
                width: Style.hspan(2)
                height: Style.vspan(root.collapsedVspan)
                symbol: "seat_right"
                checked: ClimateModel.rightSeat.heat
                onClicked: ClimateModel.rightSeat.heat = !ClimateModel.rightSeat.heat
                anchors.right: tempLevelRight.left
                anchors.verticalCenter: parent.verticalCenter
            }

            TemperatureLevel {
                id: tempLevelRight
                horizontalAlignment: Qt.AlignRight
                value: ClimateModel.rightSeat.value
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        } // end of climate bar

        RowLayout { // climate control
            spacing: 0
            Layout.preferredHeight: Style.vspan(19)
            visible: climatePanelBackground.opacity !== 1

            TemperatureSlider {
                id: leftTempSlider
                width: Style.hspan(3)
                Layout.fillHeight: true
                from: ClimateModel.leftSeat.minValue
                to: ClimateModel.leftSeat.maxValue
                value: ClimateModel.leftSeat.value
                stepSize: ClimateModel.leftSeat.stepValue
                onValueChanged: ClimateModel.leftSeat.value = value
            }

            Spacer {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            ColumnLayout { // inner controls
                spacing: 20
                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true

                Spacer {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Style.vspan(2)
                }

                Ventilation {
                    id: ventilation

                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: Style.hspan(10)
                    Layout.preferredHeight: Style.vspan(2)
                    levels: ClimateModel.ventilationLevels
                    currentLevel: ClimateModel.ventilation
                    onNewLevelRequested: ClimateModel.setVentilation(newLevel)
                }

                Spacer {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Style.vspan(2)
                }

                ClimateOptionsGrid { // tool grid
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: Style.hspan(9)
                    Layout.preferredHeight: Style.vspan(10)
                    model: ClimateModel.climateOptions
                    delegate: Button {
                        width: Style.hspan(3)
                        height: Style.vspan(5)
                        indicator: Image {
                            anchors.centerIn: parent
                            source: Style.symbol(modelData.symbol)
                        }
                        checked: modelData.enabled
                        onClicked: modelData.setEnabled(!modelData.enabled)
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
                width: Style.hspan(3)
                mirrorSlider: true
                from: ClimateModel.rightSeat.minValue
                to: ClimateModel.rightSeat.maxValue
                value: ClimateModel.rightSeat.value
                stepSize: ClimateModel.rightSeat.stepValue
                onValueChanged: ClimateModel.rightSeat.value = value
            }

        }

        Spacer {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

}

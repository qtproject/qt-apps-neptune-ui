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

import QtQuick 2.5
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

import controls 1.0
import utils 1.0
import "models"
import "."

UIScreen {
    id: root
    width: Style.hspan(24)
    height: Style.vspan(20)

    title: 'Radio'

    Connections {
        target: RadioModel

        onCurrentFrequencyChanged: {
            if (!slider.dragging) {
                radioStationInformation.tuningMode = false
                slider.value = RadioModel.currentFrequency
            }
        }
    }

    ColumnLayout {
        id: stationControl
        width: Style.hspan(12)
        height: Style.vspan(18)
        anchors.horizontalCenter: parent.horizontalCenter
        Spacer {
            Layout.preferredHeight: Style.vspan(1)
            Layout.fillWidth: true
        }
        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            id: radioStationInformation

            Layout.preferredWidth: stationInfo.width
            Layout.preferredHeight: stationInfo.height

            property bool tuningMode: false

            StationInfo {
                id: stationInfo
                title: RadioModel.currentStation.stationName
                radioText: RadioModel.currentStation.radioText
                frequency: radioStationInformation.tuningMode ? slider.value : RadioModel.currentFrequency
            }
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0

            Tool {
                Layout.preferredWidth: Style.hspan(1)
                Layout.preferredHeight: Style.vspan(1)
                symbol: 'backward'
                anchors.verticalCenter: parent.verticalCenter
                size: Style.symbolSizeS
                onClicked: {
                    RadioModel.scanBack()
                }
            }

            TunerSlider {
                id: slider

                Layout.preferredWidth: Style.hspan(9)
                Layout.preferredHeight: Style.vspan(1)

                useAnimation: true

                readonly property real minFrequency: RadioModel.minimumFrequency
                readonly property real maxFrequency: RadioModel.maximumFrequency


                value: RadioModel.currentFrequency
                minimum: minFrequency
                maximum: maxFrequency

                function valueToString() {
                    return value.toFixed(1)
                }

                onActiveValueChanged: {
                    value = activeValue
                }

                onDraggingChanged: {
                    if (dragging) {
                        radioStationInformation.tuningMode = true
                    } else {
                        // radioStationInformation.tuningMode = false
                        RadioModel.setFrequency(value)
                    }
                }
            }

            Tool {
                Layout.preferredWidth: Style.hspan(1)
                Layout.preferredHeight: Style.vspan(1)
                symbol: 'forward'
                anchors.verticalCenter: parent.verticalCenter
                size: Style.symbolSizeS
                onClicked: {
                    RadioModel.scanForward()
                }
            }
        }
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Spacer { Layout.preferredWidth: Style.hspan(2) }
            Tool {
                Layout.preferredWidth: Style.hspan(2)
                symbol: RadioModel.playing?'pause':'play'
                onClicked: RadioModel.togglePlay()
            }
            Spacer { Layout.preferredWidth: Style.hspan(2) }
        }
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Symbol {
                Layout.preferredWidth: Style.hspan(1)
                Layout.preferredHeight: Style.vspan(2)
                size: Style.symbolSizeXS
                name: 'speaker'
            }
            VolumeSlider {
                Layout.preferredWidth: Style.hspan(8)
                Layout.preferredHeight: Style.vspan(2)
                anchors.horizontalCenter: parent.horizontalCenter
                value: RadioModel.volume
                onValueChanged: {
                    RadioModel.volume = value
                }
            }
            Label {
                Layout.preferredWidth: Style.hspan(1)
                Layout.preferredHeight: Style.vspan(2)
                text: Math.floor(RadioModel.volume*100)
                horizontalAlignment: Text.AlignHCenter
            }
        }
        Spacer {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    Control {
        id: sourceOption
        width: Style.hspan(4)
        height: Style.vspan(9)
        anchors.right: stationControl.left
        anchors.rightMargin: Style.hspan(1)
        anchors.verticalCenter: parent.verticalCenter

        ColumnLayout {
            anchors.fill: parent
            ToolButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "FM"
                font.pixelSize: Style.fontSizeL
            }
            ToolButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "AM"
                enabled: false
                font.pixelSize: Style.fontSizeL
            }
            ToolButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "SiriusXM"
                enabled: false
                font.pixelSize: Style.fontSizeL
            }
        }
    }
}

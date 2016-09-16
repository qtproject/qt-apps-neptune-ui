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

import QtQuick 2.5
import QtQuick.Layouts 1.0

import controls 1.0
import utils 1.0
import service.tuner 1.0
import "."

UIScreen {
    id: root
    hspan: 24
    vspan: 24

    title: 'Radio'

    Connections {
        target: RadioProvider

        onCurrentFrequencyChanged: {
            if (!slider.dragging) {
                radioStationInformation.tuningMode = false
                slider.value = RadioProvider.currentFrequency
            }
        }
    }

    ColumnLayout {
        id: stationControl
        width: Style.hspan(12)
        height: Style.vspan(20)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 0
        Spacer {}
            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                id: radioStationInformation

                width: stationInfo.width
                height: stationInfo.height

                property bool tuningMode: false

                StationInfo {
                    id: stationInfo
                    title: RadioProvider.currentStation.stationName
                    radioText: RadioProvider.currentStation.radioText
                    frequency: radioStationInformation.tuningMode ? slider.value : RadioProvider.currentFrequency
                }
            }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            Tool {
                hspan: 1
                vspan: 1
                name: 'backward'
                anchors.verticalCenter: parent.verticalCenter
                size: Style.symbolSizeS
                onClicked: {
                    RadioProvider.scanBack()
                }
            }

            TunerSlider {
                id: slider

                useAnimation: true

                readonly property real minFrequency: RadioProvider.minimumFrequency
                readonly property real maxFrequency: RadioProvider.maximumFrequency

                hspan: 9
                vspan: 1

                value: RadioProvider.currentFrequency
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
                        RadioProvider.setFrequency(value)
                    }
                }
            }

            Tool {
                hspan: 1
                vspan: 1
                name: 'forward'
                anchors.verticalCenter: parent.verticalCenter
                size: Style.symbolSizeS
                onClicked: {
                    RadioProvider.scanForward()
                }
            }
        }
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Spacer { hspan: 2 }
            Tool {
                hspan: 2
                name: RadioService.playing?'pause':'play'
                onClicked: RadioService.togglePlay()
            }
            Spacer { hspan: 2 }
        }
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Symbol {
                vspan: 2
                hspan: 1
                size: Style.symbolSizeXS
                name: 'speaker'
            }
            VolumeSlider {
                hspan: 8
                vspan: 2
                anchors.horizontalCenter: parent.horizontalCenter
                value: RadioService.volume
                onValueChanged: {
                    RadioService.volume = value
                }
            }
            Label {
                hspan: 1
                vspan: 2
                text: Math.floor(RadioService.volume*100)
            }
        }
        Spacer {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    UIElement {
        id: sourceOption
        hspan: 4
        vspan: 12
        anchors.right: stationControl.left
        anchors.rightMargin: 60
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -60

        Column {
            spacing: 1
            Button {
                hspan: 4
                vspan: 4
                text: "FM"
                label.font.pixelSize: Style.fontSizeL
            }
            Button {
                hspan: 4
                vspan: 4
                text: "AM"
                enabled: false
                label.font.pixelSize: Style.fontSizeL
            }
            Button {
                hspan: 4
                vspan: 4
                text: "SiriusXM"
                enabled: false
                label.font.pixelSize: Style.fontSizeL
            }
        }
    }
}

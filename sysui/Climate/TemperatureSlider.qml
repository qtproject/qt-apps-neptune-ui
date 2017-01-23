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
import controls 1.0
import utils 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Control {
    id: root


    implicitWidth: Style.hspan(2)
    implicitHeight: Style.vspan(8)

    readonly property int roundingModeWhole: 1
    readonly property int roundingModeHalf: 2

    property bool mirrorSlider: false

    property alias from: slider.from
    property alias to: slider.to
    property alias value: slider.value
    property int roundingMode: roundingModeWhole
    property alias stepSize: slider.stepSize

    transform: Rotation {
        angle: mirrorSlider ? 180 : 0
        axis { x: 0; y: 1; z: 0 }
        origin { x: root.width/2; y: root.height/2 }
    }

    ColumnLayout {
        id: barRow

        spacing: 0
        width: parent.width
        height: parent.height

        Label {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.vspan(2)

            font.family: Style.fontFamily
            font.pixelSize: Style.fontSizeXL

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "+"
            color: Style.colorWhite

            MouseArea {
                anchors.fill: parent
                onClicked: slider.increase()
            }
            Tracer {}
        }

        Slider {
            id: slider
            Layout.fillHeight: true
            Layout.fillWidth: true
            orientation: Qt.Vertical
            snapMode: Slider.SnapAlways

            background: ListView {
                id: view
                implicitWidth: Style.hspan(3)
                implicitHeight: Style.vspan(8)
                x: slider.leftPadding + slider.availableWidth/2 - width/2
                y: slider.topPadding + slider.handle.height/2
                width: slider.availableWidth
                height: slider.availableHeight - slider.handle.height


                property int itemHeight: 7
                currentIndex: slider.position * count
                property real deltaRed: (0xa6 - 0xf0) / view.count
                property real deltaGreen: (0xd5 - 0x7d) / view.count
                property real deltaBlue: (0xda - 0x0) / view.count

                function calcRed(index) { return (deltaRed * (view.count-index) + 0xf0) / 255 }
                function calcGreen(index) { return (deltaGreen * (view.count-index) + 0x7d) / 255 }
                function calcBlue(index) { return (deltaBlue * (view.count-index) + 0x0) / 255 }

                Behavior on currentIndex { SmoothedAnimation { velocity: view.count*2} }


                // NOTE: verticalLayoutDirection: ListView.BottomToTop doesn't seem to play well with the mouse area
                rotation: 180
                orientation: Qt.Vertical
                interactive: false
                model: height/itemHeight

                delegate: Item {
                    width: view.width
                    height: view.itemHeight
                    property int entry: index

                    Rectangle {
                        id: stripe

                        property bool bottomPart: view.currentIndex >= index

                        antialiasing: true
                        anchors.right: parent.right
                        width: parent.width - Style.hspan(1)
                        height: parent.height - 3
                        border.color: Qt.darker(color, 1.5)
                        border.width: 1
                        color: Qt.rgba(view.calcRed(index), view.calcGreen(index), view.calcBlue(index))
                        scale: bottomPart ? 1.0 : 0.96
                        transformOrigin: Item.Left
                        Behavior on scale { NumberAnimation { easing.type: Easing.OutQuad } }
                        opacity: bottomPart ? 1.0 : 0.6
                        Behavior on opacity { NumberAnimation {} }
                    }
                }
            }
            handle: Symbol {
                x: slider.leftPadding
                y: slider.topPadding + slider.visualPosition * (slider.availableHeight - height)
                implicitWidth: Style.hspan(1)
                implicitHeight: Style.vspan(1)
                width: slider.availableWidth
                height: implicitHeight


                Symbol {
                    anchors.right: parent.right
//                    y: parent.height - (parent.height * slider.position) - height/2
                    anchors.verticalCenter: parent.verticalCenter
                    opacity: 0.4
                    name: "slider_marker"
                    height: Style.vspan(1)
                }
            }
            Tracer { }
        }

        Label {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.vspan(2)

            font.family: Style.fontFamily
            font.pixelSize: Style.fontSizeXL

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "-"
            color: Style.colorWhite

            MouseArea {
                anchors.fill: parent
                onClicked: slider.decrease()
            }
            Tracer {}
        }
    }

    Tracer {}
    function _clamp(value) {
        return Math.round(Math.min(root.maxValue, Math.max(root.minValue, value))*root.roundingMode)/root.roundingMode
    }
}

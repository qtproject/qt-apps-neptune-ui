/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
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

import QtQuick 2.1
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import controls 1.0
import utils 1.0

UIElement {
    id: root

    readonly property int roundingModeWhole: 1
    readonly property int roundingModeHalf: 2

    property bool mirrorSlider: false

    property real minValue: 16
    property real maxValue: 28
    property real value: minValue
    property int roundingMode: roundingModeHalf

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

        Text {
            Layout.preferredWidth: Style.hspan(2)
            Layout.preferredHeight: Style.vspan(2)

            font.family: Style.fontFamily
            font.pixelSize: Style.fontSizeXL

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "+"
            color: Style.colorWhite

            MouseArea {
                anchors.fill: parent
                onClicked: root.value = root._clamp(root.value + 1 / root.roundingMode)
            }
        }

        ListView {
            id: view

            Layout.fillHeight: true
            Layout.preferredWidth: Style.hspan(3)

            property int itemHeight: 7

            property real deltaRed: (0xa6 - 0xf0) / view.count
            property real deltaGreen: (0xd5 - 0x7d) / view.count
            property real deltaBlue: (0xda - 0x0) / view.count

            function calcRed(index) { return (deltaRed * (view.count-index) + 0xf0) / 255 }
            function calcGreen(index) { return (deltaGreen * (view.count-index) + 0x7d) / 255 }
            function calcBlue(index) { return (deltaBlue * (view.count-index) + 0x0) / 255 }

            Behavior on currentIndex { SmoothedAnimation { velocity: view.count*2} }

            currentIndex: (root.value - root.minValue) / (root.maxValue - root.minValue) * view.count

            onCurrentItemChanged: if (currentItem) handle.currentItemY = currentItem.y

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
                    //radius: 1
                    scale: bottomPart ? 1.0 : 0.96
                    transformOrigin: Item.Left
                    Behavior on scale { NumberAnimation { easing.type: Easing.OutQuad } }
                    opacity: bottomPart ? 1.0 : 0.6
                    Behavior on opacity { NumberAnimation {} }
                }
            }

            Symbol {
                id: handle

                property real currentItemY: view.currentItem ? view.currentItem.y : 0
                anchors.left: parent.left
                width: Style.hspan(1)
                height: Style.vspan(1)
                y: currentItemY - height / 2 + 3

                opacity: 0.4
                name: "slider_marker"
                rotate: root.mirrorSlider ? -180 : 180
            }

            MouseArea {
                id: dragArea
                anchors.fill: view
                hoverEnabled: false
                preventStealing: true
                onClicked: updateCurrentIndex(mouse.x, mouse.y)
                onPositionChanged: updateCurrentIndex(mouse.x, mouse.y)

                function updateCurrentIndex(x, y) {
                    var item = view.itemAt(x, y);
                    if (item) {
                        root.value = root._clamp(item.entry / view.count * (root.maxValue - root.minValue) + root.minValue)
                    }
                }
            }
        }

        Text {
            Layout.preferredWidth: Style.hspan(2)
            Layout.preferredHeight: Style.vspan(2)

            font.family: Style.fontFamily
            font.pixelSize: Style.fontSizeXL

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "-"
            color: Style.colorWhite

            MouseArea {
                anchors.fill: parent
                onClicked: root.value = root._clamp(root.value - 1 / root.roundingMode)
            }
        }
    }

    function _clamp(value) {
        return Math.round(Math.min(root.maxValue, Math.max(root.minValue, value))*root.roundingMode)/root.roundingMode
    }
}

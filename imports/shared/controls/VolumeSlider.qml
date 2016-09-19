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

import QtQuick 2.0
import utils 1.0

UIElement {
    id: root
    hspan: 8
    vspan: 2

    property real value;
    property real minimum: 0;
    property real maximum: 1;

    function setValue(value) {
        root.value = value
        var index = Math.floor(value*view.count)
        view.currentIndex = index
    }


    Image {
        anchors.centerIn: parent
        source: Style.gfx('volume_slider_overlay')
        opacity: 0.2
        asynchronous: true
    }


    Item {
        id: content
        anchors.fill: parent
        anchors.margins: Style.padding
        ListView {
            id: view
            anchors.fill: parent
            orientation: Qt.Horizontal
            interactive: false
            model: 40
            Behavior on currentIndex { SmoothedAnimation { velocity: view.count*2} }
            delegate: Item {
                width: view.width/view.count
                height: view.height
                property int entry: index
                Rectangle {
                    width: 4
                    height: parent.height
                    anchors.centerIn: parent
                    border.color: Qt.darker(color, 1.1)
                    color: '#A2CED2'
                    radius: 1
                    scale: view.currentIndex >= index?1.0:0.85
                    transformOrigin: Item.Bottom
                    Behavior on scale { NumberAnimation { easing.type: Easing.OutQuad } }
                    opacity: view.currentIndex >= index?1.0:0.25
                    Behavior on opacity { NumberAnimation {} }
                }
            }
        }


        MouseArea {
            anchors.fill: view
            hoverEnabled: false
            preventStealing: true
            onClicked: {
                var item = view.itemAt(mouse.x, mouse.y);
                if (!item) {
                    return;
                }
                root.setValue(item.entry/(view.count - 1))
            }
            onPositionChanged: {
                var item = view.itemAt(mouse.x, mouse.y);
                if (!item) {
                    return;
                }
                root.setValue(item.entry/(view.count - 1))
            }
        }
    }

    Component.onCompleted: {
        setValue(root.value)
    }
}

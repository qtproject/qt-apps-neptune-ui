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
                root.setValue(item.entry/view.count)
            }
            onPositionChanged: {
                var item = view.itemAt(mouse.x, mouse.y);
                if (!item) {
                    return;
                }
                root.setValue(item.entry/view.count)
            }
        }
    }

    Component.onCompleted: {
        setValue(root.value)
    }
}

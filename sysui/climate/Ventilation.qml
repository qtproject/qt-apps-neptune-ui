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

Control {
    id: root

    // Number of levels including zero which means 'off'. 7 equals 6 levels + off
    property int levels
    property int currentLevel

    onCurrentLevelChanged: view.currentIndex = currentLevel;

    signal newLevelRequested(int newLevel)

    function updateLevelInternal(newLevel) {
        var boundedLevel = Math.max(0, Math.min(levels - 1, newLevel));
        newLevelRequested( boundedLevel );
    }

    MouseArea {
        anchors.fill: view
        anchors.leftMargin: Style.hspan(2)
        anchors.rightMargin: Style.hspan(2)
        onClicked: updateLevelFromMousePosition(mouse.x, mouse.y)
        onPositionChanged: updateLevelFromMousePosition(mouse.x, mouse.y)

        function updateLevelFromMousePosition(x, y) {
            var index = view.indexAt(x, y)
            if (index > 0) {
                root.updateLevelInternal(index)
            }
        }
    }

    ListView {
        id: view

        anchors.centerIn: parent

        width: Style.hspan(levels-1 + 2 + 2)
        height: Style.vspan(2)
        orientation: ListView.Horizontal

        interactive: false
        model: levels

        Behavior on currentIndex { SmoothedAnimation { velocity: view.count*2} }

        header: Symbol {
            width: Style.hspan(2)
            height: Style.vspan(2)
            name: "fan"
            size: Style.symbolSizeS
            MouseArea {
                anchors.fill: parent
                onClicked: root.updateLevelInternal(root.currentLevel - 1)
            }
        }

        footer: Symbol {
            width: Style.hspan(2)
            height: Style.vspan(2)
            name: "fan"
            size: Style.symbolSizeM
            MouseArea {
                anchors.fill: parent
                onClicked: root.updateLevelInternal(root.currentLevel + 1)
            }
        }

        delegate: Rectangle {
            width: index === 0 ? 0 : Style.hspan(1)
            height: Style.vspan(2)
            border.color: Qt.darker(color, 1.5)
            color: '#fff'
            radius: 1
            opacity: view.currentIndex >= index ? 1.0 : 0.5
            Behavior on opacity { NumberAnimation {} }
        }
    }
}

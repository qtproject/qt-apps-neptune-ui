/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
** Contact: http://www.pelagicore.com/
**
** This file is part of Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Neptune IVI UI licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Pelagicore. For licensing terms
** and conditions see http://www.pelagicore.com.
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
****************************************************************************/

import QtQuick 2.1
import controls 1.0
import utils 1.0

UIElement {
    id: root

    // Number of levels including zero which means 'off'. 7 equals 6 levels + off
    property int levels
    property alias currentLevel: view.currentIndex

    MouseArea {
        anchors.fill: view
        anchors.leftMargin: Style.hspan(2)
        anchors.rightMargin: Style.hspan(2)
        onClicked: updateIndex(mouse.x, mouse.y)
        onPositionChanged: updateIndex(mouse.x, mouse.y)

        function updateIndex(x, y) {
            var index = view.indexAt(x, y)
            if (index > 0) {
                view.currentIndex = Math.min(index, view.count-1)
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
            hspan: 2
            vspan: 2
            name: "fan"
            size: Style.symbolSizeS
            MouseArea {
                anchors.fill: parent
                onClicked: view.decrementCurrentIndex()
            }
        }

        footer: Symbol {
            hspan: 2
            vspan: 2
            name: "fan"
            size: Style.symbolSizeM
            MouseArea {
                anchors.fill: parent
                onClicked: view.incrementCurrentIndex()
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

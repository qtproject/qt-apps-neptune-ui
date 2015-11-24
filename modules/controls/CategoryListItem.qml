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

import controls 1.0
import utils 1.0

UIElement {
    id: root

    property alias text: label.text
    property alias symbol: symbol.name

    signal clicked()

    BorderImage {
        anchors.fill: parent
        anchors.bottomMargin: 1
        source: Style.gfx('appstore_tab_panel')
        opacity: 1-activeBackground.opacity
        border {
            left: 4
            right: 60
            top: 4
            bottom: 4
        }
        asynchronous: true
    }

    BorderImage {
        id: activeBackground
        anchors.fill: parent
        anchors.bottomMargin: 1
        source: Style.gfx('appstore_tab_panel_selected')
        opacity: root.ListView.isCurrentItem
        Behavior on opacity { NumberAnimation { duration: 200 } }
        border {
            left: 4
            right: 60
            top: 4
            bottom: 4
        }
        asynchronous: true
    }

    Label {
        id: label

        anchors.left: parent.left
        anchors.right: symbol.left
        height: parent.height
        anchors.leftMargin: Style.paddingXL
        anchors.rightMargin: symbol.hspan === 0 ? Style.paddingXL : 0

        font.pixelSize: Style.fontSizeS
        font.capitalization: Font.AllUppercase
        color: root.ListView.isCurrentItem ? Style.colorOrange : Style.colorWhite

        Behavior on color { ColorAnimation { duration: 200 } }
    }

    Symbol {
        id: symbol

        anchors.right: parent.right
        hspan: name ? 2 : 0
        height: parent.height
        active: root.ListView.isCurrentItem
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}

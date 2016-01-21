/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
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

    hspan: 4
    vspan: 2

    property string text
    signal clicked()

    property alias color: background.color
    property bool solid: false

    Rectangle {
        id: background
        anchors.fill: parent
        color: '#576071'
        opacity: root.solid?1.0:0.5
        border.color: Qt.lighter(Qt.tint(color, '#66ffffff'), area.containsMouse?1.5:1.0)
    }

    Text {
        id: label
        anchors.centerIn: parent
        color: '#fff'
        font.pixelSize: 14
        text: root.text
    }
    Text {
        id: info
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 4
        color: '#fff'
        font.pixelSize: 10
        text: root.width + 'x' + root.height
        horizontalAlignment: Text.AlignRight
        opacity: area.containsMouse?0.5:0.0
        Behavior on opacity { NumberAnimation {} }
    }

    MouseArea {
        id: area
        anchors.fill: parent
        onClicked: root.clicked()
        hoverEnabled: true
    }
}

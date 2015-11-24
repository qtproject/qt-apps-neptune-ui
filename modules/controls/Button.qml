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

import utils 1.0

UIElement {
    id: root
    vspan: 2

    property alias text: label.text
    property string iconName
    property alias label: label
    property alias icon: icon
    property alias pressed: mouseArea.pressed

    property int spacing: Style.padding

    signal clicked

    Rectangle {
        anchors.fill: parent
        color: '#000'
        opacity: 0.85

        Behavior on scale { NumberAnimation {} }
    }

    Column {
        id: layout

        anchors.centerIn: parent

        spacing: root.spacing

        Image {
            id: icon

            source: iconName ? Style.icon(iconName) : ""
            anchors.horizontalCenter: parent.horizontalCenter
            visible: source !== undefined
            asynchronous: true
        }

        Label {
            id: label

            hspan: root.hspan; vspan: 1
            visible: text

            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Style.fontSizeM
            scale: mouseArea.pressed?0.85:1.0
            Behavior on scale { NumberAnimation {} }
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: root.clicked()
    }
}

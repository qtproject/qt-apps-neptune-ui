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

    property bool selected: false
    property alias text: label.text

    signal clicked

    hspan: 3; vspan: 2

    Item {
        id: tab

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        width: label.implicitWidth
        height: Style.vspan(1)

        BorderImage {
            id: flap

            width: sourceSize.width - (128-Style.padding*2) + label.implicitWidth
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom

            source: Style.gfx("cloud_flap")
            opacity: selected
            asynchronous: true

            border {
                left: sourceSize.width/2
                right: sourceSize.width/2
                top: 0
                bottom: 0
            }

            Behavior on opacity { NumberAnimation {} }
        }

        Text {
            id: label

            anchors.horizontalCenter: flap.horizontalCenter
            anchors.horizontalCenterOffset: 4

            color: selected ? Style.colorOrange : Style.colorGrey
            font.family: Style.fontFamily
            font.pixelSize: Style.fontSizeM

            Behavior on color { ColorAnimation { } }
        }
    }

    MouseArea {
        anchors.fill: tab
        onClicked: root.clicked()
    }
}

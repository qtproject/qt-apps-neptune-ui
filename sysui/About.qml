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

import QtQuick 2.1

import controls 1.0
import utils 1.0
import service.settings 1.0

UIElement {
    id: root

    signal clicked()

    Image {
        id: logo
        width: Style.hspan(7)
        height: Style.vspan(4)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: Style.vspan(2)
        source: Style.gfx2Dynamic("pelagicore_colored_white", Style.defaultGfxSize)

        fillMode: Image.PreserveAspectFit

    }

    Label {
        id: description
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: logo.bottom
        width: Style.hspan(12)
        height: Style.vspan(4)
        horizontalAlignment: Text.AlignHCenter

        text: "We put Stunning User Experiences on the road"
        wrapMode: Text.Wrap
        font.pixelSize: Style.fontSizeL
        font.bold: true

    }

    Image {
        width: Style.hspan(20)
        height: Style.vspan(16)
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -Style.vspan(2)
        anchors.horizontalCenter: parent.horizontalCenter
        source: Style.gfx2("boxes_layers")
        fillMode: Image.PreserveAspectFit

        Tracer {}
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }

//    Button {
//        id: closeButton
//        anchors.top: parent.top
//        anchors.horizontalCenter: parent.horizontalCenter
//        text: "Restart UI"
//        onClicked: Qt.quit()
//    }

    Tracer {}
}

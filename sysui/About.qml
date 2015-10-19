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

    signal clicked()

    Image {
        x: Style.hspan(4)
        y: Style.vspan(2)
        source: Style.gfx2Dynamic("pelagicore_colored_white", Style.defaultGfxSize)

        width: Style.hspan(7)
        height: Style.vspan(4)

        fillMode: Image.PreserveAspectFit
    }

    Image {
        source: Style.gfx2("headunit")
        width: Style.hspan(8)

        y: Style.vspan(9)
        x: Style.hspan(4)

        fillMode: Image.PreserveAspectFit
    }

    Label {

        x: Style.hspan(8)
        y: Style.vspan(8)

        width: Style.hspan(12)
        height: Style.vspan(10)

        text: "Bring stunning UX to the road. \n\nPELUX® HeadUnit enables you to design and implement a center-stack user experience (UX) that brings your customers closer to your brand. You will deliver a rock-solid head unit with a UX that’s in-line with next generation mobile devices."
        wrapMode: Text.Wrap
        font.pixelSize: Style.fontSizeL
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}

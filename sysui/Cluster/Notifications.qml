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
import service.navigation 1.0

Item {
    width: background.width
    height: background.height

    Behavior on y {
        NumberAnimation { duration: 200}
    }

    Image {
        id: background
        source: Style.gfx("cluster/navigation_overlay")
    }

    Image {
        source: Style.symbol(NavigationService.nextTurnImage, 0, false)
        anchors.horizontalCenter: distanceText.horizontalCenter
        anchors.top: background.top
        height: 50
        fillMode: Image.PreserveAspectFit
    }

    Label {
        id: distanceText

        anchors.verticalCenter: background.verticalCenter
        anchors.left: background.left
        //anchors.verticalCenterOffset: 19
        //anchors.horizontalCenterOffset: 40

        font.pixelSize: 24

        text: "500m"
    }

    Label {
        anchors.verticalCenter: background.verticalCenter
        anchors.horizontalCenter: background.horizontalCenter
        anchors.verticalCenterOffset: 3
        width: 325
        elide: Text.ElideRight

        font.pixelSize: 21
        textFormat: Text.StyledText
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("<font color='%1'>NEXT:</font> %2")
        .arg(Style.colorOrange)
        .arg("INVALIDENSTRAßE")
    }

    Row {
        anchors.verticalCenter: background.verticalCenter
        anchors.left: background.right
        anchors.verticalCenterOffset: 19
        anchors.leftMargin: -76
        spacing: 4

        Label {
            id: timeText

            font.pixelSize: 20

            text: "00:15"
        }
    }
}

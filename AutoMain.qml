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
import QtQuick.Window 2.2
import "sysui"
import controls 1.0
import utils 1.0

Rectangle {
    id: root

    color: "black"
    width: Screen.width
    height: Screen.height

    Item {
        width: Screen.width
        height: Math.min(width * 0.62, Screen.height)

        onWidthChanged: Style.cellWidth = Math.floor(width/24)
        onHeightChanged: Style.cellHeight = Math.floor(height/24)

        Component.onCompleted: {
            Style.cellWidth = Math.floor(width/24)
            Style.cellHeight = Math.floor(height/24)
            Style.defaultSymbolSize = Style.symbolSizeM
            Style.defaultGfxSize = 2

            var scalFactor = (width/1280);

            Style.fontSizeXXS = scalFactor * 14

            Style.fontSizeXS = scalFactor * 16

            Style.fontSizeS = scalFactor * 18

            Style.fontSizeM = scalFactor * 24

            Style.fontSizeL = scalFactor * 28

            Style.fontSizeXL = scalFactor * 36

            Style.fontSizeXXL = scalFactor * 48

            Style.fontWeight = Font.Light
        }

        DisplayBackground {
            anchors.fill: display
            background: "background_1920x1080"
        }

        Display {
            id: display
            anchors.fill: parent
        }

        DisplayGrid {
            anchors.fill: display
        }
    }
}

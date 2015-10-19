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
import "sysui"
import controls 1.0
import utils 1.0

Item {
    id: root

    width: 1920
    height: 1080

    onWidthChanged: Style.cellWidth = Math.floor(width/24)
    onHeightChanged: Style.cellHeight = Math.floor(height/24)

    Component.onCompleted: {
        Style.cellWidth = Math.floor(width/24)
        Style.cellHeight = Math.floor(height/24)
        Style.defaultSymbolSize = Style.symbolSizeM
        Style.defaultGfxSize = 2

        Style.fontSizeXXS = (1920/1366) * 14

        Style.fontSizeXS = (1920/1366) * 16

        Style.fontSizeS = (1920/1366) * 18

        Style.fontSizeM = (1920/1366) * 24

        Style.fontSizeL = (1920/1366) * 28

        Style.fontSizeXL = (1920/1366) * 36

        Style.fontSizeXXL = (1920/1366) * 48

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

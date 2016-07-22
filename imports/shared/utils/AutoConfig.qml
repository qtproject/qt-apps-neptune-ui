/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:GPL-QTAS$
** Commercial License Usage
** Licensees holding valid commercial Qt Automotive Suite licenses may use
** this file in accordance with the commercial license agreement provided
** with the Software or, alternatively, in accordance with the terms
** contained in a written agreement between you and The Qt Company.  For
** licensing terms and conditions see https://www.qt.io/terms-conditions.
** For further information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
** SPDX-License-Identifier: GPL-3.0
**
****************************************************************************/

import QtQuick 2.0
import QtQuick.Window 2.2

QtObject {
    property int cellWidth: 53 // 1280/24
    property int cellHeight: 33 // 800/24
    property var fontWeight: Font.Light
    property int fontSizeXXS: 14
    property int fontSizeXS: 16
    property int fontSizeS: 18
    property int fontSizeM: 24
    property int fontSizeL: 28
    property int fontSizeXL: 36
    property int fontSizeXXL: 38

    property int defaultSymbolSize: symbolSizeS
    property int defaultGfxSize: 1
    property int symbolSizeXS: 32
    property int symbolSizeS: 48
    property int symbolSizeM: 72
    property int symbolSizeL: 96
    property int symbolSizeXL: 114
    property int symbolSizeXXL: 192

    property string displayBackground: "background_1920x1080"


    property int screenWidth: Screen.width
    property int screenHeight: Math.min(screenWidth * 0.62, Screen.height)

    onScreenWidthChanged: cellWidth = Math.floor(screenWidth/24)
    onScreenHeightChanged: cellHeight = Math.floor(screenHeight/24)

    Component.onCompleted: {
        var scalFactor = (screenWidth/1280);

        print("resolution: " + screenWidth + "x" + screenHeight)
        print("scalFactor: ", scalFactor)

        cellWidth = Math.floor(screenWidth/24)
        cellHeight = Math.floor(screenHeight/24)

        var symbolSize = symbolSizeS
        var gfxSize = 1
        if (scalFactor >= 6) {
            symbolSize = symbolSizeXL
            gfxSize = 4
        } else if (scalFactor >= 2) {
            symbolSize = symbolSizeL
            gfxSize = 3
        } else if (scalFactor >= 1.5) {
            symbolSize = symbolSizeM
            gfxSize = 2
        }

        defaultSymbolSize = symbolSize
        defaultGfxSize = 4


        fontSizeXXS = scalFactor * 14

        fontSizeXS = scalFactor * 16

        fontSizeS = scalFactor * 18

        fontSizeM = scalFactor * 24

        fontSizeL = scalFactor * 28

        fontSizeXL = scalFactor * 36

        fontSizeXXL = scalFactor * 48

        fontWeight = Font.Light
    }
}

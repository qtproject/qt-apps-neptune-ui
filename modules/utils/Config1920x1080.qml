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

QtObject {
    property int cellWidth: Math.floor(screenWidth/24)
    property int cellHeight: Math.floor(screenHeight/24)
    property var fontWeight: Font.Light
    property int fontSizeXXS: (1920/1366) * 14
    property int fontSizeXS: (1920/1366) * 16
    property int fontSizeS: (1920/1366) * 18
    property int fontSizeM: (1920/1366) * 24
    property int fontSizeL: (1920/1366) * 28
    property int fontSizeXL: (1920/1366) * 36
    property int fontSizeXXL: (1920/1366) * 48

    property int defaultSymbolSize: symbolSizeM
    property int defaultGfxSize: 2

    property string displayBackground: "background_1920x1080"

    property int screenWidth: 1920
    property int screenHeight: 1080
}

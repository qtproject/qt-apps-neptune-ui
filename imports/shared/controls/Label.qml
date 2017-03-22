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

import QtQuick 2.1
import utils 1.0

UIElement {
    id: root

    property alias textObject: textElement
    property alias text: textElement.text
    property alias font: textElement.font
    property alias fontSize: textElement.font.pixelSize
    property alias color: textElement.color
    property alias textFormat: textElement.textFormat
    property alias horizontalAlignment: textElement.horizontalAlignment
    property alias elide: textElement.elide
    property alias wrapMode: textElement.wrapMode
    property alias verticalAlignment: textElement.verticalAlignment

    Text {
        id: textElement

        anchors.fill: parent
        anchors.margins: Style.padding

        verticalAlignment: Text.AlignVCenter

        font.family: Style.fontFamily
        font.pixelSize: Style.fontSizeL
        font.weight: Style.fontWeight

        color: Style.colorWhite

        clip: Style.debugMode
    }
}

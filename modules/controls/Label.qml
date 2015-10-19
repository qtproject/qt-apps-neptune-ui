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
import utils 1.0

UIElement {
    id: root

    property alias text: textElement.text
    property alias font: textElement.font
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

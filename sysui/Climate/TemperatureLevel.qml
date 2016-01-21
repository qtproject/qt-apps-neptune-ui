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
import service.climate 1.0

UIElement {
    id: root

    property real value: 0
    property int horizontalAlignment: Qt.AlignLeft

    hspan: 2
    vspan: 3

    Item {
        id: content

        property var values: value.toFixed(1).toString().split(".")
        property bool showDecimal: values[1] !== '0'

        anchors.left: horizontalAlignment === Qt.AlignLeft ? parent.left : undefined
        anchors.right: horizontalAlignment === Qt.AlignRight ? parent.right : undefined
        anchors.horizontalCenter: horizontalAlignment === Qt.AlignHCenter ? parent.horizontalCenter : undefined

        width: childrenRect.width
        height: parent.height

        Text {
            id: integerPart

            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            height: Style.vspan(1)

            text: content.values[0]

            color: Style.colorWhite
            font.pixelSize: Style.fontSizeXXL
            font.family: Style.fontFamily
            font.weight: Style.fontWeight

        }

        Text {
            id: decimalPart

            anchors.left: integerPart.right
            anchors.baseline: integerPart.baseline
            height: Style.vspan(1)

            text: "." + content.values[1]

            visible: content.showDecimal
            color: Style.colorWhite
            font.pixelSize: Style.fontSizeM
            font.family: Style.fontFamily
            font.weight: Style.fontWeight
        }

        Text {
            id: unit
            anchors.left: integerPart.right
            anchors.leftMargin: Style.padding
            anchors.baseline: integerPart.baseline
            height: Style.vspan(1)

            text: ClimateService.tempSuffix

            color: Style.colorWhite
            font.pixelSize: Style.fontSizeXXL*0.97  //RG: the 0.97 is there to get around a font rendering bug on the iMX6
            font.family: Style.fontFamily
            font.weight: Style.fontWeight
        }
    }
    Tracer {}
}

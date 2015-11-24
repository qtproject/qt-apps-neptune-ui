/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
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
import QtQuick.Layouts 1.0
import utils 1.0

UIElement {
    id: root

    property int currentTemperature: 0
    property string weatherIcon

    hspan: 2
    vspan: 2

    RowLayout {
        spacing: Style.paddingL
        anchors.centerIn: parent

        Image {
            source: Style.icon(weatherIcon)
            asynchronous: true
        }

        Text {
            font.family: Style.fontFamily
            font.pixelSize: Style.fontSizeL

            color: Style.colorWhite

            text: qsTr("%1°c").arg(root.currentTemperature)

            clip: Style.debugMode
            font.weight: Style.fontWeight
        }
    }
}

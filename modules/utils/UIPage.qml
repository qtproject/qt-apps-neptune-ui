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
import QtQuick.Layouts 1.0
import controls 1.0
import utils 1.0

UIElement {
    id: root
    hspan: 24
    vspan: 24

    property string title
    property alias symbolName: symbol.name
    property alias additionalIcon: icon.source

    DisplayBackground {
        anchors.fill: parent
        visible: root.parent && root.parent.parent === null
    }

    RowLayout {
        id: infoContainer

        spacing: 0
        width: root.width - 2 * Style.cellWidth
        anchors.top: parent.top;
        anchors.horizontalCenter: parent.horizontalCenter

        Symbol {
            id: symbol
            anchors.bottom: parent.bottom
            hspan: 2
            vspan: 2
            size: Style.symbolSizeM
        }

        Label {
            anchors.bottom: parent.bottom
            hspan: 4
            vspan: 2
            text: qsTr(root.title.toUpperCase())
            font.pixelSize: Style.fontSizeXL
        }

        Spacer {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Icon {
            id: icon
            Layout.alignment: Qt.AlignRight
            anchors.bottom: parent.bottom
            hspan: 3
            vspan: 2
        }
    }
}

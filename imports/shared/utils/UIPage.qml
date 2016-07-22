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

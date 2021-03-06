/****************************************************************************
**
** Copyright (C) 2017 Pelagicore AG
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

import QtQuick 2.6
import QtQuick.Controls 2.0

import controls 1.0
import utils 1.0


// TODO: Convert to QQC2 ItemDelegate base AppGridDelegate
Control {
    id: root

    property string icon
    property alias titleText: titleLabel.text
    property alias subtitleText: subtitleLabel.text

    signal clicked()

    Image {
        anchors.fill: parent
        anchors.rightMargin: 1
        source: Style.icon('appstore_grid_cell_panel')
        asynchronous: true
    }

    Column {
        anchors.fill: parent
        anchors.bottomMargin: Style.padding

        spacing: Style.paddingXL

        Image {
            id: iconImage

            anchors.horizontalCenter: parent.horizontalCenter

            width: Style.hspan(2)

            source: root.icon //Style.icon(root.icon)

            fillMode: Image.PreserveAspectFit
            asynchronous: true
        }

        Column {
            anchors.left: parent.left; anchors.right: parent.right
            spacing: -10

            Label {
                id: titleLabel

                anchors.left: parent.left; anchors.right: parent.right
                anchors.margins: Style.padding
                font.capitalization: Font.AllUppercase

                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Style.fontSizeS
                color: Style.colorWhite
                elide: Text.ElideRight
            }

            Label {
                id: subtitleLabel

                anchors.left: parent.left; anchors.right: parent.right
                anchors.margins: Style.padding
                font.capitalization: Font.AllUppercase

                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Style.fontSizeXXS
                color: Style.colorGrey
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}

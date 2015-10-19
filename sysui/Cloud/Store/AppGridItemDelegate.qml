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

import controls 1.0
import utils 1.0

UIElement {
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
        anchors.left: parent.left; anchors.right: parent.right
        anchors.bottom: parent.bottom; anchors.bottomMargin: Style.padding

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

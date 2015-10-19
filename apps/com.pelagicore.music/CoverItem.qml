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
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import utils 1.0
import controls 1.0

UIElement {
    id: root
    hspan: 6
    vspan: 12
    signal clicked()
    property alias source: image.source
    property alias title: title.text
    property alias subTitle: subTitle.text

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 0
        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: Style.hspan(5)
            height: width
            Rectangle {
                anchors.fill: parent
                color: Style.colorWhite
                border.color: Qt.darker(color, 1.2)
            }
            Image {
                id: image
                anchors.fill: parent
                anchors.margins: Style.paddingXS
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
            }
        }
        Label {
            id: title
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.Light
            opacity: 0.5
        }
        Label {
            id: subTitle
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Style.fontSizeS
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}

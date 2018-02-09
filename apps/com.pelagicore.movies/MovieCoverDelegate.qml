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
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

import utils 1.0
import controls 1.0

Control {
    id: root
    objectName: "MovieCover::" + title.text
    width: Style.hspan(4)
    height: Style.vspan(7)
    signal clicked()
    property alias source: image.source
    property alias title: title.text
    property bool selected

    Rectangle {
        anchors.fill: parent
        anchors.topMargin: -Style.paddingS
        color: Style.colorGrey
        border.color: Qt.lighter(color, 1.2)
        opacity: root.selected?0.2:0.0
        Behavior on opacity { NumberAnimation {} }
    }
    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 0
        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: height*0.70
            height: Style.vspan(6)
            Rectangle {
                anchors.fill: parent
                color: Style.colorWhite
                border.color: Qt.darker(color, 1.2)
            }
            Image {
                id: image
                objectName: "MovieCover::" + title.text + "Image"
                anchors.fill: parent
                anchors.margins: Style.paddingS
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                smooth: true
            }
        }
        Label {
            id: title
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.Light
            font.pixelSize: Style.fontSizeXS
            height: Style.vspan(1)
            elide: Text.ElideRight
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}

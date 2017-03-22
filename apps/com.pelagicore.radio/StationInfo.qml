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

import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import utils 1.0
import controls 1.0

UIElement {
    id: root
    hspan: 7
    vspan: 12
    signal clicked()
    property alias title: title.text
    property alias radioText: radioText.text
    property real frequency

    ColumnLayout {
        id: theLayout
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: Style.vspan(-1)
        spacing: Style.paddingL
        Item {
            id: mainItem
            height: Style.vspan(1.5)
            width: root.width
            clip: false

            Label {
                id: frequency
                height: Style.vspan(2)
                width: Style.hspan(3)
                text: root.frequency.toFixed(1)
                anchors.right: suffix.left

                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignBottom

                fontSize: Style.fontSizeXXL
            }
            Label {
                id: suffix
                height: Style.vspan(1.2)
                width: Style.hspan(1)

                text: "MHz"

                fontSize: Style.fontSizeXXS
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: frequency.bottom

                anchors.horizontalCenterOffset: Style.hspan(1)
            }
        }

        Label {
            id: title
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.Light
            opacity: 0.5
        }
        Item {
            id: radioTextContainer
            width: root.width
            height: radioText.height
            clip: true

            property bool scrollingText: radioText.contentWidth > radioText.width

            Text {
                id: radioText

                width: parent.width

                horizontalAlignment: radioTextContainer.scrollingText ? Text.AlignLeft : Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.family: Style.fontFamily
                font.pixelSize: Style.fontSizeS
                font.weight: Style.fontWeight

                color: Style.colorWhite

                onTextChanged: {
                    if (text != "" && radioTextContainer.scrollingText ) {
                        pingPongAnimation.running = true
                    } else {
                        pingPongAnimation.running = false
                        radioText.x = 0
                    }
                }
            }

            SequentialAnimation {
                id: pingPongAnimation
                PauseAnimation { duration: 500 }
                NumberAnimation { target: radioText; property: "x"; from: 0; to: radioTextContainer.width - radioText.contentWidth; duration: 3000;  }
                PauseAnimation { duration: 1000 }
                NumberAnimation { target: radioText; property: "x"; to: 0; duration: 3000 }
                PauseAnimation { duration: 500 }
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}

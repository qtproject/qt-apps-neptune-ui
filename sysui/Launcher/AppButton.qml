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
import utils 1.0
import controls 1.0

UIElement {
    id: root

    property alias name: nameLabel.text
    property alias icon: icon.source
    property bool editMode: false
    property bool removable: false
    property bool isUpdating: false

    // Installation progress from 0 to 1. 1 means that the application is installed.
    property real installProgress: 1

    signal clicked()
    signal removeClicked()
    signal pressAndHold()

    hspan: 4
    vspan: 7

    scale: editMode ? 0.8 : 1

    Behavior on scale { NumberAnimation { easing.type: Easing.OutBounce } }

    Rectangle {
        id: background

        anchors.fill: parent
        anchors.margins: 1
        color: Style.colorBlack
        opacity: 0.5
    }

    Rectangle {
        anchors.top: background.top
        anchors.bottom: background.bottom
        anchors.left: background.left
        width: isUpdating ? background.width * Math.min(1.0, Math.max(0.0, installProgress)) : background.width
        color: Style.colorBlack
        opacity: 0.25

        Behavior on width { SmoothedAnimation { } }
    }

    Icon {
        id: icon

        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -Style.padding*3
        anchors.horizontalCenter: parent.horizontalCenter
        hspan: 2
        vspan: 3
        property bool active: mouseArea.pressed && !root.editMode && root.installProgress >= 1.0
        opacity: installProgress < 1.0 && installProgress > 0.0 ? 0.4 : 1.0
        visible: root.icon

        Behavior on opacity { NumberAnimation {  } }
    }

    Label {
        id: nameLabel

        width: parent.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Style.padding*3

        horizontalAlignment: Qt.AlignHCenter
        font.pixelSize: Style.fontSizeM
        opacity: icon.opacity
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: root.clicked()
        onPressAndHold: root.pressAndHold()
    }

    Symbol {
        id: removeIcon

        anchors.verticalCenter: background.top
        anchors.horizontalCenter: background.right

        name: "close"
        size: Style.symbolSizeS
        visible: root.editMode && root.removable
        active: removeMouseArea.pressed
        scale: active ? 0.8 : 1
    }

    MouseArea {
        id: removeMouseArea

        anchors.fill: removeIcon
        enabled: root.editMode && root.removable
        onClicked: root.removeClicked()
    }
}

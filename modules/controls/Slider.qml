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

UIElement {
    id: root;
    hspan: 8
    vspan: 2
    property real value // value is read/write.
    property real minimum: 0
    property real maximum: 1
    property int length: width - handle.width

    property real activeValue

    function valueToString() {
        return activeValue.toFixed(2)
    }

    Rectangle {
        id: background
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        height: 4
        radius: 4
        border.color: Qt.lighter(color, 1.1)
        color: "#999"
        opacity: 0.25
    }

    Image {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.verticalCenter
        source: Style.gfx2('timeline')
        opacity: 0.5
        asynchronous: true
    }

    Rectangle {
        id: labelRect
        width: label.width
        height: label.height + 4
        radius: 4
        smooth: true
        color: "#000"
        border.color: Qt.lighter(color, 1.1)
        anchors.bottom: handle.top
        anchors.bottomMargin: 4
        x: Math.max(Math.min(handle.x + (handle.width - width )/2, root.width - width),0)
        visible: area.pressed
        opacity: 0.75

        Text{
            id: label
            color: Style.colorWhite
            font.family: Style.fontFamily
            font.pixelSize: Style.fontSizeS
            text: root.valueToString()
            width: font.pointSize * 3.5
            anchors.horizontalCenter: labelRect.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.baseline: parent.bottom
            anchors.baselineOffset: -6
        }
    }

    Rectangle {
        id: handle;
        smooth: true
        width: 26;
        y: (root.height - height)/2;
        x: (root.value - root.minimum) * root.length / (root.maximum - root.minimum)

        height: width; radius: width/2
        border.color: Qt.lighter(color, 1.1)
        color: '#fff'

        MouseArea {
            id: area
            hoverEnabled: false
            anchors.fill: parent; drag.target: parent
            drag.axis: Drag.XAxis; drag.minimumX: 0; drag.maximumX: root.length
            onPositionChanged: {
                root.activeValue = root.minimum + (root.maximum - root.minimum) * handle.x / root.length
            }
        }
    }
}

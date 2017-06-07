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

import QtQuick 2.0
import QtQuick.Controls 2.0
import utils 1.0
import controls 1.0

Control {
    id: root

    width: Style.notificationCenterWidth
    height: Style.vspan(2)

    property string iconSource
    property string notificationTitle
    property string notificationDescription

    signal removeNotification()

    Rectangle {
        anchors.fill: parent
        color: '#000'
        opacity: 0.85
    }

    Row {
        id: contentRow
        height: icon.paintedHeight + notificationContent.height
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.left: root.left
        anchors.leftMargin: 20
        spacing: 20

        Image {
            id: icon
            source: root.iconSource
        }

        Column {
            id: notificationContent
            spacing: 5
            Label {
                id: title
                text: root.notificationTitle
            }

            Label {
                id: body
                width: parent.width
                font.pixelSize: Style.fontSizeM
                text: root.notificationDescription
            }
        }
    }

    Tool {
        anchors.right: parent.right
        anchors.top: parent.top
        width: Style.symbolSizeS
        symbol: "close"
        size: Style.symbolSizeXS
        onClicked: root.removeNotification()
    }

    Rectangle {
        width: parent.width
        height: 1
        color: "grey"
        anchors.bottom: parent.bottom
    }
}

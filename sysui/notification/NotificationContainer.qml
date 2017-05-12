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
import models.notification 1.0

Control {
    id: root

    width: Style.hspan(8)
    height: Style.vspan(6)

    visible: opacity > 0

    scale: NotificationModel.notificationVisible ? 1 : 0
    Behavior on scale { NumberAnimation { duration: 200 } }

    opacity: NotificationModel.notificationVisible ? 1 : 0
    Behavior on opacity { NumberAnimation { duration: 200 } }

    Rectangle {
        anchors.fill: parent
        color: '#000'
        opacity: 0.85
    }

    Label {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        text: NotificationModel.title
    }

    Label {
        id: body

        width: parent.width
        anchors.bottom: buttonsRow.top
        anchors.top: title.bottom
        anchors.topMargin: 10
        font.pixelSize: Style.fontSizeM
        text: NotificationModel.description
        horizontalAlignment: Text.AlignHCenter
    }

    Row {
        id: buttonsRow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        spacing: 2

        Repeater {
            id: buttonModel

            property int buttonWidth: model ? root.width / model.length : 0

            model: NotificationModel.buttonModel

            delegate: Button {
                width: buttonModel.buttonWidth
                text: modelData
                onClicked: NotificationModel.buttonClicked(index)
            }
        }
    }

}

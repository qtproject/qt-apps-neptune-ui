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
import models.system 1.0
import models.settings 1.0

Control {
    id: root

    x: SystemModel.notificationCenterVisible ? Style.screenWidth - width : Style.screenWidth
    Behavior on x { NumberAnimation { duration: 200 } }

    MouseArea {
        id: notificationContent
        anchors.fill: parent

        Rectangle {
            id: screenFadingBG
            anchors.fill: parent
            color: "black"
            opacity: 0.8
            visible: opacity > 0.0
        }

        Label {
            id: notificationCenterTitle
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: Style.hspan(0.5)
            horizontalAlignment: Text.AlignHCenter
            text: "Notification Center"
        }

        Symbol {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: Style.hspan(0.1)
            anchors.rightMargin: Style.hspan(0.5)
            size: Style.symbolSizeS
            name: "settings"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    SystemModel.notificationCenterVisible = false
                    SettingsModel.settingsPageVisible = true
                }
            }
        }

        Column {
            anchors.top: notificationCenterTitle.bottom
            Repeater {
                id: notificationRepeater
                model: NotificationModel.model

                delegate: NotificationCenterItem {
                    iconSource: icon
                    notificationTitle: title
                    notificationDescription: description
                    onRemoveNotification: NotificationModel.removeNotification(index)
                }
            }
        }

        Label {
            id: noNotificationLabel
            anchors.fill: parent
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            visible: notificationRepeater.count < 1
            text: "No New Notifications"
        }
    }
}

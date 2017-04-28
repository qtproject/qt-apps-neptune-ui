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

pragma Singleton
import QtQuick 2.0

import utils 1.0
import QtApplicationManager 1.0

QtObject {
    id: root

    readonly property int maxNotifications: 20

    property bool notificationVisible: false
    property int notificationIndex: -1

    property string title
    property string description
    property string icon

    property var buttonModel: []

    property Connections notificationManagerConnection: Connections {
        target: NotificationManager

        onNotificationAdded: {
            var receivedContent = NotificationManager.notification(id);

            if (receivedContent.category === "notification") {
                console.log("::: Notification received :::", id);
                addNotification(receivedContent);
            }
        }

        onNotificationChanged: {
            var receivedContent = NotificationManager.notification(id);

            if (receivedContent.category === "notification") {
                console.log("::: Notification changed :::", id);
                updateNotification(receivedContent);
            }
        }

        onNotificationAboutToBeRemoved: {
            var receivedContent = NotificationManager.notification(id);

            if (receivedContent.category === "notification") {
                closeNotification();
            }
        }
    }

    function addNotification(notification) {
        var notificationId = notification.id;
        var actions = [];
        for (var i in notification.actions) {
            actions.push(i);
        }
        root.buttonModel = actions;
        root.notificationIndex = notificationId;
        root.title = notification.summary;
        root.description = notification.body;
        root.icon = notification.icon;
        root.notificationVisible = true;
    }

    function updateNotification(notification) {
        root.notificationIndex = notification.id;
        root.title = notification.summary;
        root.description = notification.body;
        root.icon = notification.icon;
        var actions = [];
        for (var i in notification.actions) {
            actions.push(i);
        }
        root.buttonModel = actions;
        root.notificationVisible = true;
    }

    function closeNotification() {
        root.title = root.description = "";
        root.buttonModel = [];
        root.notificationIndex = -1;
        root.notificationVisible = false;
    }

    function removeNotification(index) {
        NotificationManager.dismissNotification(index);
        closeNotification();
    }

    function buttonClicked(index) {
        NotificationManager.triggerNotificationAction(root.notificationIndex, root.buttonModel[index]);
        closeNotification();
    }
}


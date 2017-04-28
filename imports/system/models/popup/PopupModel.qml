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
import QtApplicationManager 1.0

QtObject {
    id: root

    property bool popupVisible: false
    property int popupIndex: -1
    property int currentVisiblePopupId: 0
    property var buttonModel: []

    property var popupContentData
    property var popupButtonData

    readonly property Connections notificationManagerConnection: Connections {
        target: NotificationManager

        onNotificationAdded: {
            var receivedContent = NotificationManager.notification(id);

            if (receivedContent.category === "popup") {
                console.log("::: Popup received :::", id);
                root.requestPopup(receivedContent);
            }
        }

        onNotificationChanged: {
            var receivedContent = NotificationManager.notification(id);

            if (receivedContent.category === "popup") {
                console.log("::: Popup changed :::", id);
                root.updatePopup(receivedContent);
            }
        }
    }

    signal showPopup(var contentData, var buttons)

    function requestPopup(popupData) {
        root.popupIndex = popupData.id;
        root.processPopup(popupData);
        root.popupVisible = true;
    }

    function updatePopup(popupData) {
        root.popupIndex = popupData.id;
        root.processPopup(popupData);
        root.popupVisible = true;
    }

    function processPopup(receivedPopup) {
        var receivedBody = receivedPopup.extended;
        var receivedSummary = receivedPopup.summary;
        var receivedButtons = [];
        for (var i in receivedPopup.actions) {
            receivedButtons.push(receivedPopup.actions[i])
        }

        var popupData = {
            body: receivedBody,
            summary: receivedSummary
        };

        root.buttonModel = receivedButtons;
        root.showPopup(popupData, root.buttonModel);
    }

    function buttonPressed(buttonIndex) {
        NotificationManager.triggerNotificationAction(root.popupIndex, root.buttonModel[buttonIndex]);
        NotificationManager.dismissNotification(root.popupIndex);
        root.hideCurrentPopup();
    }

    function hideCurrentPopup() {
        root.buttonModel = [];
        root.popupIndex = -1;
        root.popupVisible = false;
    }
}

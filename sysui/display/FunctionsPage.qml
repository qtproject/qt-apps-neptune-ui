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
import QtQuick.Layouts 1.0

import utils 1.0
import controls 1.0
import models.settings 1.0
import service.popup 1.0
import service.notification 1.0

UIPage {
    id: root

    PopupInterface {
        id: popupInterface
        actions: [ { text: "OK" }, { text: "Cancel" } ]
        title: "Car Settings"

        property bool currentState: false
        property url functionIcon
        property string functionName
        property int functionIndex: -1

        onActionTriggered: {
            if (actionId === "0" && !currentState) {
                SettingsModel.functions.setProperty(functionIndex, "active", true)
                notificationInterface.icon = functionIcon
                notificationInterface.body = functionName + " activated"
                notificationInterface.show()
            } else if (actionId === "0" && currentState) {
                SettingsModel.functions.setProperty(functionIndex, "active", false)
                notificationInterface.icon = functionIcon
                notificationInterface.body = functionName + " deactivated"
                notificationInterface.show()
            }
            currentState = false
            functionName = ""
            functionIndex = -1
        }
    }

    NotificationInterface {
        id: notificationInterface
        summary: "Vehicle Functions"
    }

    header: AppInfoPanel {
        Layout.fillWidth: true
        Layout.preferredHeight: Style.vspan(2)
        title: 'Car Settings'
        symbolName: 'settings'
    }

    GridView {
        id: view
        anchors.fill: parent
        anchors.margins: 24

        interactive: false
        model: SettingsModel.functions

        clip: false // true

        cellWidth: width/3
        cellHeight: height/3

        delegate: FunctionButton {
            width: GridView.view.cellWidth
            height: GridView.view.cellHeight
            text: qsTrId(model.description)
            icon: Style.symbolM(model.icon, model.active)
            highlighted: model.active

            onClicked: {
                popupInterface.functionIcon = icon
                popupInterface.currentState = model.active
                popupInterface.functionIndex = index
                popupInterface.functionName = qsTrId(model.description)
                popupInterface.summary = !model.active ? "Activate " + popupInterface.functionName + " ?" : "Deactivate " + popupInterface.functionName + " ?"
                popupInterface.show()
            }
        }
    }
}

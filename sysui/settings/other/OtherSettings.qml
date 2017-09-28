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
import QtQuick.Controls 2.0

import controls 1.0
import utils 1.0
import models.settings 1.0
import models.application 1.0

Item {
    id: root
    width: Style.hspan(24)
    height: Style.vspan(20)

    property string title: "Others Settings"

    Label {
        id: unitTitle
        anchors.top: parent.top
        anchors.topMargin: Style.vspan(1)
        anchors.left: units.left
        text: "Units:"
    }

    ListItem {
        id: units
        width: Style.hspan(20)
        height: Style.vspan(2)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: unitTitle.bottom
        anchors.topMargin: Style.vspan(0.8)

        text: "Units of Measurement";
        icon: "fees";
        hasChildren: false

        onClicked: {
            if (SettingsModel.unitSystem === "imp_us")
                SettingsModel.unitSystem = "metric"
            else
                SettingsModel.unitSystem = "imp_us"
        }

        RowLayout {
            width: Style.hspan(4)
            anchors.right: units.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            SettingsRadioButton {
                id: imperial
                buttonText: "Imperial"
                checked: SettingsModel.unitSystem === "imp_us"
                onClicked: SettingsModel.unitSystem = "imp_us"
            }

            SettingsRadioButton {
                id: metric
                buttonText: "Metric"
                checked: SettingsModel.unitSystem === "metric"
                onClicked: SettingsModel.unitSystem = "metric"
            }
        }
    }

    Label {
        id: appUpdatesTitle
        anchors.top: units.bottom
        anchors.topMargin: Style.vspan(1)
        anchors.left: units.left
        text: "Application:"
    }

    ListItemSwitch {
        id: appUpdates
        width: Style.hspan(20)
        height: Style.vspan(2)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: appUpdatesTitle.bottom
        anchors.topMargin: Style.vspan(0.8)

        text: "Application Updates";
        icon: "updates";
        hasChildren: false
        checked: SettingsModel.appUpdatesEnabled
        onClicked: SettingsModel.appUpdatesEnabled = !SettingsModel.appUpdatesEnabled
    }

    Label {
        id: trafficTitle
        anchors.top: appUpdates.bottom
        anchors.topMargin: Style.vspan(1)
        anchors.left: appUpdates.left
        text: "Navigation:"
    }

    ListItemSwitch {
        id: liveTraffic
        width: Style.hspan(20)
        height: Style.vspan(2)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: trafficTitle.bottom
        anchors.topMargin: Style.vspan(0.8)

        text: "Live Traffic Information"
        icon: "warning"
        hasChildren: false
        checked: SettingsModel.liveTrafficEnabled
        onClicked: SettingsModel.liveTrafficEnabled = !SettingsModel.liveTrafficEnabled
    }

    ListItemSwitch {
        id: satelliteView
        width: Style.hspan(20)
        height: Style.vspan(2)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: liveTraffic.bottom
        anchors.topMargin: Style.vspan(0.8)

        text: "Satellite View"
        icon: "compass"
        hasChildren: false
        checked: SettingsModel.satelliteViewEnabled
        onClicked: SettingsModel.satelliteViewEnabled = !SettingsModel.satelliteViewEnabled
    }
}

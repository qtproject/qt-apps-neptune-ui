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
import QtQuick.Controls 2.2

import controls 1.0
import utils 1.0
import animations 1.0
import models.settings 1.0

Page {
    id: root
    x: opacity < 1.0 ? -width : 0
    width: Style.hspan(24)
    height: Style.vspan(20)
    opacity: SettingsModel.settingsPageVisible ? 1.0 : 0.0

    Behavior on opacity {
        NumberAnimation {
            duration: 200
        }
    }

    Behavior on x {
        NumberAnimation {
            duration: 200
        }
    }

    background: Rectangle {
        objectName: "Settings::Background"
        anchors.fill: parent
        color: Style.colorGrey
    }

    Label {
        id: settingsTitle
        objectName: "Settings::Title" + settingsTitle.text.replace(" ", "")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: Style.hspan(0.5)
        horizontalAlignment: Text.AlignHCenter
        visible: root.opacity === 1.0
    }

    ListModel {
        id: pageModel
        ListElement {
            title: "Profile Settings"
            page: "driverprofile/ProfileSettings.qml"
            iconName: "profile"
        }

        ListElement {
            title: "Animation Settings"
            page: "animation/AnimationsSettings.qml"
            iconName: "settings"
        }

        ListElement {
            title: "System Monitor"
            page: "systemmonitor/MainScreen.qml"
            iconName: "insurance"
        }

        ListElement {
            title: "Language Settings"
            page: "language/LanguageSettings.qml"
            iconName: "information"
        }

        ListElement {
            title: "Other Settings"
            page: "other/OtherSettings.qml"
            iconName: "settings"
        }
    }

    StackView {
        id: stackView
        width: Style.hspan(24)
        height: Style.vspan(20)
        anchors.top: settingsTitle.bottom
        anchors.topMargin: Style.hspan(0.5)
        anchors.horizontalCenter: parent.horizontalCenter
        visible: root.opacity === 1.0

        initialItem: Item {
            objectName: "Settings::ListPlaceHolder"
            width: stackView.width
            height: stackView.height
            ListViewManager {
                id: settingsListView
                model: pageModel
                anchors.fill: parent
                delegate: ListItem {
                    objectName: parent.objectName + text.replace(" ", "")
                    width: Style.hspan(20)
                    height: Style.vspan(2)
                    text: title
                    icon: iconName
                    onClicked: stackView.push(Qt.resolvedUrl(page))
                }
            }
        }

        onCurrentItemChanged: {
            settingsTitle.text = "Neptune Settings"
            if (stackView.depth > 0 && currentItem.title !== undefined)
                settingsTitle.text = currentItem.title
        }
    }

    Tool {
        id: backButton
        objectName: "Settings::BackSymbol"
        anchors.left: parent.left
        anchors.top: parent.top
        width: Style.hspan(2)
        height: Style.vspan(2)
        visible: root.opacity === 1.0
        symbol: 'back'
        onClicked: {
            if (stackView.depth > 1) {
                stackView.pop()
            } else {
                SettingsModel.settingsPageVisible = false
            }
        }
    }
}

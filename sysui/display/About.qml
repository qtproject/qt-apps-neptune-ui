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
import models.settings 1.0
import models.system 1.0

import QtQuick.Layouts 1.3

Control {
    id: root

    y: SystemModel.statusBarExpanded ? 0 : -height
    width: Style.screenWidth
    height: Style.vspan(20)

    readonly property bool _fullyHidden: y === -height
    on_FullyHiddenChanged: {
        if (_fullyHidden) {
            // reset state
            _showUISettings = false;
        }
    }
    visible: !_fullyHidden // Don't bother QSG rendering when offscreen

    property bool _showUISettings: false

    Behavior on y {
        NumberAnimation { duration: 500; easing.type: Easing.OutCubic }
    }

    Item {
        anchors.fill: parent

        opacity: root._showUISettings ? 0 : 1
        visible: opacity > 0
        Behavior on opacity {
            NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
        }

        Image {
            id: logo
            width: Style.hspan(7)
            height: Style.vspan(4)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: Style.vspan(2)
            source: Style.gfx2Dynamic("pelagicore_colored_white", Style.defaultGfxSize)

            fillMode: Image.PreserveAspectFit

        }

        Label {
            id: description
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: logo.bottom
            width: Style.hspan(12)
            height: Style.vspan(4)
            horizontalAlignment: Text.AlignHCenter

            text: "We put Stunning User Experiences on the road"
            wrapMode: Text.Wrap
            font.pixelSize: Style.fontSizeL
            font.bold: true

        }

        Image {
            width: Style.hspan(20)
            height: Style.vspan(16)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -Style.vspan(2)
            anchors.horizontalCenter: parent.horizontalCenter
            source: Style.gfx2("boxes_layers")
            fillMode: Image.PreserveAspectFit

            Tracer {}
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (SystemModel.climateExpanded) {
                SystemModel.climateExpanded.expanded = false
            } else {
                SystemModel.statusBarExpanded = false
            }
        }
    }

    ColumnLayout {
        id: settingsUI
        anchors.fill: parent
        anchors.topMargin: Style.hspan(2)
        anchors.leftMargin: Style.hspan(4)
        anchors.rightMargin: Style.hspan(4)

        opacity: root._showUISettings ? 1 : 0
        visible: opacity > 0
        Behavior on opacity {
            NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter
            Label { text: "Window Transitions:" }
            ComboBox {
                id: windowTransitionsComboBox
                model: SettingsModel.windowTransitions
                textRole: "name"

                // NB: binding will be broken as soon as the user makes his first selection
                currentIndex: SettingsModel.windowTransitionsIndex

                // Ensure model and combo box are kept in sync
                onCurrentIndexChanged: {
                    SettingsModel.windowTransitionsIndex = currentIndex;
                }
                Connections {
                    target: SettingsModel
                    onWindowTransitionsIndexChanged: {
                        windowTransitionsComboBox.currentIndex = SettingsModel.windowTransitionsIndex
                    }
                }

                width: Style.hspan(5)
                implicitWidth: width
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter
            Label { text: qsTrId("language_id") + ": " }
            ComboBox {
                id: languageComboBox
                width: Style.hspan(5)
                implicitWidth: width
                model: SettingsModel.languages
                textRole: "name"
                onCurrentIndexChanged: {
                    SettingsModel.currentLanguageIndex = currentIndex;
                }

                Connections {
                    target: SettingsModel
                    onCurrentLanguageIndexChanged: {
                        Style.languageLocale = SettingsModel.languages.get(languageComboBox.currentIndex).name
                    }
                }
            }
        }

    }

    Symbol {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: Style.hspan(2)
        anchors.rightMargin: Style.hspan(0.5)
        size: Style.symbolSizeS
        name: "settings"
        MouseArea {
            anchors.fill: parent
            onClicked: root._showUISettings = !root._showUISettings
        }
    }

//    Button {
//        id: closeButton
//        anchors.top: parent.top
//        anchors.horizontalCenter: parent.horizontalCenter
//        text: "Restart UI"
//        onClicked: Qt.quit()
//    }

    Tracer {}
}

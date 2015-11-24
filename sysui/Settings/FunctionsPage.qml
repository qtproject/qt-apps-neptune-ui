/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
** Contact: http://www.qt.io/ or http://www.pelagicore.com/
**
** This file is part of the Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:GPL3-PELAGICORE$
** Commercial License Usage
** Licensees holding valid commercial Pelagicore Neptune IVI UI
** licenses may use this file in accordance with the commercial license
** agreement provided with the Software or, alternatively, in accordance
** with the terms contained in a written agreement between you and
** Pelagicore. For licensing terms and conditions, contact us at:
** http://www.pelagicore.com.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU General Public License version 3 requirements will be
** met: http://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
** SPDX-License-Identifier: GPL-3.0
**
****************************************************************************/

import QtQuick 2.1
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

import controls 1.0
import utils 1.0
import service.settings 1.0

UIPage {
    id: root
    hspan: 24
    vspan: 24

    title: qsTr('Car Settings')
    symbolName: "settings"

    GridView {
        id: view

        anchors.top: parent.top
        anchors.topMargin: Style.vspan(2)
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        width: Style.hspan(6*3)

        model: SettingsService.functions

        clip: false // true

        cellWidth: Style.hspan(6)
        cellHeight: Style.vspan(5)

        delegate: Item {
            property bool active: model.active

            width: view.cellWidth
            height: view.cellHeight

            HDiv {
                id: div
                width: parent.width
                vspan: 1
            }

            RowLayout {
                spacing: Style.paddingXL
                anchors.top: div.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 4

                Item {
                    Layout.preferredWidth: rect.width
                    Layout.preferredHeight: parent.height

                    RectangularGlow {
                        anchors.fill: rect
                        glowRadius: 5
                        spread: 0
                        color: Style.colorOrange
                        cornerRadius: 10
                        visible: active
                    }

                    Rectangle {
                        id: rect
                        color: active ? Style.colorOrange : "#444"
                        width: 4
                        radius: 2
                        height: parent.height
                    }
                }

                Image {
                    source: Style.symbolM(model.icon)
                }

                Label {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: model.description
                    wrapMode: Text.WordWrap
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: active = !active
            }
        }
    }
}

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

import QtQuick 2.0
import QtQuick.Layouts 1.0
import utils 1.0
import controls 1.0
import "."

Item {
    width: 800
    height: parent.height

    ListView {
        id: playListView
        width: 400
        height: parent.height
        anchors.centerIn: parent
        clip: true
        model: MusicProvider.model
        currentIndex: MusicProvider.currentIndex
        highlight: Rectangle {
            color: Style.colorWhite; opacity: 0.25
            border.color: Qt.lighter(color, 1.2)
        }
        highlightMoveDuration: 75
        delegate: UIElement {
            hspan: 4
            vspan: 2
            RowLayout {
                anchors.fill: parent
                spacing: 0
                Item {
                    Layout.fillHeight: true
                    width: Style.hspan(1)
                    Item {
                        anchors.fill: parent
                        anchors.margins: Style.padding
                        Rectangle {
                            anchors.fill: parent
                            anchors.leftMargin: -6
                            anchors.rightMargin: -6
                            anchors.topMargin: -2
                            anchors.bottomMargin: -2
                            color: Style.colorWhite
                        }

                        Image {
                            anchors.centerIn: parent
                            height: parent.height
                            width: parent.height
                            source: MusicProvider.coverPath(model.cover)
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                        }
                    }
                }
                ColumnLayout {
                    spacing: 0
                    Label {
                        text: model.title
                        font.pixelSize: Style.fontSizeXS
                        opacity: 0.5
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                    Label {
                        text: model.artist
                        font.pixelSize: Style.fontSizeS
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                    }
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    MusicProvider.currentIndex = index
                }
            }
        }
    }
}


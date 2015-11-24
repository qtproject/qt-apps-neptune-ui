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

import controls 1.0
import utils 1.0
import service.music 1.0

UIPanel {
    id: root
    hspan: 10
    vspan: 8

    signal showFullscreen()

    property var track: MusicService.currentTrack

    scale: area.pressed?0.85:1.0

    Behavior on scale {
        NumberAnimation {}
    }

    MouseArea {
        id: area
        anchors.fill: parent
        onClicked: root.showFullscreen()
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: Style.padding

        Spacer {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        RowLayout {
            spacing: 0

            Spacer {
                width: Style.hspan(0.5)
            }

            ColumnLayout {
                spacing: Style.paddingXS

                Label {
                    vspan: 1
                    Layout.fillWidth: true
                    text: track ? qsTr('%1 / %2').arg(track.artist).arg(track.album) : ""
                    font.pixelSize: Style.fontSizeS
                    font.capitalization: Font.AllUppercase
                    horizontalAlignment: Text.AlignLeft
                    elide: Text.ElideRight
                }

                Label {
                    Layout.fillWidth: true
                    vspan: 1
                    text: track ? track.track : ""
                    font.pixelSize: Style.fontSizeL
                    font.capitalization: Font.AllUppercase
                    horizontalAlignment: Text.AlignLeft
                    elide: Text.ElideRight
                }

                Label {
                    Layout.fillWidth: true
                    vspan: 1
                    text: qsTr('%1 / %2').arg(MusicService.currentTime).arg(MusicService.durationTime)
                    font.pixelSize: Style.fontSizeL
                    horizontalAlignment: Text.AlignLeft
                    elide: Text.ElideRight
                }
            }

            Spacer {
                width: Style.hspan(0.25)
            }
        }

        RowLayout {
            spacing: Style.hspan(1)

            Tool {
                name: "prev"
                vspan: 2
                Layout.fillWidth: true
                onClicked: MusicService.previousTrack()
            }
            Tool {
                vspan: 2
                Layout.fillWidth: true
                name: "play"
                onClicked: MusicService.musicPlay()
                active: MusicService.playing
            }
            Tool {
                vspan: 2
                Layout.fillWidth: true
                name: "pause"
                onClicked: MusicService.pause()
                active: !MusicService.playing
            }
            Tool {
                vspan: 2
                Layout.fillWidth: true
                name: "next"
                onClicked: MusicService.nextTrack()
            }
        }
    }
}

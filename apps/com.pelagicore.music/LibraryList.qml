/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
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
import "."

UIElement {
    id: root
    hspan: 10
    vspan: 18

    property string type: ""
    property bool nowPlaying: false

    onTypeChanged: {
        if (type === "songs")
            MusicProvider.querySongs()
        else if (type === "artists")
            MusicProvider.queryArtists()
        else if (type === "albums")
            MusicProvider.queryAllAlbums()
    }

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    ListView {
        id: listView
        anchors.fill: parent
        anchors.topMargin: 10
        model: root.nowPlaying ? MusicProvider.nowPlaying.model : MusicProvider.musicLibrary.model
        clip: true
        highlightMoveDuration: 300
        highlightFollowsCurrentItem: false
        currentIndex: MusicProvider.currentIndex

        delegate: UIElement {
            hspan: root.hspan
            vspan: 3

            Rectangle {
                anchors.fill: parent
                opacity: 0.2
                visible: listView.currentIndex === index
            }

            Rectangle {
                width: parent.width
                height: 1
                opacity: 0.2
                color: "white"
            }

            Row {
                anchors.verticalCenter: parent.verticalCenter
                Icon {
                    hspan: 2
                    vspan: hspan
                    anchors.verticalCenter: parent.verticalCenter
                    fit: true
                    source: MusicProvider.coverPath(model.cover)
                }

                Column {
                    Label {
                        hspan: 7
                        vspan: 1
                        text: root.type === "albums" ? model.album.toUpperCase() : model.title.toUpperCase()
                        font.pixelSize: Style.fontSizeM
                    }
                    Label {
                        hspan: 7
                        vspan: 1
                        text: model.artist.toUpperCase()
                        font.pixelSize: Style.fontSizeS
                        font.bold: true
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (root.nowPlaying) {
                        MusicProvider.currentIndex = index
                    }
                    else {
                        listView.currentIndex = index
                        if (root.type === "songs") {
                            MusicProvider.selectSpecSong()
                            MusicProvider.currentIndex = index
                        }
                        else if (root.type === "artists")
                            MusicProvider.querySpecArtist(model.artist)
                        else if (root.type === "albums")
                            MusicProvider.querySpecAlbum(model.album)
                    }
                    MusicService.play()
                }
            }
        }

        Rectangle {
            width: parent.width
            height: 300
            anchors.bottom: parent.bottom
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 1.0; color: "black" }
            }
        }
    }

}


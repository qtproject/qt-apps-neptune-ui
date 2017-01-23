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
import service.music 1.0
import "."

Control {
    id: root
    width: Style.hspan(10)
    height: Style.vspan(18)

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
//        anchors.topMargin: 10
//        anchors.bottomMargin: 84
        model: root.nowPlaying ? MusicProvider.nowPlaying.model : MusicProvider.musicLibrary.model
        clip: true
        highlightMoveDuration: 300
        highlightFollowsCurrentItem: false
        snapMode: ListView.SnapOneItem
        currentIndex: MusicProvider.currentIndex

        delegate: Control {
            width: root.width
            height: Style.vspan(3)

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
                padding: Style.padding
                spacing: 0
                Icon {
                    width: height
                    height: Style.vspan(3)
                    fit: true
                    source: MusicProvider.coverPath(model.cover)
                }

                Column {
                    spacing: 0
                    padding: Style.padding
                    Label {
                        width: Style.hspan(7)
                        height: Style.vspan(2)
                        text: root.type === "albums" ? model.album.toUpperCase() : model.title.toUpperCase()
                        font.pixelSize: Style.fontSizeM
                    }
                    Label {
                        width: Style.hspan(7)
                        height: Style.vspan(1)
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
    }
}

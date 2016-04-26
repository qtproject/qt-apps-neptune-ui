/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
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
import QtQuick 2.1
import QtApplicationManager 1.0
import com.pelagicore.datasource 1.0
import service.music 1.0

QtObject {
    id: root

    property SqlQueryDataSource musicLibrary: SqlQueryDataSource {
        database: "media"
        query: 'select * from music'
    }

    property SqlQueryDataSource nowPlaying: SqlQueryDataSource {
        database: "media"
        query: 'select * from music'
    }

    property int currentIndex: 0
    property int count: nowPlaying.count
    onCountChanged: {
        currentIndex = -1
        currentIndex = 0
    }
    property var currentEntry: nowPlaying.get(currentIndex);
    property url currentSource: nowPlaying.storageLocation + '/media/music/' + currentEntry.source
    property url currentCover: nowPlaying.storageLocation + '/media/music/' + currentEntry.cover

    function queryAllAlbums() {
        musicLibrary.query = 'select * from music group by album'
    }

    function querySongs() {
        musicLibrary.query = 'select distinct * from music'
    }

    function queryArtists() {
        musicLibrary.query = 'select * from music group by artist'
    }

    function querySpecArtist(artist) {
        nowPlaying.query = "select distinct * from music where artist='" + artist + "'"
    }

    function querySpecAlbum(album) {
        nowPlaying.query = "select distinct * from music where album='" + album + "'"
    }

    function selectSpecSong () {
        nowPlaying.query = 'select distinct * from music'
    }

    function selectRandomTracks() {
        nowPlaying.query = 'select distinct * from music order by random()'
    }

    function coverPath(cover) {
        return Qt.resolvedUrl(root.nowPlaying.storageLocation + '/media/music/' + cover)
    }

    function sourcePath(source) {
        return Qt.resolvedUrl(root.nowPlaying.storageLocation + '/media/music/' + source)
    }

    function next() {
        print('MusicService.nextTrack()')
        if (root.currentIndex < root.count - 1)
            currentIndex++
    }

    function previous() {
        print('MusicService.previousTrack()')
        if (currentIndex > 0)
            currentIndex--
    }

    function initialize() {
        MusicService.musicProvider = root
        MusicService.currentIndex = Qt.binding(function() { return root.currentIndex})
        MusicService.currentTrack = Qt.binding(function() { return root.currentEntry})
        MusicService.trackCount = Qt.binding(function() { return root.nowPlaying.count})
        MusicService.coverPath = Qt.binding(function() { return root.currentCover})
        MusicService.url = Qt.binding(function() { return root.currentSource})
    }


    property Item ipc: Item {
        ApplicationInterfaceExtension {
            id: musicRemoteControl

            name: "com.pelagicore.music.control"
        }

        Binding { target: musicRemoteControl.object; property: "currentTrack"; value: MusicService.currentTrack }
        Binding { target: musicRemoteControl.object; property: "currentTime"; value: MusicService.currentTime }
        Binding { target: musicRemoteControl.object; property: "durationTime"; value: MusicService.durationTime }
        Binding { target: musicRemoteControl.object; property: "playing"; value: MusicService.playing }

        Connections {
            target: musicRemoteControl.object

            onPlay: {
                MusicService.musicPlay()
            }

            onPause: {
                MusicService.pause()
            }

            onPreviousTrack: {
                MusicService.previousTrack()
            }

            onNextTrack: {
                MusicService.nextTrack()
            }
        }
    }

    Component.onCompleted: {
        print("MusicProvider completed", root.count)

    }
}

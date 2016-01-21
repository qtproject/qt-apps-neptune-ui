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

pragma Singleton
import QtQuick 2.1
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

    Component.onCompleted: {
        print("MusicProvider completed", root.count)

    }
}

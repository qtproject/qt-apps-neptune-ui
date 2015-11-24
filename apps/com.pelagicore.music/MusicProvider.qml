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

pragma Singleton
import QtQuick 2.1
import com.pelagicore.datasource 1.0
import service.music 1.0

SqlQueryDataSource {
    id: root

    database: "media"
    query: 'select * from music'
    property int currentIndex: 0
    property var currentEntry: get(currentIndex);
    property url currentSource: storageLocation + '/media/music/' + currentEntry.source
    property url currentCover: storageLocation + '/media/music/' + currentEntry.cover

    function queryAllAlbums() {
        return 'select distinct album, cover, artist from music'
    }

    function queryAlbum(artist, album) {
        return 'select * from music'
    }

    function selectRandomTracks() {
        currentIndex = -1
        root.query = 'select * from music order by random()'
        currentIndex = 0
    }


    function coverPath(cover) {
        return Qt.resolvedUrl(storageLocation + '/media/music/' + cover)
    }

    function sourcePath(source) {
        return Qt.resolvedUrl(storageLocation + '/media/music/' + source)
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

    Component.onCompleted: {
        MusicService.musicProvider = root
        MusicService.currentIndex = Qt.binding(function() { return root.currentIndex})
        MusicService.currentTrack = Qt.binding(function() { return root.currentEntry})
        MusicService.trackCount = Qt.binding(function() { return root.count})
        MusicService.coverPath = Qt.binding(function() { return root.currentCover})
        MusicService.url = Qt.binding(function() { return root.currentSource})
        print("MusicProvider completed")

    }
}

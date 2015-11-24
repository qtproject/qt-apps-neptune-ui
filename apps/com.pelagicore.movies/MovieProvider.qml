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
import service.movie 1.0

SqlQueryDataSource {
    id: root
    database: "media"

    property int currentIndex: 0
    property var currentEntry: get(currentIndex);
    property url currentSource: storageLocation + '/media/movies/' + currentEntry.source
    property url currentCover: storageLocation + '/media/movies/' + currentEntry.cover

    function selectRandom() {
        root.currentIndex = -1
        query = 'select * from movies order by random()'
        root.currentIndex = 0
    }

    function coverPath(cover) {
        return Qt.resolvedUrl(storageLocation + '/media/movies/' + cover)
    }

    function sourcePath(source) {
        return Qt.resolvedUrl(storageLocation + '/media/movies/' + source)
    }

    function next() {
        print('$movies.nextTrack()')
        root.currentIndex++
    }

    function previous() {
        print('$movies.previousTrack()')
        root.currentIndex--
    }

    Component.onCompleted: {
        MovieService.movieProvider = root
        MovieService.trackCount = Qt.binding(function() { return root.count})
        MovieService.currentTrack = Qt.binding(function() { return root.get(root.currentIndex)})
        MovieService.currentIndex = Qt.binding(function() { return root.currentIndex})
        print("Movie provider completed")
    }
}

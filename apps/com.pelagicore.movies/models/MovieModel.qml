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

pragma Singleton
import QtQuick 2.6
import com.pelagicore.datasource 1.0

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
        console.log('$movies.nextTrack()')
        root.currentIndex++
    }

    function previous() {
        console.log('$movies.previousTrack()')
        root.currentIndex--
    }
}

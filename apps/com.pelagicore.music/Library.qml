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
import "."

UIElement {
    id: root
    hspan: 12
    vspan: 22

    signal close()

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Tool {
        id: closeButton
        vspan: 2
        hspan: 2

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 35
        name: 'close'
        onClicked: root.close()
    }

    TabView {
        id: tabView
        vspan: root.vspan - 2
        hspan: root.hspan
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        horizontalAlignment: false
        viewLeftMargin: letterPicker.width
        tabWidth: 2
        tabs: [
            { title : "PLAYING", url : nowPlaying, properties : {} },
            { title : "ARTISTS", url : library, properties : { type: "artists" } },
            { title : "ALBUMS", url : library, properties : { type: "albums" } },
            { title : "SONGS", url : library, properties : { type: "songs" } },
        ]

    }

    LetterPicker {
        id: letterPicker
        vspan: root.vspan - 3
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        numOfVisibleLetters: 17
    }

    LibraryList {
        id: nowPlaying
        visible: false
        nowPlaying: true
    }

    LibraryList {
        id: library
        visible: false
    }
}


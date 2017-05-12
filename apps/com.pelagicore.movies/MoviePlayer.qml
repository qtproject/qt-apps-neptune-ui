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
import QtMultimedia 5.0
import QtGraphicalEffects 1.0

import controls 1.0
import utils 1.0
import "models"
import "."

UIScreen {
    id: root
    width: Style.hspan(24)
    height: Style.vspan(24)

    title: 'Movies'

    property bool active: false
    property bool hideControls: false

    property var track: MovieModel.currentEntry


    Video {
        id: video
        anchors.fill: parent
        source: MovieModel.sourcePath(root.track.source)
        autoPlay: true

        property bool running: playbackState === MediaPlayer.PlayingState

        function togglePlay() {
            if (running) {
                pause()
            } else {
                play()
            }
        }
    }

    Rectangle {
        anchors.fill: toolBar
        anchors.margins: -Style.paddingL
        color: '#000'
        opacity: toolBar.opacity * 0.85
        radius: 8
    }
    ColumnLayout {
        id: toolBar
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Style.vspan(4)
        spacing: 0
        opacity: root.hideControls?0.0:1.0
        Behavior on opacity {
            NumberAnimation { duration: 1000 }
        }
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: Style.hspan(2)
            Tool {
                symbol: 'prev'
                onClicked: MovieModel.previousTrack()
            }
            Tool {
                symbol: video.running?'pause':'play'
                onClicked: video.togglePlay()
            }
            Tool {
                symbol: 'next'
                onClicked: MovieModel.next()
            }
        }
        Slider {
            anchors.horizontalCenter: parent.horizontalCenter
            value: video.position
            from: 0.00
            to: video.duration
            height: Style.vspan(1)
            function valueToString() {
                return Math.floor(value/60000) + ':' + Math.floor((value/1000)%60)
            }
            onValueChanged: {
                video.seek(value)
            }
        }
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Symbol {
                width: Style.hspan(1)
                height: Style.vspan(2)
                size: Style.symbolSizeXS
                name: 'speaker'
            }
            VolumeSlider {
                width: Style.hspan(8)
                height: Style.vspan(2)
                anchors.horizontalCenter: parent.horizontalCenter
                value: video.volume
                onValueChanged: {
                    video.volume = value
                }
            }
            Label {
                width: Style.hspan(1)
                height: Style.vspan(2)
                text: Math.floor(video.volume*100)
            }
        }

    }

    MouseArea {
        id: clickOverlay
        anchors.fill: parent
        onClicked: {
            root.hideControls = false
            enabled = false
            hideTimer.start()
        }
    }

    Timer {
        id: hideTimer
        interval: 5000
        running: video.running
        onTriggered: {
            root.hideControls = true
            clickOverlay.enabled = true
        }
    }

    Component.onDestruction: {
        // required to avoid crashing qmllive
        video.source = ''
    }
}

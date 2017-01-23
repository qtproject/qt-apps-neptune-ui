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

UIScreen {
    id: root
    objectName: 'CurrentTrackScreen'
    width: Style.hspan(24)
    height: Style.vspan(24)

    property var track: MusicProvider.currentEntry
    property bool libraryVisible: false

    signal showAlbums()


    ColumnLayout {
        id: musicControl
        width: Style.hspan(12)
        height: parent.height - Style.vspan(2)
        anchors.centerIn: parent
        spacing: 0
//        Spacer { Layout.preferredHeight: Style.vspan(1); Layout.fillWidth: true }
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Tool {
                Layout.preferredWidth: Style.hspan(2)
                symbol: 'prev'
                onClicked: {
                    if (MusicProvider.currentIndex === 0)
                        MusicProvider.currentIndex = MusicProvider.count - 1
                    else
                        MusicProvider.currentIndex --
                }
            }

            TrackSwipeView {
                contentWidth: Style.hspan(6)

                Layout.preferredWidth: Style.hspan(6)
                Layout.preferredHeight: Style.vspan(12)

                model: MusicProvider.nowPlaying.model

                currentIndex: MusicProvider.currentIndex

                delegate: CoverItem {
                    z: PathView.z
                    scale: PathView.scale
                    source: MusicProvider.coverPath(model.cover)
                    title: model.title
                    subTitle: model.artist
                    onClicked: {
                        root.showAlbums()
                    }
                }

            }

            Tool {
                Layout.preferredWidth: Style.hspan(2)
                symbol: 'next'
                onClicked: {
                    if (MusicProvider.currentIndex === MusicProvider.count - 1)
                        MusicProvider.currentIndex = 0
                    else
                        MusicProvider.currentIndex ++
                }
            }
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0

            Label {
                Layout.preferredWidth: Style.hspan(1)
                text: MusicService.currentTime
                font.pixelSize: Style.fontSizeS
            }

            Slider {
                id: slider
                Layout.preferredWidth: Style.hspan(9)
                value: MusicService.position
                from: 0.00
                to: MusicService.duration
                Layout.preferredHeight: Style.vspan(1)
                function valueToString() {
                    return Math.floor(value/60000) + ':' + Math.floor((value/1000)%60)
                }
                onValueChanged: {
                    MusicService.seek(value)
                }
            }

            Label {
                Layout.preferredWidth: Style.hspan(1)
                text: MusicService.durationTime
                font.pixelSize: Style.fontSizeS
            }
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Tool {
                Layout.preferredWidth: Style.hspan(2)
                symbol: 'shuffle'
                onClicked: toggle()
                size: Style.symbolSizeXS
            }
            Spacer { Layout.preferredWidth: Style.hspan(2) }
            Tool {
                Layout.preferredWidth: Style.hspan(2)
                symbol: MusicService.playing?'pause':'play'
                onClicked: MusicService.togglePlay()
            }
            Spacer { Layout.preferredWidth: Style.hspan(2) }
            Tool {
                Layout.preferredWidth: Style.hspan(2)
                symbol: 'loop'
                onClicked: toggle()
                size: Style.symbolSizeXS
            }
        }
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Symbol {
                Layout.preferredWidth: Style.hspan(1)
                size: Style.symbolSizeXS
                name: 'speaker'
            }
            VolumeSlider {
                Layout.preferredWidth: Style.hspan(8)
                Layout.preferredHeight: Style.vspan(2)
                anchors.horizontalCenter: parent.horizontalCenter
                value: MusicService.volume
                onValueChanged: {
                    MusicService.volume = value
                }
            }
            Label {
                Layout.preferredWidth: Style.hspan(1)
                horizontalAlignment: Text.AlignHCenter
                height: Style.vspan(2)
                text: Math.floor(MusicService.volume*100)
            }
        }
        Spacer {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    Library {
        id: library
        x: parent.width
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: Style.vspan(2)
        opacity: 0
        visible: opacity > 0
        onClose: {
            root.libraryVisible = false
        }
    }

    Control {
        id: sourceOption
        width: Style.hspan(4)
        height: Style.vspan(12)
        anchors.right: musicControl.left
        anchors.rightMargin: Style.hspan(1)
        anchors.verticalCenter: parent.verticalCenter

        Column {
            spacing: 0
            Button {
                width: Style.hspan(4)
                height: Style.vspan(4)
                text: "BLUETOOTH"
                font.pixelSize: Style.fontSizeL
            }
            Button {
                width: Style.hspan(4)
                height: Style.vspan(4)
                text: "USB"
                enabled: false
                font.pixelSize: Style.fontSizeL
            }
            Button {
                width: Style.hspan(4)
                height: Style.vspan(4)
                text: "SPOTIFY"
                enabled: false
                font.pixelSize: Style.fontSizeL
            }
        }
    }

    Tool {
        id: libraryButton
        width: Style.hspan(3)
        height: Style.vspan(5)
        anchors.left: musicControl.right
        anchors.leftMargin: Style.hspan(1)
        anchors.verticalCenter: parent.verticalCenter
        size: Style.symbolSizeM

        symbol: "music"
        text: "LIBRARY"

        onClicked: root.libraryVisible = true
    }

    Component.onCompleted: MusicProvider.selectRandomTracks()

    states: State {
        name: "libaryMode"; when: root.libraryVisible

        PropertyChanges {
            target: library
            opacity: 1
            x: root.width - library.width
        }

        PropertyChanges {
            target: libraryButton
            opacity: 0
        }

        PropertyChanges {
            target: sourceOption
            opacity: 0
        }

        AnchorChanges {
            target: musicControl
            anchors.horizontalCenter: undefined
        }

        PropertyChanges {
            target: musicControl
            x: 0
        }
    }

    transitions: Transition {
        from: ""; to: "libaryMode"; reversible: true

        ParallelAnimation {
            NumberAnimation { target: library; properties: "opacity"; duration: 400 }
            NumberAnimation { target: library; properties: "x"; duration: 300 }
            NumberAnimation { target: libraryButton; properties: "opacity"; duration: 300 }
            NumberAnimation { target: sourceOption; properties: "opacity"; duration: 300 }
            NumberAnimation { target: musicControl; properties: "x"; duration: 300 }
        }
    }
}

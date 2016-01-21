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

UIScreen {
    id: root
    hspan: 24
    vspan: 24

    title: 'Music'

    property var track: MusicProvider.currentEntry
    property bool libraryVisible: false

    signal showAlbums()

    ColumnLayout {
        id: musicControl
        width: Style.hspan(12)
        height: Style.vspan(20)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 0
        Spacer {}
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Tool {
                hspan: 2
                name: 'prev'
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: Style.vspan(-1)
                onClicked: {
                    if (pathView.currentViewIndex === 0)
                        pathView.currentViewIndex = MusicProvider.count - 1
                    else
                        pathView.currentViewIndex --
                }
            }

            SwipeView {
                id: pathView
                itemWidth: Style.cellWidth * 6

                width: Style.cellWidth * 6
                height: Style.cellHeight * 12

                items: MusicProvider.nowPlaying.model

                currentViewIndex: MusicProvider.currentIndex

                onCurrentViewIndexChanged: MusicProvider.currentIndex = pathView.currentViewIndex

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
                hspan: 2
                name: 'next'
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: Style.vspan(-1)
                onClicked: {
                    if (pathView.currentViewIndex === MusicProvider.count - 1)
                        pathView.currentViewIndex = 0
                    else
                        pathView.currentViewIndex ++
                }
            }
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            Label {
                hspan: 1
                text: MusicService.currentTime
                font.pixelSize: Style.fontSizeS
            }

            Slider {
                id: slider
                //anchors.horizontalCenter: parent.horizontalCenter
                hspan: 9
                value: MusicService.position
                minimum: 0.00
                maximum: MusicService.duration
                vspan: 1
                function valueToString() {
                    return Math.floor(value/60000) + ':' + Math.floor((value/1000)%60)
                }
                onActiveValueChanged: {
                    MusicService.seek(activeValue)
                }
            }

            Label {
                hspan: 1
                text: MusicService.durationTime
                font.pixelSize: Style.fontSizeS
            }
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Tool {
                hspan: 2
                name: 'shuffle'
                onClicked: toggle()
                size: Style.symbolSizeXS
            }
            Spacer { hspan: 2 }
            Tool {
                hspan: 2
                name: MusicService.playing?'pause':'play'
                onClicked: MusicService.togglePlay()
            }
            Spacer { hspan: 2 }
            Tool {
                hspan: 2
                name: 'loop'
                onClicked: toggle()
                size: Style.symbolSizeXS
            }
        }
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Symbol {
                vspan: 2
                hspan: 1
                size: Style.symbolSizeXS
                name: 'speaker'
            }
            VolumeSlider {
                hspan: 8
                vspan: 2
                anchors.horizontalCenter: parent.horizontalCenter
                value: MusicService.volume
                onValueChanged: {
                    MusicService.volume = value
                }
            }
            Label {
                hspan: 1
                vspan: 2
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
        opacity: 0
        visible: opacity > 0
        onClose: {
            root.libraryVisible = false
        }
    }

    UIElement {
        id: sourceOption
        hspan: 4
        vspan: 12
        anchors.right: musicControl.left
        anchors.rightMargin: 60
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -60

        Column {
            spacing: 1
            Button {
                hspan: 4
                vspan: 4
                text: "BLUETOOTH"
                label.font.pixelSize: Style.fontSizeL
            }
            Button {
                hspan: 4
                vspan: 4
                text: "USB"
                enabled: false
                label.font.pixelSize: Style.fontSizeL
            }
            Button {
                hspan: 4
                vspan: 4
                text: "SPOTIFY"
                enabled: false
                label.font.pixelSize: Style.fontSizeL
            }
        }
    }

    TextTool {
        id: libraryButton
        hspan: 3
        vspan: 5
        anchors.left: musicControl.right
        anchors.leftMargin: 30
        anchors.verticalCenter: parent.verticalCenter
        size: 72

        name: "music"
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

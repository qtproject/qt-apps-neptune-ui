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
import QtQuick.Controls 2.1
import controls 1.0
import utils 1.0
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
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Tool {
                Layout.preferredWidth: Style.hspan(2)
                symbol: 'prev'
                onClicked: { MusicProvider.previous() }
            }

            TrackSwipeView {
                contentWidth: Style.hspan(6)

                Layout.preferredWidth: Style.hspan(6)
                Layout.preferredHeight: Style.vspan(12)
                model: MusicProvider.nowPlaying

                currentIndex: MusicProvider.currentIndex

                delegate: CoverItem {
                    z: PathView.z
                    scale: PathView.scale
                    source: model.item.coverArtUrl
                    title: model.item.title
                    subTitle: model.item.artist
                    onClicked: {
                        root.showAlbums()
                    }
                }

            }

            Tool {
                Layout.preferredWidth: Style.hspan(2)
                symbol: 'next'
                onClicked: { MusicProvider.next() }
            }
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0

            Label {
                Layout.preferredWidth: Style.hspan(1)
                text: MusicProvider.currentTime
            }

            Slider {
                id: slider
                Layout.preferredWidth: Style.hspan(9)
                value: MusicProvider.position
                from: 0.00
                to: MusicProvider.duration
                Layout.preferredHeight: Style.vspan(1)
                function valueToString() {
                    return Math.floor(value/60000) + ':' + Math.floor((value/1000)%60)
                }
                onValueChanged: {
                    MusicProvider.position = value
                }
            }

            Label {
                Layout.preferredWidth: Style.hspan(1)
                text: MusicProvider.durationTime
                font.pixelSize: Style.fontSizeS
            }
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Tool {
                Layout.preferredWidth: Style.hspan(2)
                symbol: 'shuffle'
                checked: MusicProvider.shuffleOn
                onClicked: MusicProvider.toggleShuffle()
                size: Style.symbolSizeXS
            }
            Spacer { Layout.preferredWidth: Style.hspan(2) }
            Tool {
                Layout.preferredWidth: Style.hspan(2)
                symbol: MusicProvider.playing?'pause':'play'
                onClicked: MusicProvider.togglePlay()
            }
            Spacer { Layout.preferredWidth: Style.hspan(2) }
            Tool {
                Layout.preferredWidth: Style.hspan(2)
                symbol: 'loop'
                checked: MusicProvider.repeatOn
                onClicked: MusicProvider.toggleRepeat()
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
                id: volumeSlider
                Layout.preferredWidth: Style.hspan(8)
                Layout.preferredHeight: Style.vspan(2)
                anchors.horizontalCenter: parent.horizontalCenter
                value: 1 //MusicService.volume
//                onValueChanged: {
//                    MusicService.volume = value
//                }
            }
            Label {
                Layout.preferredWidth: Style.hspan(1)
                horizontalAlignment: Text.AlignHCenter
                height: Style.vspan(2)
                text: Math.floor(volumeSlider.value*100)
            }
        }
        Spacer {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    IndexerStatus {
        anchors.horizontalCenter: musicControl.horizontalCenter
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
        width: Style.hspan(4)
        height: Style.vspan(12)
        anchors.right: musicControl.left
        anchors.rightMargin: Style.hspan(1)
        anchors.verticalCenter: parent.verticalCenter
        ColumnLayout {
            anchors.fill: parent
            ToolButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "BLUETOOTH"
                font.pixelSize: Style.fontSizeL
            }
            ToolButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "USB"
                enabled: false
                font.pixelSize: Style.fontSizeL
            }
            ToolButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
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

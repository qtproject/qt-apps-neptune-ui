/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
** Contact: http://www.pelagicore.com/
**
** This file is part of Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Neptune IVI UI licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Pelagicore. For licensing terms
** and conditions see http://www.pelagicore.com.
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

    signal showAlbums()

    ColumnLayout {
        width: Style.hspan(14)
        height: Style.vspan(20)
        anchors.centerIn: parent
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

                items: MusicProvider.model

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
        Slider {
            anchors.horizontalCenter: parent.horizontalCenter
            hspan: 10
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

    PlaylistContainer {
            onClicked: pathView.currentViewIndex = index
    }

    Component.onCompleted: MusicProvider.selectRandomTracks()

}

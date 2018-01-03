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
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0

import models.media 1.0
import controls 1.0
import utils 1.0

UIPanel {
    id: root
    objectName: "MusicWidget"

    width: Style.hspan(10)
    height: Style.vspan(8)

    signal showFullscreen()

    scale: area.pressed ? 0.85 : 1.0

    Rectangle {
        objectName: "MusicWidget::ContentArea"
        anchors.fill: parent
        color: Style.colorBlack
        opacity: 0.8
    }

    Behavior on scale {
        NumberAnimation {}
    }

    MouseArea {
        id: area
        objectName: "MusicWidget::MouseArea"
        anchors.fill: parent
        onClicked: {
            MediaModel.startMusicApp()
            root.showFullscreen()
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: Style.padding

        Spacer {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        RowLayout {
            spacing: 0

            Spacer {
                Layout.preferredWidth: Style.hspan(0.5)
                Layout.fillHeight: true
            }

            ColumnLayout {
                spacing: Style.paddingXS

                Label {
                    objectName: "MusicWidget::CurrentTrackAlbum"
                    height: Style.vspan(1)
                    Layout.fillWidth: true
                    text: MediaModel.currentTrack ? qsTr('%1 / %2').arg(MediaModel.currentTrack.artist).arg(MediaModel.currentTrack.album) : ""
                    font.pixelSize: Style.fontSizeS
                    font.capitalization: Font.AllUppercase
                    horizontalAlignment: Text.AlignLeft
                    elide: Text.ElideRight
                }

                Label {
                    objectName: "MusicWidget::CurrentTrackTitle"
                    Layout.fillWidth: true
                    height: Style.vspan(1)
                    text: MediaModel.currentTrack ? MediaModel.currentTrack.title : ""
                    font.pixelSize: Style.fontSizeL
                    font.capitalization: Font.AllUppercase
                    horizontalAlignment: Text.AlignLeft
                    elide: Text.ElideRight
                }

                Label {
                    objectName: "MusicWidget::CurrentTrackTime"
                    Layout.fillWidth: true
                    height: Style.vspan(1)
                    text: qsTr('%1 / %2').arg(MediaModel.currentTime).arg(MediaModel.durationTime)
                    font.pixelSize: Style.fontSizeL
                    horizontalAlignment: Text.AlignLeft
                    elide: Text.ElideRight
                }
            }

            Spacer {
                width: Style.hspan(0.5)
                Layout.fillHeight: true
            }
        }

        RowLayout {
            spacing: Style.hspan(1)
            Layout.preferredHeight: Style.vspan(3)

            Tool {
                objectName: "MusicWidget::PrevButton"
                symbol: "prev"
                Layout.preferredHeight: Style.vspan(2)
                Layout.fillWidth: true
                onClicked: MediaModel.previousTrack()
            }
            Tool {
                objectName: "MusicWidget::PlayButton"
                Layout.preferredHeight: Style.vspan(2)
                Layout.fillWidth: true
                symbol: "play"
                onClicked: MediaModel.play()
                checked: MediaModel.playing
            }
            Tool {
                objectName: "MusicWidget::PauseButton"
                Layout.preferredHeight: Style.vspan(2)
                Layout.fillWidth: true
                symbol: "pause"
                onClicked: MediaModel.pause()
                checked: !MediaModel.playing
            }
            Tool {
                objectName: "MusicWidget::NextButton"
                Layout.preferredHeight: Style.vspan(2)
                Layout.fillWidth: true
                symbol: "next"
                onClicked: MediaModel.nextTrack()
            }
        }
    }
}

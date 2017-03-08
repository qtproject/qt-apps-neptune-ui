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
import QtApplicationManager 1.0

import controls 1.0
import utils 1.0

UIPanel {
    id: root
    width: Style.hspan(10)
    height: Style.vspan(8)

    signal showFullscreen()

    scale: area.pressed?0.85:1.0

    ApplicationIPCInterface {
        id: musicControl

        property var currentTrack: {}
        property string currentTime: "00:00"
        property string durationTime: "00:00"
        property bool playing: false

        signal previousTrack()
        signal nextTrack()
        signal play()
        signal pause()

        Component.onCompleted: {
            ApplicationIPCManager.registerInterface(musicControl, "com.pelagicore.music.control", {})
        }
    }

    Behavior on scale {
        NumberAnimation {}
    }

    MouseArea {
        id: area
        anchors.fill: parent
        onClicked: root.showFullscreen()
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
                    height: Style.vspan(1)
                    Layout.fillWidth: true
                    text: musicControl.currentTrack ? qsTr('%1 / %2').arg(musicControl.currentTrack.artist).arg(musicControl.currentTrack.album) : ""
                    font.pixelSize: Style.fontSizeS
                    font.capitalization: Font.AllUppercase
                    horizontalAlignment: Text.AlignLeft
                    elide: Text.ElideRight
                }

                Label {
                    Layout.fillWidth: true
                    height: Style.vspan(1)
                    text: musicControl.currentTrack ? musicControl.currentTrack.title : ""
                    font.pixelSize: Style.fontSizeL
                    font.capitalization: Font.AllUppercase
                    horizontalAlignment: Text.AlignLeft
                    elide: Text.ElideRight
                }

                Label {
                    Layout.fillWidth: true
                    height: Style.vspan(1)
                    text: qsTr('%1 / %2').arg(musicControl.currentTime).arg(musicControl.durationTime)
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
            Layout.preferredHeight: Style.vspan(4)

            Tool {
                symbol: "prev"
                Layout.preferredHeight: Style.vspan(2)
                Layout.fillWidth: true
                onClicked: musicControl.previousTrack()
            }
            Tool {
                Layout.preferredHeight: Style.vspan(2)
                Layout.fillWidth: true
                symbol: "play"
                onClicked: musicControl.play()
                checked: musicControl.playing
            }
            Tool {
                Layout.preferredHeight: Style.vspan(2)
                Layout.fillWidth: true
                symbol: "pause"
                onClicked: musicControl.pause()
                checked: !musicControl.playing
            }
            Tool {
                Layout.preferredHeight: Style.vspan(2)
                Layout.fillWidth: true
                symbol: "next"
                onClicked: musicControl.nextTrack()
            }
        }
    }
}

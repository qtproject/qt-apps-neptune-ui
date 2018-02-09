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
    objectName: "MovieTracksScreen"
    width: Style.hspan(24)
    height: Style.vspan(24)

    title: 'Movies'

    signal playMovie()

    property var track: MovieModel.currentEntry


    ColumnLayout {
        anchors.centerIn: parent
        spacing: 0
        Control {
            Layout.preferredWidth: Style.hspan(24)
            Layout.preferredHeight: Style.vspan(10)
            RowLayout {
                anchors.fill: parent
                spacing: 0
                Spacer {
                    Layout.preferredWidth: Style.hspan(8)
                    Layout.preferredHeight: Style.vspan(6)
                }
                Item {
                    Layout.preferredWidth: Style.hspan(4)
                    Layout.preferredHeight: Style.vspan(10)
                    Rectangle {
                        anchors.fill: parent
                        color: Style.colorWhite
                        border.color: Qt.darker(color, 1.2)
                    }
                    Image {
                        id: image
                        objectName: "MovieTracks::" + root.track.title
                        anchors.fill: parent
                        source: MovieModel.coverPath(root.track.cover)
                        fillMode: Image.PreserveAspectCrop
                        sourceSize.width: image.width
                        sourceSize.height: image.height
                        asynchronous: true

                    }
                }
                ColumnLayout {
                    spacing: 0
                    Label {
                        Layout.preferredWidth: Style.hspan(10)
                        text: root.track.title
                    }
                    Label {
                        Layout.preferredWidth: Style.hspan(10)
                        text: root.track.genre
                    }
                    Label {
                        Layout.preferredWidth: Style.hspan(10)
                        text: Qt.formatDate(root.track.year, 'MMMM yyyy')
                    }
                    Label {
                        Layout.preferredWidth: Style.hspan(10)
                        Layout.fillHeight: true
                        text: root.track.desc; wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        font.pixelSize: Style.fontSizeS
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignTop
                    }
                    Button {
                        objectName: "MovieTracks::PlayNow"
                        text: 'PLAY NOW'
                        Layout.preferredWidth: Style.hspan(4)
                        Layout.alignment: Qt.AlignLeft
                        onClicked: root.playMovie()
                    }
                }
            }
        }

        Spacer {
            Layout.preferredHeight: Style.vspan(1)
        }

        ListView {
            id: view
            objectName: "MovieTracks::MovieList"
            anchors.horizontalCenter: parent.horizontalCenter
            orientation: Qt.Horizontal
            width: Style.hspan(22)
            height: Style.vspan(9)
            currentIndex: MovieModel.currentIndex
            highlightMoveDuration: 150
            delegate: MovieCoverDelegate {
                width: Style.hspan(4)
                source: MovieModel.coverPath(model.cover)
                title: model.title
                onClicked: MovieModel.currentIndex = index
                selected: ListView.isCurrentItem
            }
        }
    }

    Component.onCompleted: {
        MovieModel.selectRandom()
        view.model = MovieModel.model
        console.log(Logging.apps, "Movie Tracks completed")
    }
}

/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
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
import QtQuick.Controls 1.0
import QtMultimedia 5.0
import QtGraphicalEffects 1.0

import controls 1.0
import utils 1.0
import "."

UIScreen {
    id: root
    hspan: 24
    vspan: 24

    title: 'Movies'

    signal playMovie()

    property var track: MovieProvider.currentEntry


    ColumnLayout {
        anchors.centerIn: parent
        spacing: 0
        UIElement {
            hspan: 24
            vspan: 10
            RowLayout {
                anchors.fill: parent
                spacing: 0
                Spacer {
                    hspan: 8
                    vspan: 8
                }
                Item {
                    width: Style.hspan(4)
                    height: Style.vspan(10)
                    Rectangle {
                        anchors.fill: parent
                        color: Style.colorWhite
                        border.color: Qt.darker(color, 1.2)
                    }
                    Image {
                        id: image
                        anchors.fill: parent
                        source: MovieProvider.coverPath(root.track.cover)
                        fillMode: Image.PreserveAspectCrop
                        sourceSize.width: image.width
                        sourceSize.height: image.height
                        asynchronous: true

                    }
                }
                ColumnLayout {
                    spacing: 0
                    Label {
                        hspan: 10
                        text: root.track.title
                    }
                    Label {
                        hspan: 10
                        text: root.track.genre
                    }
                    Label {
                        hspan: 10
                        text: Qt.formatDate(root.track.year, 'MMMM yyyy')
                    }
                    Label {
                        hspan: 10
                        Layout.fillHeight: true
                        text: root.track.desc; wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        font.pixelSize: Style.fontSizeS
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignTop
                    }
                    Button {
                        text: 'PLAY NOW'
                        Layout.alignment: Qt.AlignRight
                        onClicked: root.playMovie()
                    }
                }
            }
        }

        Spacer {
            vspan: 1
        }

        ListView {
            id: view
            anchors.horizontalCenter: parent.horizontalCenter
            orientation: Qt.Horizontal
            width: Style.hspan(22)
            height: Style.vspan(8)
            currentIndex: MovieProvider.currentIndex
            highlightMoveDuration: 150
            delegate: MovieCoverDelegate {
                hspan: 4
                source: MovieProvider.coverPath(model.cover)
                title: model.title
                onClicked: MovieProvider.currentIndex = index
                selected: ListView.isCurrentItem
            }
        }
    }

    Component.onCompleted: {
        MovieProvider.selectRandom()
        view.model = MovieProvider.model
        print("Movie Tracks completed")
    }
}

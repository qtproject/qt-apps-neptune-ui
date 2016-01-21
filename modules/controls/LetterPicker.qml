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

import QtQuick 2.0
import QtGraphicalEffects 1.0
import utils 1.0

UIElement {
    id: root

    hspan: 1
    vspan: 20

    property string letter: letterModel[pathView.currentIndex]
    property color textColor: "white"
    property alias numOfVisibleLetters: pathView.pathItemCount
    property var letterModel: ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "x", "y", "z"]

    PathView {
        id: pathView

        property int padding: (width-root.itemWidth)/2

        anchors.fill: parent
        clip: true

        snapMode: PathView.SnapOneItem

        pathItemCount: 15

        model: root.letterModel

        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5

        delegate: Item {

            width: 40
            height: root.height/pathView.count
            scale: PathView.scale
            property string value: modelData
            Label {
                anchors.fill: parent
                text: modelData.toUpperCase()
                horizontalAlignment: Text.AlignHCenter
                color: root.textColor
                font.pixelSize: Style.fontSizeXL
            }
        }

        path: Path {
            startX: pathView.width/2
            startY: 0
            PathAttribute { name: "scale"; value: 0.7 }

            PathLine { x:  pathView.width/2; y: pathView.height/2 }
            PathAttribute { name: "scale"; value: 1 }

            PathLine { x: pathView.width/2; y: pathView.height }
            PathAttribute { name: "scale"; value: 0.7 }

        }
    }

    LinearGradient {
        width: root.width
        height: 0.3 * root.height

        start: Qt.point(0, 0)
        end: Qt.point(0, height)
        gradient: Gradient {
            GradientStop { position: 0.2; color: "black" }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

    LinearGradient {
        width: root.width
        height: 0.3 * root.height
        anchors.bottom: parent.bottom

        start: Qt.point(0, 0)
        end: Qt.point(0, height)
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.8; color: "black" }
        }
    }

    Tracer {}
}

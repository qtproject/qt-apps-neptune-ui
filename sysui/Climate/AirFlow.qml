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
import QtGraphicalEffects 1.0
import utils 1.0

UIElement {
    id: root

    hspan: 6
    vspan: 3

    PathView {
        id: view

        width: Style.hspan(6)
        height: Style.vspan(3)
        anchors.centerIn: parent

        clip: true

        currentIndex: 1

        model: ListModel {
            ListElement { up: 1; down: 0 }
            ListElement { up: 0; down: 1 }
            ListElement { up: 1; down: 1 }
        }

        snapMode: PathView.SnapOneItem
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5

        delegate: UIElement {
            hspan: 2
            vspan: 3

            Image {
                anchors.top: seatPerson.top
                anchors.horizontalCenter: seatPerson.horizontalCenter
                anchors.horizontalCenterOffset: -Style.padding
                source: Style.symbolXS("arrow")
                rotation: 90
                visible: model.up
            }

            Image {
                id: seatPerson
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: Style.padding
                source: Style.symbolM("seat_person")
            }

            Image {
                anchors.right: seatPerson.left
                anchors.rightMargin: -Style.padding
                anchors.verticalCenter: seatPerson.verticalCenter
                anchors.verticalCenterOffset: 12
                source: Style.symbolXS("arrow")
                rotation: 90
                visible: model.down
            }

            MouseArea {
                anchors.fill: parent
                onClicked: view.currentIndex = index
            }
        }

        path: Path {
            startX: 0
            startY: view.height/2

            PathLine {
                x: view.width
                y: view.height/2
            }
        }

        layer.effect: OpacityMask {
            anchors.fill: view

            maskSource: LinearGradient {
                width: root.width
                height: root.height
                start: Qt.point(0,0)
                end: Qt.point(root.width, 0)
                gradient: Gradient {
                    GradientStop { position: 0.05; color: "#00000000" }
                    GradientStop { position: 0.5; color: "#ff000000" }
                    GradientStop { position: 0.95; color: "#00000000" }
                }
            }
        }

        layer.enabled: true
    }
}

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
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import QtIvi.VehicleFunctions 1.0
import service.climate 1.0
import utils 1.0

Control {
    id: root

    width: Style.hspan(6)
    height: Style.vspan(3)

    PathView {
        id: view

        property int directions: ClimateService.airflowDirections.directions
        property var availableDirections: ClimateService.airflowDirections.availableDirections

        // currentIndex is updated by dragging items around *and* by explicitly setting it from
        // an onClicked() handler, so keeping all the bindings working is tricky. This works.
        onDirectionsChanged: currentIndex = availableDirections.indexOf(directions)
        Component.onCompleted: currentIndex = availableDirections.indexOf(directions)
        onCurrentIndexChanged: ClimateService.airflowDirections.directions = availableDirections[currentIndex]

        width: Style.hspan(6)
        height: Style.vspan(3)
        anchors.centerIn: parent

        clip: true

        model: availableDirections

        snapMode: PathView.SnapOneItem
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5

        delegate: Control {
            width: Style.hspan(2)
            height: Style.vspan(3)

            Image {
                anchors.top: seatPerson.top
                anchors.horizontalCenter: seatPerson.horizontalCenter
                anchors.horizontalCenterOffset: -Style.padding
                source: Style.symbolXS("arrow")
                rotation: 90
                visible: view.availableDirections[index] & ClimateControl.Dashboard
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
                visible: view.availableDirections[index] & ClimateControl.Floor
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

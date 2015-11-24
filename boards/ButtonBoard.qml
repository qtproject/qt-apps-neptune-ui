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
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

import controls 1.0
import utils 1.0

BaseBoard {
    id: root

    title: "Button Board"

    Flickable {
        id: scrollView
        anchors.fill: parent

        flickableDirection: Flickable.VerticalFlick
        contentWidth: layout.width; contentHeight: layout.height

        GridLayout {
            id: layout

            width: parent.width

            rowSpacing: Style.paddingXL
            columnSpacing: Style.padding

            columns: 2

            Label { hspan: 8; text: "No Text, No Icon, grid 2x2" }
            Button {
                hspan: 2; vspan: 2

                Marker { anchors.fill: parent; visible: parent.pressed }
                Tracer { visible: true }
            }

            Label { hspan: 8; text: "Only text, grid 2x1" }
            Button {
                hspan: 2; vspan: 1
                text: "Press me"

                Marker { anchors.fill: parent; visible: parent.pressed }
            }

            Label { hspan: 8; text: "Only icon, grid 1x2" }
            Button {
                hspan: 1; vspan: 2
                iconName: "widgets_play_track"

                Marker { anchors.fill: parent; visible: parent.pressed }
            }

            Label { hspan: 8;  text: "Text & Icon, grid 3x3" }
            Button {
                hspan: 3; vspan: 3
                iconName: "widgets_play_track"
                text: "Hello World"

                Marker { anchors.fill: parent; visible: parent.pressed }
            }
        }
    }
}

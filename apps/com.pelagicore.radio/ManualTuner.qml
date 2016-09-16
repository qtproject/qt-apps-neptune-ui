/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
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

import QtQuick 2.1
import QtQuick.Layouts 1.0

import controls 1.0
import utils 1.0
import "."

UIElement {
    id: root
    hspan: 6
    vspan: 3

    readonly property real minFrequency: RadioProvider.minimumFrequency * 0.000001
    readonly property real maxFrequency: RadioProvider.maximumFrequency * 0.000001
    readonly property real currentFrequency: (RadioProvider.currentFrequency * 0.00001) * 0.1 // To get the one decimal we use two steps

    Item {
        id: content
        anchors.fill: parent
        anchors.margins: Style.padding

        Rectangle {
            color: "black"
            anchors.fill: parent
        }

        ColumnLayout {
            width: 2
            anchors.bottom: view.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                text: (minFrequency + (view.currentIndex * 0.1)).toFixed(1)
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Style.fontSizeS
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                width: 2
                height: Style.cellHeight * 2.3
                color: '#E61123'
                opacity: 0.6
            }
        }

        ListView {
            id: view
            height: Style.cellHeight * 2
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            orientation: Qt.Horizontal

            model: (maxFrequency - minFrequency) * 10
            spacing: 10

            currentIndex: (currentFrequency - minFrequency) * 10

            snapMode: ListView.SnapToItem
            highlightMoveDuration: 250
            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: view.width * 0.5 - 1
            preferredHighlightEnd: view.width * 0.5 + 1

            delegate: Item {
                width: 2
                height: view.height
                Rectangle {

                    width: 2
                    height: parent.height
                    anchors.centerIn: parent
                    border.color: Qt.darker(color, 1.1)
                    color: Style.colorOrange
                    scale: (minFrequency + (index * (maxFrequency - minFrequency))) % 10 === 0 ? 1.2 : 1.0
                    transformOrigin: Item.Bottom
                    opacity: view.currentIndex === index ? 1.0 : 0.25
                    Behavior on opacity { NumberAnimation {} }
                }
            }
        }
    }
}

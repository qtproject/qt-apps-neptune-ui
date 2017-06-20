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

import QtQuick 2.0
import QtQuick.Controls 2.2
import utils 1.0
import controls 1.0
import QtApplicationManager 1.0

Item {
    id: graphContainer

    width: 300
    height: 150

    property color barColor: Style.colorGrey
    property bool scaleVisible: true

    Item {
        id: ramScaleContainer
        anchors.bottom: parent.bottom
        width: 5
        height: parent.height

        visible: graphContainer.scaleVisible

        Rectangle {
            id: ramScale
            width: 2
            height: parent.height
            color: Style.colorOrange
        }

        Label {
            width: 70
            anchors.bottom: ramScale.bottom
            anchors.right: ramScale.right
            text: "0"
            font.pixelSize: Style.fontSizeXXS
        }

        Label {
            width: 70
            anchors.top: ramScale.top
            anchors.topMargin: 0.5*ramScale.height - height/2
            anchors.right: ramScale.right
            text: "50"
            font.pixelSize: Style.fontSizeXXS
        }

        Label {
            width: 70
            anchors.top: ramScale.top
            anchors.topMargin: - height/2
            anchors.right: ramScale.right
            text: "100"
            font.pixelSize: Style.fontSizeXXS
        }
    }


    ListView {
        id: graph
        anchors.top: ramScaleContainer.top
        anchors.right: graphContainer.right
        anchors.bottom: ramScaleContainer.bottom
        anchors.left: ramScaleContainer.right

        model: SystemMonitor
        orientation: ListView.Horizontal
        interactive: false
        delegate: Item {
            width: graph.width / graph.model.count
            height: graph.height

            Rectangle {
                width: parent.width
                height: (model.memoryUsed/SystemMonitor.totalMemory)*parent.height
                anchors.bottom: parent.bottom
                color: graphContainer.barColor
            }
        }
    }

    Rectangle {
        width: graph.width + 5
        height: 2

        anchors.top: graph.bottom
        anchors.left: graph.left
        anchors.leftMargin: -5
        color: Style.colorOrange
    }
}

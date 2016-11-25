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
import QtApplicationManager 1.0


MonitorPanel {
    id: root

    descriptionText: "FPS: "
    middleText: "60"
    middleLine: 0.6

    ListView {
        id: graph
        anchors.fill: parent

        model: SystemMonitor
        orientation: ListView.Horizontal
        interactive: false

        delegate: Item {
            width: graph.width / graph.model.count
            height: graph.height

            Rectangle {
                width: parent.width
                height: 3
                y: parent.height - (model.averageFps/100)*parent.height
            }
        }
    }

    Rectangle {
        id: rotatingBox
        width: 20
        height: 20
        anchors.bottom: root.bottom
        //anchors.topMargin: 50
        anchors.left: root.left
        //anchors.leftMargin: 150
        color: "#273033"

        RotationAnimation {
            id: animator
            target: rotatingBox;
            from: 0;
            to: 360;
            loops: Animation.Infinite
            duration: 1000
            running: true
        }
    }
}



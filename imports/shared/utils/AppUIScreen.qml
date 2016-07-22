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
import controls 1.0
import utils 1.0

ApplicationManagerWindow {
    id: pelagicoreWindow
    width: Style.cellWidth * 24
    height: Style.cellHeight * 24

    default property alias content: content.children
    property alias cluster: clusterContainer.children

    signal clusterKeyPressed(int key)
    signal raiseApp()

    onWindowPropertyChanged: {
        //print(":::AppUIScreen::: Window property changed", name, value)
        if (name === "visibility" && value === true) {
            pelagicoreWindow.raiseApp()
        }
    }

    function back() {
        pelagicoreWindow.setWindowProperty("visibility", false)
    }

    DisplayBackground {
        anchors.fill: parent
    }

    ApplicationManagerWindow {
        id: cluster
        width: typeof parent !== 'undefined' ? parent.width : Style.cellWidth * 24
        height: typeof parent !== 'undefined' ? parent.height : Style.cellHeight * 24
        visible: false
        color: "transparent"

        Item {
            id: clusterContainer
            anchors.fill: parent
        }

        Component.onCompleted: {
            cluster.setWindowProperty("windowType", "clusterWidget")
            // Send this wayland surface after the base wayland surface
            timer.start()
        }

        onWindowPropertyChanged: {
            //print(":::AppUIScreen::: window property changed", name, value, Qt.Key_Up)
            pelagicoreWindow.clusterKeyPressed(value)
        }
    }

    Item {
        id: content
        anchors.fill: parent
    }

    Timer {
        id: timer
        interval: 1000
        onTriggered: {
            cluster.visible = Qt.binding(function() { return clusterContainer.children.length > 0})
        }
    }
}

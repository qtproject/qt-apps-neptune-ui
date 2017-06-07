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
import utils 1.0

import models.startup 1.0

Item {
    id: root

    width: Style.clusterWidth
    height: Style.clusterHeight

    property int animationDuration: 500
    property bool dialAnimationActive: false
    property int dialsLoaded: 0

    function checkDialAnimation() {
        root.dialsLoaded++
        if (root.dialsLoaded === 2) {
            root.dialAnimationActive = true
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#0c0c0c"
    }

    StageLoader {
        id: middleLoader
        width: 0.67 * Style.clusterWidth
        height: Style.clusterHeight
        anchors.centerIn: parent
        active: StagedStartupModel.loadBackgroundElements
        source: "Middle.qml"
    }

    StageLoader {
        id: leftDialLoader
        width: 0.72 * Style.clusterHeight
        height: Style.clusterHeight
        active: StagedStartupModel.loadRest
        source: "LeftDial.qml"
        scale: 0

        onLoaded: root.checkDialAnimation()

        ScaleAnimator {
            id: leftDialAnimator
            target: leftDialLoader
            from: 0
            to: 1
            duration: root.animationDuration
            running: root.dialAnimationActive
        }
    }

    StageLoader {
        id: rightDialLoader
        width: 0.8 * Style.clusterHeight
        height: Style.clusterHeight
        x: (root.width - (width + 0.1 * width))
        active: StagedStartupModel.loadRest
        source: "RightDial.qml"
        scale: 0

        onLoaded: root.checkDialAnimation()

        ScaleAnimator {
            id: rightDialAnimator
            target: rightDialLoader
            from: 0
            to: 1
            duration: root.animationDuration
            running: root.dialAnimationActive
        }
    }

    StageLoader {
        id: topLoader
        width: 0.37 * Style.clusterWidth
        height: 0.12 * Style.clusterHeight
        y: -height
        anchors.horizontalCenter: parent.horizontalCenter
        active: StagedStartupModel.loadBackgroundElements
        source: "Top.qml"

        onLoaded: yAnimator.running = true

        YAnimator {
            id: yAnimator
            target: topLoader;
            from: -height;
            to: 7;
            duration: root.animationDuration
            running: false
        }
    }

    Image {
        anchors.fill: parent
        source: Style.gfx("cluster/mask_overlay")
    }

    Keys.forwardTo: middleLoader.item

    // Only for development purpose.
    /*
    focus: Style.debugMode

    Keys.forwardTo: Style.debugMode ? [layouter] : middleLoader.item

    property var layoutTarget//: notifications

    Layouter {
        id: layouter
        target: layoutTarget
    }
    */
}

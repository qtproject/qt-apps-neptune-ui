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

import QtQuick 2.5
import utils 1.0

import models.application 1.0
QtObject {
    id: root

    // to be set from outside
    property real itemWidth

    readonly property real duration: 400
    readonly property int easingType: Easing.InOutCubic
    readonly property real angle: 80
    readonly property real translationFactor: 0.5

    readonly property Transition pushEnter: Transition {
        SequentialAnimation {
            PropertyAction { property: "transformOrigin"; value: Item.Bottom }
            PropertyAction { property: "scale"; value: 1 }
            PropertyAction { property: "clip"; value: true }
            ParallelAnimation {
                PropertyAnimation {
                    property: "x"
                    from: root.itemWidth * root.translationFactor
                    to: 0
                    duration: root.duration
                    easing.type: root.easingType
                }
                PropertyAnimation {
                    property: "rotation"
                    from: root.angle
                    to: 0
                    duration: root.duration
                    easing.type: root.easingType
                }
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: root.duration
                    easing.type: root.easingType
                }
            }
            PropertyAction { property: "clip"; value: false }
        }
    }

    readonly property Transition pushExit: Transition {
        SequentialAnimation {
            PropertyAction { property: "transformOrigin"; value: Item.Bottom }
            PropertyAction { property: "scale"; value: 1 }
            PropertyAction { property: "clip"; value: true }
            ParallelAnimation {
                PropertyAnimation {
                    property: "x"
                    from: 0
                    to: -root.itemWidth * root.translationFactor
                    duration: root.duration
                    easing.type: root.easingType
                }
                PropertyAnimation {
                    property: "rotation"
                    from: 0
                    to: -root.angle
                    duration: root.duration
                    easing.type: root.easingType
                }
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: root.duration
                    easing.type: root.easingType
                }
            }
            PropertyAction { property: "clip"; value: false }
            ScriptAction {
                script: {
                    ApplicationManagerModel.releasingApplicationSurfaceDone(stackView.currentItem)
                }
            }
        }
    }

    readonly property Transition popEnter: Transition {
        SequentialAnimation {
            PropertyAction { property: "transformOrigin"; value: Item.Bottom }
            PropertyAction { property: "scale"; value: 1 }
            PropertyAction { property: "clip"; value: true }
            ParallelAnimation {
                PropertyAnimation {
                    property: "x"
                    from: -root.itemWidth * root.translationFactor
                    to: 0
                    duration: root.duration
                    easing.type: root.easingType
                }
                PropertyAnimation {
                    property: "rotation"
                    from: -root.angle
                    to: 0
                    duration: root.duration
                    easing.type: root.easingType
                }
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: root.duration
                    easing.type: root.easingType
                }
            }
            PropertyAction { property: "clip"; value: false }
        }
    }

    readonly property Transition popExit: Transition {
        SequentialAnimation {
            PropertyAction { property: "transformOrigin"; value: Item.Bottom }
            PropertyAction { property: "scale"; value: 1 }
            PropertyAction { property: "clip"; value: true }
            ParallelAnimation {
                PropertyAnimation {
                    property: "x"
                    from: 0
                    to: root.itemWidth * root.translationFactor
                    duration: root.duration
                    easing.type: root.easingType
                }
                PropertyAnimation {
                    property: "rotation"
                    from: 0
                    to: root.angle
                    duration: root.duration
                    easing.type: root.easingType
                }
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: root.duration
                    easing.type: root.easingType
                }
            }
            PropertyAction { property: "clip"; value: false }
            ScriptAction {
                script: {
                    ApplicationManagerModel.releasingApplicationSurfaceDone(stackView.currentItem)
                }
            }
        }
    }
}

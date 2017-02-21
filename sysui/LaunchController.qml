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

import QtQuick 2.5
import QtQuick.Controls 1.0
import controls 1.0
import utils 1.0
import models 1.0

StackView {
    id: root
    width: Style.hspan(24)
    height: Style.vspan(24)
    focus: true

    delegate: StackViewDelegate {
        function transitionFinished(properties)
        {
        }

        pushTransition: StackViewTransition {
            id: pushTransition
            property int duration: 150
            property int intialPauseDuration: 200

            PropertyAction { target: enterItem; property: "scale"; value: 0.0 }
            PropertyAnimation { target: exitItem; property: "opacity"; to: 0.8; duration: pushTransition.intialPauseDuration }

            SequentialAnimation {
                PauseAnimation { duration: pushTransition.intialPauseDuration }
                ParallelAnimation {

                    PropertyAnimation {
                        target: enterItem
                        property: "scale"
                        from: 0.1
                        to: 1.0
                        duration: pushTransition.duration
                    }
                    PropertyAnimation {
                        target: enterItem
                        property: "opacity"
                        from: 0.0
                        to: 1.0
                        duration: pushTransition.duration*.5
                    }
                    PropertyAnimation {
                        target: exitItem
                        property: "scale"
                        from: 1.0
                        to: 10.0
                        duration: pushTransition.duration
                    }
                    PropertyAnimation {
                        target: exitItem
                        property: "opacity"
                        from: 0.8
                        to: 0.0
                        duration: pushTransition.duration*0.95
                    }
                }
            }
        }

        popTransition: StackViewTransition {
            id: popTransition
            property int duration: 150
            PropertyAnimation {
                target: enterItem
                property: "scale"
                from: 10.0
                to: 1.0
                duration: popTransition.duration
            }
            PropertyAnimation {
                target: enterItem
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: popTransition.duration*.2
            }

            SequentialAnimation {
                PropertyAnimation {
                    target: exitItem
                    property: "scale"
                    from: 1.0
                    to: 0.1
                    duration: popTransition.duration
                }

                ScriptAction {
                    script: {
                        exitItem.visible = false;
                        ApplicationManagerInterface.releasingApplicationSurfaceDone(exitItem)
                    }
                }
            }
        }
    }

    Item {
        id: dummyitem
        anchors.fill: parent
        //visible: false
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: StandardKey.Cancel
        onActivated: { root.popItem(root.currentItem) }
    }

    function popItem(item) {
        if (root.depth <= 1)
            return;

        if (root.busy)
            root.completeTransition()

        item.state = "closing"

        if (item == root.currentItem) {
            var stackItem = null;
            if (root.depth > 2)
                stackItem = root.get(root.depth - 2);
            root.pop(stackItem)
        } else {
            var stack = []
            for (var i = 1; i < root.depth; ++i) {
                var stackItem = root.get(i)
                if (stackItem === item) {
                    item.parent = null;
                    item.visible = false;
                    ApplicationManagerInterface.releasingApplicationSurfaceDone(item)
                } else {
                    print(stackItem)
                    stack.push({item:stackItem, immediate: true})
                }
            }
            root.pop(null);
            for (var i = 0; i < stack.length; ++i) {
                root.push(stack[i])
            }
        }
    }

    Connections {
        target: ApplicationManagerInterface

        onApplicationSurfaceReady: {
            //Make sure to push the items only once
            for (var i = 1; i < root.depth; ++i) {
                if (root.get(i) === item)
                    return
            }

            if (root.busy)
                root.completeTransition()

            if (isMinimized)
                item.parent = dummyitem
            else
                root.push(item)
        }

        onReleaseApplicationSurface: {
             root.popItem(item)
        }

        onUnhandledSurfaceReceived: {
            item.visible = false
            item.parent = dummyitem
        }
    }
}

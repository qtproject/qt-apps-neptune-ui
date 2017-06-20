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
import QtGraphicalEffects 1.0

import QtQuick.Controls 2.1
import controls 1.0
import utils 1.0
import models.application 1.0
import models.system 1.0

Item {
    id: root
    width: Style.screenWidth
    height: Style.vspan(20)

    property alias stackView: stackView

    StackView {
        id: stackView
        width: Style.hspan(24)
        height: parent.height
        focus: true

        visible: fastBlur.radius === 0

        pushEnter: Transition {
            ScaleAnimator {
                from: 0
                to: 1
                duration: 150
            }
            OpacityAnimator {
                from: 0
                to: 1
                duration: 150
            }
        }

        pushExit: Transition {
            ParallelAnimation {
                ScaleAnimator {
                    from: 1
                    to: 0
                    duration: 150
                }
                OpacityAnimator {
                    from: 1
                    to: 0
                    duration: 50
                }
            }
        }


        popEnter: Transition {
            ScaleAnimator {
                from: 0
                to: 1
                duration: 150
            }
            OpacityAnimator {
                from: 0
                to: 1
                duration: 150
            }
        }

        popExit: Transition {
            ScaleAnimator {
                from: 1
                to: 0
                duration: 150
            }
            OpacityAnimator {
                from: 1
                to: 0
                duration: 100
            }
            ScriptAction {
                script: {
                    ApplicationManagerModel.releasingApplicationSurfaceDone(stackView.currentItem)
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
            onActivated: { stackView.pop(); }
        }

        Connections {
            target: ApplicationManagerModel

            onApplicationSurfaceReady: {
                //Make sure to push the items only once
                for (var i = 1; i < stackView.depth; ++i) {
                    if (stackView.get(i) === item)
                        return
                }

                if (isMinimized) {
                    item.parent = dummyitem
                } else {
                    stackView.push(item, {"width": Style.hspan(24), "height": Style.vspan(24)})
                }
            }

            onReleaseApplicationSurface: {
                stackView.pop()
            }

            onUnhandledSurfaceReceived: {
                item.visible = false
                item.parent = dummyitem
            }
        }
    }

    FastBlur {
        id: fastBlur
        anchors.fill: stackView
        source: stackView
        radius: SystemModel.statusBarExpanded ? 100 : 0
        visible: !stackView.visible
        enabled: visible

        Behavior on radius {
            NumberAnimation { duration: 200 }
        }
    }
}

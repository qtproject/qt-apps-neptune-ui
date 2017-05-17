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

import QtQuick 2.1
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import QtApplicationManager 1.0
import QtQuick.Controls 2.1
import utils 1.0
import controls 1.0
import models.application 1.0
import models.system 1.0

Item {
    id: root

    opacity: SystemModel.windowOverviewVisible ? 1 : 0
    visible: opacity != 0

    Behavior on opacity {
        NumberAnimation { duration: 500; easing.type: Easing.OutCubic }
    }

    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 0.7

        MouseArea {
            anchors.fill: parent
            onPressed: {}
            onReleased: {}
        }
    }

    Tool {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: Style.padding
        width: Style.hspan(2)
        height: Style.vspan(2)
        symbol: 'back'
        onClicked: SystemModel.windowOverviewVisible = false
    }

    Label {
        anchors.centerIn: parent
        text: "No Apps currently running!"
        visible: gridView.count == 0
    }

    GridView {
        id: gridView
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: Style.hspan(2)
        anchors.bottomMargin: Style.hspan(2)

        width: cellWidth * 2
        cellWidth: Style.hspan(10)
        cellHeight: Style.vspan(8)

        property int padding: Style.padding

        model: ListModel{}
        clip: true

        delegate: Item {
            id: delegate
            width: gridView.cellWidth
            height: gridView.cellHeight
            property int padding: gridView.padding

            ShaderEffectSource {
                anchors.fill: parent
                anchors.margins: gridView.padding
                sourceItem: model.item
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    ApplicationManager.startApplication(ApplicationManagerModel.appIdFromWindow(model.item))
                    SystemModel.windowOverviewVisible = false
                    //Hide all other windows, otherwise the will be in the stack and switching doens't work
                    for (var i = 0; i < gridView.model.count; ++i) {
                        var window = gridView.model.get(i).item
                        if (window !== model.item)
                            WindowManager.setWindowProperty(window, "visibility", false)
                    }
                }
            }

            Tool {
                anchors.top: parent.top
                anchors.right: parent.right

                symbol: "close"
                onClicked: ApplicationManager.stopApplication(ApplicationManagerModel.appIdFromWindow(model.item))
            }
        }
    }

    Connections {
        target: ApplicationManagerModel

        onApplicationSurfaceReady: {
            for (var i = 0; i < gridView.model.count; ++i) {
                if (gridView.model.get(i).item === item)
                    return;
            }

            gridView.model.append({ "item" : item })
        }

        onApplicationSurfaceLost: {
            for (var i = 0; i < gridView.model.count; ++i) {
                if (gridView.model.get(i).item === item)
                    gridView.model.remove(i);
            }
        }
    }
}

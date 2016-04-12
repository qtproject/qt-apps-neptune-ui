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

import io.qt.ApplicationManager 1.0
import controls 1.0
import utils 1.0

ApplicationManagerWindow {
    id: pelagicoreWindow
    width: Style.cellWidth * 24
    height: Style.cellHeight * 24

    default property alias content: content.children
    property alias widget: widgetContainer.children
    property alias cluster: clusterContainer.children
    property alias popup: popupContainer.children

    property bool _widgetSet: false
    property bool _clusterSet: false
    property bool _popupSet: false

    property bool isWidget: false

    onWidgetChanged: _widgetSet = true
    onClusterChanged: _clusterSet = true
    onPopupChanged: _popupSet = true

    signal clusterKeyPressed(int key)
    signal raiseApp()

    function back() {
        pelagicoreWindow.setWindowProperty("visibility", false)
    }

    function sendWidget() {
        widget.setWindowProperty("windowType", "widgetMap")
        widget.visible = true
    }

    function sendClusterWidget() {
        cluster.setWindowProperty("windowType", "clusterWidget")
        cluster.visible = true
    }

    function sendPopupWidget() {
        popup.setWindowProperty("windowType", "popup")
        popup.visible = true
    }

    function startFullScreen() {
        pelagicoreWindow.setWindowProperty("goTo", "fullScreen")
    }

    function showPopup() {
        pelagicoreWindow.setWindowProperty("liveDrivePopupVisible", true)
    }

    function hidePopup() {
        pelagicoreWindow.setWindowProperty("liveDrivePopupVisible", false)
    }

    function sendLiveDriveEvent(event) {
        cluster.setWindowProperty("liveDriveEvent", event)
    }

    function sendRouteUpdate(update) {
        cluster.setWindowProperty("routeUpdate", update)
    }

    DisplayBackground {
        anchors.fill: parent
    }

    ApplicationManagerWindow {
        id: widget
        width: Style.cellWidth * 12
        height: Style.cellHeight * 19
        visible: false
        Item {
            id: widgetContainer
            anchors.fill: parent

            Component.onCompleted: {
                if (pelagicoreWindow._widgetSet) {
                    pelagicoreWindow.sendWidget()
                }
                else {
                    widget.setWindowProperty("windowType", "widgetMap")
                }
            }
        }
    }

    ApplicationManagerWindow {
        id: cluster
        width: typeof parent !== 'undefined' ? parent.width : Style.cellWidth * 24
        height: typeof parent !== 'undefined' ? parent.height : Style.cellHeight * 24
        visible: false
        Item {
            id: clusterContainer
            anchors.fill: parent
        }
        color: "transparent"

        Component.onCompleted: {
            if (pelagicoreWindow._clusterSet) {
                pelagicoreWindow.sendClusterWidget()
            }
            else {
                cluster.setWindowProperty("windowType", "clusterWidget")
            }

        }

        onWindowPropertyChanged: {
            //print(":::AppUIScreen::: window property changed", name, value, Qt.Key_Up)
            pelagicoreWindow.clusterKeyPressed(value)
        }
    }

    ApplicationManagerWindow {
        id: popup
        width: 285
        height: typeof parent !== 'undefined' ? parent.height : 0
        visible: false
        Item {
            id: popupContainer
            anchors.fill: parent
        }

        Component.onCompleted: {
            if (pelagicoreWindow._popupSet) {
                pelagicoreWindow.sendPopupWidget()
            }
            else {
                popup.setWindowProperty("windowType", "popup")
            }

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

    onWindowPropertyChanged: {
        //print(":::AppUIScreen::: Window property changed", name, value)
        if (name === "windowType" && value === "widget") {
            pelagicoreWindow.isWidget = true
        }
        else if (name === "windowType" && value === "fullScreen") {
            pelagicoreWindow.isWidget = false
        }
        else if (name === "visibility" && value === true) {
            root.raiseApp()
        }
    }
}

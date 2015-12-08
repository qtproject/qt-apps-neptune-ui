/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
** Contact: http://www.qt.io/ or http://www.pelagicore.com/
**
** This file is part of the Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:GPL3-PELAGICORE$
** Commercial License Usage
** Licensees holding valid commercial Pelagicore Neptune IVI UI
** licenses may use this file in accordance with the commercial license
** agreement provided with the Software or, alternatively, in accordance
** with the terms contained in a written agreement between you and
** Pelagicore. For licensing terms and conditions, contact us at:
** http://www.pelagicore.com.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU General Public License version 3 requirements will be
** met: http://www.gnu.org/licenses/gpl-3.0.html.
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

    property bool _widgetSet: false
    property bool _clusterSet: false

    property bool isWidget: false

    onWidgetChanged: _widgetSet = true
    onClusterChanged: _clusterSet = true

    signal clusterKeyPressed(int key)

    function back() {
        pelagicoreWindow.setWindowProperty("visibility", false)
    }

    function sendWidget() {
        widget.setWindowProperty("windowType", "widgetMap")
        widget.visible = true
    }

    function sendClusterWidget() {

        cluster.setWindowProperty("windowType", "clusterWidget")
        if (Style.withCluster)
            cluster.visible = true
    }

    function startFullScreen() {
        pelagicoreWindow.setWindowProperty("goTo", "fullScreen")
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
        width: parent ? parent.width : 0
        height: parent ? parent.height : 0
        visible: false
        Item {
            id: clusterContainer
            anchors.fill: parent
        }

        Component.onCompleted: {
            if (pelagicoreWindow._clusterSet) {
                pelagicoreWindow.sendClusterWidget()
            }
            else {
                cluster.setWindowProperty("windowType", "clusterWidget")
            }

        }

        onWindowPropertyChanged: {
            print(":::AppUIScreen::: window property changed", name, value, Qt.Key_Up)
            pelagicoreWindow.clusterKeyPressed(value)
        }
    }

    Item {
        id: content
        anchors.fill: parent
    }

    onWindowPropertyChanged: {
        print(":::AppUIScreen::: Window property changed", name, value)
        if (name === "windowType" && value === "widget") {
            pelagicoreWindow.isWidget = true
        }
        else if (name === "windowType" && value === "fullScreen") {
            pelagicoreWindow.isWidget = false
        }
    }
}

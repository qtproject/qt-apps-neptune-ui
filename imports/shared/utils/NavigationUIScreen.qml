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

AppUIScreen {
    id: root

    property alias widget: widgetContainer.children

    property bool _widgetSet: false

    property bool isInWidgetState: false

    onWidgetChanged: _widgetSet = true

    function sendWidget() {
        widget.setWindowProperty("windowType", "widgetMap")
        widget.visible = true
    }


    function startFullScreen() {
        root.setWindowProperty("goTo", "fullScreen")
    }

    ApplicationManagerWindow {
        id: widget
        width: Style.cellWidth * 12
        height: Style.cellHeight * 19
        visible: false
        parent: root

        Item {
            id: widgetContainer
            anchors.fill: parent

            Component.onCompleted: {
                if (root._widgetSet) {
                    root.sendWidget()
                }
                else {
                    widget.setWindowProperty("windowType", "widgetMap")
                }
            }
        }
    }

    onWindowPropertyChanged: {
        //print(":::AppUIScreen::: Window property changed", name, value)
        if (name === "windowType" && value === "widget") {
            root.isInWidgetState = true
        }
        else if (name === "windowType" && value === "fullScreen") {
            root.isInWidgetState = false
        }
    }
}

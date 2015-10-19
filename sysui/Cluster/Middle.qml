/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
** Contact: http://www.pelagicore.com/
**
** This file is part of Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Neptune IVI UI licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Pelagicore. For licensing terms
** and conditions see http://www.pelagicore.com.
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
****************************************************************************/

import QtQuick 2.1
import QtQuick.Controls 1.2
import utils 1.0
import service.statusbar 1.0
import service.apps 1.0

Item {
    id: root
    width: 700
    height: 710

    focus: true

    signal zoomIn()
    signal zoomOut()

    Behavior on width {
        NumberAnimation { duration: 200}
    }

    Behavior on height {
        NumberAnimation { duration: 200}
    }

    ListView {
        id: stack
        anchors.fill: parent
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        highlightMoveDuration: 300
        interactive: false
        currentIndex: 0
        clip: true
        model: VisualItemModel {
            WidgetContainer {
                id: navContainer
                width: stack.width
                height: stack.height
                title: "NAVIGATOR"
            }
            WidgetContainer {
                id: musicContainer
                width: stack.width
                height: stack.height
                title: "MUSIC"
            }
            WidgetContainer {
                id: otherContainer
                width: stack.width
                height: stack.height
                title: "OTHER"
            }
        }

        Component.onCompleted: StatusBarService.clusterTitle = Qt.binding(function() { return currentItem.title})
    }

    Connections {
        target: AppsService
        onClusterWidgetReady: {
            if (category === "media") {
                musicContainer.content = item
                stack.currentIndex = 1
            }
            else if (category === "navigation") {
                navContainer.content = item
                stack.currentIndex = 0
            }
            else {
                otherContainer.content = item
                stack.currentIndex = 2
            }
        }
    }

    Keys.onPressed: {
        //print("key pressed", Qt.Key_Plus, event.key)
        if (event.key === Qt.Key_Right) {
            if (stack.currentIndex < stack.count)
                stack.currentIndex++
        }
        else if (event.key === Qt.Key_Left) {
            if (stack.currentIndex > 0)
                stack.currentIndex--
        }
        else if (event.key === Qt.Key_Plus) {
            root.zoomIn()
        }
        else if (event.key === Qt.Key_Minus) {
            root.zoomOut()
        }
    }

    Keys.forwardTo: stack.currentItem
}

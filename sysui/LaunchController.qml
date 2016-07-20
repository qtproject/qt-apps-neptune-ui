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
import QtApplicationManager 1.0
import service.navigation 1.0
import service.music 1.0
import service.apps 1.0
import service.vehicle 1.0

StackView {
    id: root
    width: Style.hspan(24)
    height: Style.vspan(24)
    focus: true

    property Item windowItem: null

    property variant blackListItems: []
    property var minimizedItems: [] // Apps which will be started but not shown in full screen

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
            PropertyAnimation {
                target: exitItem
                property: "scale"
                from: 1.0
                to: 0.1
                duration: popTransition.duration
            }
        }
    }

    function windowReadyHandler(index, item) {
        print(":::LaunchController::: WindowManager:windowReadyHandler", index, item)
        var isInWidgetState = (WindowManager.windowProperty(item, "windowType") === "widgetMap")
        print(":::LaunchController:::isWidget", isInWidgetState)
        var isClusterWidget = (WindowManager.windowProperty(item, "windowType") === "clusterWidget")
        print(":::LaunchController:::isClusterWidget", isClusterWidget)
        var isPopup = (WindowManager.windowProperty(item, "windowType") === "popup")
        print(":::LaunchController:::isPopup", isPopup)

        var acceptWindow = true;
        var appID = WindowManager.get(index).applicationId;

        if (isInWidgetState) {
            if (ApplicationManager.get(appID).categories[0] === "navigation") {
                NavigationService.mapWidget = item
            }
            acceptWindow = false
        }
        else if (isClusterWidget) {
            if (!Style.withCluster) {
                acceptWindow = false
                item.parent = null
            } else {
                if (ApplicationManager.get(appID).categories[0] === "navigation") {
                    AppsService.clusterWidgetReady("navigation", item)
                }
                else if (ApplicationManager.get(appID).categories[0] === "media") {
                    AppsService.clusterWidgetReady("media", item)
                }
                acceptWindow = false
            }
        }
        else if (isPopup) {
            if (ApplicationManager.get(appID).categories[0] === "navigation")
                AppsService.sendNavigationPopup(item)
            acceptWindow = false
        }
        else {

            for (var i = 0; i < root.blackListItems.length; ++i) {
                if (appID === root.blackListItems[i])
                    acceptWindow = false;
            }

            for (i = 0; i < root.minimizedItems.length; ++i) {
                if (appID === root.minimizedItems[i]) {
                    acceptWindow = false;
                    // For now we assume that only navigation has a widget
                    WindowManager.setWindowProperty(item, "windowType", "widget")
                    root.minimizedItems.pop(appID)
                    break
                }
            }
        }

        if (acceptWindow) {
            root.windowItem = item
            WindowManager.setWindowProperty(item, "windowType", "fullScreen")
            WindowManager.setWindowProperty(item, "visibility", true)

            root.push(item)
        }
        else {
            // If nobody feels responsible for this window, we need to at least give it a
            // parent, to not block the client process which would wait for result of the
            // expose event indefinitely.

            if (!item.parent) {
                item.parent = dummyitem
                item.visible = false
                item.paintingEnabled = false
            }
        }

    }

    Item {
        id: dummyitem
        visible: false
    }

    function windowClosingHandler(index, item) {
        if (item === root.windowItem) {           // start close animation
            root.pop()
        }
    }

    function windowLostHandler(index, item) {
        WindowManager.releasewindow(item)   // immediately close anything which is not handled by this container
    }

    Connections {
        target: WindowManager
        onWindowPropertyChanged: {
            //print(":::LaunchController::: WindowManager:windowPropertyChanged", window, name, value)
            if (name === "visibility" && value === false) {
                root.pop(null)
                var index = WindowManager.indexOfWindow(root.windowItem)

                if (ApplicationManager.get(WindowManager.get(index).applicationId).categories[0] === "navigation") {
                    // Sending after pop transition is done
                    WindowManager.setWindowProperty(root.windowItem, "windowType", "widget")

                }
            }
            else if (name === "windowType" && value === "popup") {
                // Workaround for qmlscene
                if (ApplicationManager.dummy) {
                    AppsService.sendNavigationPopup(window)
                }
            }
            else if (name === "goTo" && value === "fullScreen") {
                index = WindowManager.indexOfWindow(window)
                //print(":::LaunchController::: App found. Going to full screen the app ", index, WindowManager.get(index).applicationId)
                ApplicationManager.startApplication(WindowManager.get(index).applicationId)
                WindowManager.setWindowProperty(window, "goTo", "")
            }
            else if (name === "liveDriveEvent") {
                NavigationService.liveDriveEvent = value
            }
            else if (name === "routeUpdate") {
                NavigationService.routeUpdate = value
            }
        }

        onRaiseApplicationWindow: {
            //print(":::LaunchController::: WindowManager:raiseApplicaitonWindow" + applicationId + " " + WindowManager.count)
            for (var i = 0; i < WindowManager.count; i++) {
                if (WindowManager.get(i).applicationId === applicationId) {
                    var item = WindowManager.get(i).windowItem
                    print(":::LaunchController::: App found. Running the app " + applicationId + " Item: " + item)
                    var isWidget = (WindowManager.windowProperty(item, "windowType") === "widget")
                    var isMapWidget = (WindowManager.windowProperty(item, "windowType") === "widgetMap")
                    var isClusterWidget = (WindowManager.windowProperty(item, "windowType") === "clusterWidget")
                    var isPopup = (WindowManager.windowProperty(item, "windowType") === "popup")
                    print(":::LaunchController:::isClusterWidget", isClusterWidget)
                    print(":::LaunchController:::isWidget", isWidget, isMapWidget)

                    if (!isMapWidget && !isClusterWidget && !isPopup) {
                        WindowManager.setWindowProperty(item, "visibility", true)
                        WindowManager.setWindowProperty(item, "windowType", "fullScreen")
                        root.windowItem = item
                        root.push(item)
                        break
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        WindowManager.windowReady.connect(windowReadyHandler)
        WindowManager.windowClosing.connect(windowClosingHandler)
        WindowManager.windowLost.connect(windowLostHandler)
        if (NavigationService.defaultNavApp) {
            root.minimizedItems.push(NavigationService.defaultNavApp)
            ApplicationManager.startApplication(NavigationService.defaultNavApp)
            root.minimizedItems.push(MusicService.defaultMusicApp)
            ApplicationManager.startApplication(MusicService.defaultMusicApp)
        }
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: StandardKey.Cancel
        onActivated: { root.pop(null) }
    }
}

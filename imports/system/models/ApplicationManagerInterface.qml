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

pragma Singleton
import QtQuick 2.0
import QtApplicationManager 1.0
import service.navigation 1.0
import service.music 1.0
import service.vehicle 1.0
import utils 1.0

QtObject {
    id: root

    property string activeAppId

    property variant blackListItems: []
    property var minimizedItems: [NavigationService.defaultNavApp] // Apps which will be started but not shown in full screen
    property Item windowItem
    property Item mapWidget
    property var itemsToRelease: []

    property Timer timer: Timer {
        interval: 1000
        onTriggered: {
            for (var i in root.minimizedItems) {
                ApplicationManager.startApplication(root.minimizedItems[i])
            }
        }
    }

    signal applicationSurfaceReady(Item item, bool isMinimized)
    signal releaseApplicationSurface()

    // Cluster signals
    signal clusterWidgetReady(string category, Item item)

    Component.onCompleted: {
        WindowManager.windowReady.connect(windowReadyHandler)
        WindowManager.windowClosing.connect(windowClosingHandler)
        ApplicationManager.applicationWasActivated.connect(applicationActivated)
        WindowManager.windowLost.connect(windowLostHandler)
        WindowManager.windowPropertyChanged.connect(windowPropertyChanged)
        timer.start()
    }

    function windowReadyHandler(index, item) {
        print(":::LaunchController::: WindowManager:windowReadyHandler", index, item)
        var isInWidgetState = (WindowManager.windowProperty(item, "windowType") === "widgetMap")
        print(":::LaunchController:::isWidget", isInWidgetState)
        var isClusterWidget = (WindowManager.windowProperty(item, "windowType") === "clusterWidget")
        print(":::LaunchController:::isClusterWidget", isClusterWidget)

        var acceptWindow = true;
        var appID = WindowManager.get(index).applicationId;
        var isMinimized = false;

        if (isInWidgetState) {
            if (ApplicationManager.get(appID).categories[0] === "navigation") {
                root.mapWidget = item
            }
            return
        }
        else if (isClusterWidget) {
            if (!Style.withCluster) {
                acceptWindow = false
                item.parent = null
            } else {
                if (ApplicationManager.get(appID).categories[0] === "navigation") {
                    root.clusterWidgetReady("navigation", item)
                }
                else if (ApplicationManager.get(appID).categories[0] === "media") {
                    root.clusterWidgetReady("media", item)
                }
                return
            }
        } else {

            for (var i = 0; i < root.blackListItems.length; ++i) {
                if (appID === root.blackListItems[i])
                    acceptWindow = false;
            }

            for (i = 0; i < root.minimizedItems.length; ++i) {
                if (appID === root.minimizedItems[i]) {
                    root.minimizedItems.pop(appID)
                    isMinimized = true;
                    break
                }
            }
        }

        if (acceptWindow) {
            root.windowItem = item
            WindowManager.setWindowProperty(item, "visibility", !isMinimized)

            root.applicationSurfaceReady(item, isMinimized)
        } else {
            // If nobody feels responsible for this window, we need to at least give it a
            // parent, to not block the client process which would wait for result of the
            // expose event indefinitely.

            if (!item.parent) {
                item.parent = root.windowItem
                item.visible = false
                item.paintingEnabled = false
            }
        }

    }

    function windowPropertyChanged(window, name, value) {
        //print(":::LaunchController::: WindowManager:windowPropertyChanged", window, name, value)
        if (name === "visibility" && value === false) {
            root.releaseApplicationSurface()
        }
    }

    function windowClosingHandler(index, item) {
        if (item === root.windowItem) {           // start close animation
            root.releaseApplicationSurface()
        }
    }

    function windowLostHandler(index, item) {
        var isClusterWidget = (WindowManager.windowProperty(item, "windowType") === "clusterWidget")
        //We don't have a closing transition for widgets so it's save to release them immediately
        if (isClusterWidget) {
            WindowManager.releaseWindow(item)
        } else {
            //If the item is visible the closing application hasn't been played yet and we need to wait unti it is finished
            if (item.visible) {
                itemsToRelease.push(item)
                root.releaseApplicationSurface()
            } else {
                WindowManager.releaseWindow(item)
            }
        }
    }

    //Called once the closing transition has finished and it would be save to release the window
    function releasingApplicationSurfaceDone(item) {
        for (var i = 0; i < itemsToRelease.length; ++i) {
            if (item === itemsToRelease[i]) {
                itemsToRelease.splice(i, 1)
                WindowManager.releaseWindow(item)   // immediately close anything which is not handled by this container
            }
        }
    }

    function applicationActivated(appId, appAliasId) {
        print(":::LaunchController::: WindowManager:raiseApplicaitonWindow" + appId + " " + WindowManager.count)
        root.activeAppId = appId
        for (var i = 0; i < WindowManager.count; i++) {
            if (!WindowManager.get(i).isClosing && WindowManager.get(i).applicationId === appId) {
                var item = WindowManager.get(i).windowItem
                print(":::LaunchController::: App found. Running the app " + appId + " Item: " + item)
                var isWidget = (WindowManager.windowProperty(item, "windowType") === "widget")
                var isMapWidget = (WindowManager.windowProperty(item, "windowType") === "widgetMap")
                var isClusterWidget = (WindowManager.windowProperty(item, "windowType") === "clusterWidget")
                print(":::LaunchController:::isClusterWidget", isClusterWidget)
                print(":::LaunchController:::isWidget", isWidget, isMapWidget)

                if (!isMapWidget && !isClusterWidget) {
                    WindowManager.setWindowProperty(item, "visibility", true)
                    root.windowItem = item
                    root.applicationSurfaceReady(item, false)
                    break
                }
            }
        }
    }
}

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

pragma Singleton
import QtQuick 2.0
import QtApplicationManager 1.0
import models.navigation 1.0
import utils 1.0

QtObject {
    id: root

    property string activeAppId

    property variant blackListItems: []
    property var preloadApplications: [] // Apps which will be started but not shown in full screen
    property var windowTypes: ({})
    property Item mapWidget
    property var itemsToRelease: []

    signal applicationSurfaceReady(Item item, bool isMinimized)
    signal releaseApplicationSurface(Item item)
    signal applicationSurfaceLost(Item item)
    signal unhandledSurfaceReceived(Item item)

    // Cluster signals
    signal clusterWidgetReady(string category, Item item)

    Component.onCompleted: {
        // Maintain a set of applications which are autostarted(preloaded)
        // This is needed to know that these applications should be minimized
        for (var i = 0; i < ApplicationManager.count; ++i) {
            var app = ApplicationManager.get(i);
            if (app.application.preload) {
                preloadApplications.push(app.applicationId)
            }
        }

        WindowManager.windowReady.connect(windowReadyHandler)
        WindowManager.windowClosing.connect(windowClosingHandler)
        ApplicationManager.applicationWasActivated.connect(applicationActivated)
        WindowManager.windowLost.connect(windowLostHandler)
        WindowManager.windowPropertyChanged.connect(windowPropertyChanged)
    }

    function appIdFromWindow(item) {
        return WindowManager.get(WindowManager.indexOfWindow(item)).applicationId
    }

    function windowReadyHandler(index, item) {
        var isMapWidget = (WindowManager.windowProperty(item, "windowType") === "widgetMap")
        var isClusterWidget = (WindowManager.windowProperty(item, "windowType") === "clusterWidget")

        print("AMI.windowReadyHandler: index:" + index + ", item:" + item + ", map:"
              + (isMapWidget ? "yes" : "no") + ", cluster:" + (isClusterWidget ? "yes" : "no"))

        var acceptWindow = true;
        var appID = WindowManager.get(index).applicationId;
        var isMinimized = false;

        if (isMapWidget) {
            windowTypes[item] = "widget"
            if (ApplicationManager.get(appID).categories[0] === "navigation") {
                root.mapWidget = item
            }
            return
        } else if (isClusterWidget) {
            if (!Style.withCluster) {
                acceptWindow = false
            } else {
                windowTypes[item] = "cluster"
                if (ApplicationManager.get(appID).categories[0] === "navigation")
                    root.clusterWidgetReady("navigation", item)
                else if (ApplicationManager.get(appID).categories[0] === "media")
                    root.clusterWidgetReady("media", item)
                return
            }
        } else {

            for (var i = 0; i < root.blackListItems.length; ++i) {
                if (appID === root.blackListItems[i])
                    acceptWindow = false;
            }

            for (i = 0; i < root.preloadApplications.length; ++i) {
                if (appID === root.preloadApplications[i]) {
                    root.preloadApplications.pop(appID)
                    windowTypes[item] = "minimized"
                    isMinimized = true;
                    break
                }
            }

            if (!isMinimized) {
                windowTypes[item] = "ivi"
            }
        }

        if (acceptWindow) {
            WindowManager.setWindowProperty(item, "visibility", !isMinimized)

            root.applicationSurfaceReady(item, isMinimized)
        } else {
            root.unhandledSurfaceReceived(item)
            console.error("AMI.windowReadyHandler: window was not accepted: ", item)
        }
    }

    function windowPropertyChanged(window, name, value) {
        if (name === "visibility" && value === false ) {
            root.releaseApplicationSurface(window)
        }
    }

    function windowClosingHandler(index, item) {
        var type = windowTypes[item]
        if (type === "ivi") {           // start close animation
            root.releaseApplicationSurface(item)
        }
    }

    function windowLostHandler(index, item) {
        var type = windowTypes[item]

        //For special windows (cluster, widgets) we don't have a closing anmiation, close them directly
        if (type === "ivi") {
            root.applicationSurfaceLost(item)

            //If the item is in the closing state the closing animation hasn't been played yet and we need to wait until it is finished
            if (item.state === "closing" ) {
                itemsToRelease.push(item)
                root.releaseApplicationSurface(item)
            } else {
                WindowManager.releaseWindow(item)
            }
        } else {
            delete windowTypes[item]
            WindowManager.releaseWindow(item)
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
        print("AMI.applicationActivated: appId:" + appId + ", appAliasId:" + appAliasId)
        root.activeAppId = appId
        for (var i = 0; i < WindowManager.count; i++) {
            if (!WindowManager.get(i).isClosing && WindowManager.get(i).applicationId === appId) {
                var item = WindowManager.get(i).windowItem
                var isMapWidget = (WindowManager.windowProperty(item, "windowType") === "widgetMap")
                var isClusterWidget = (WindowManager.windowProperty(item, "windowType") === "clusterWidget")

                print("AMI.applicationActivated: appId:" + appId + " found item:" + item + ", map:"
                      + (isMapWidget ? "yes" : "no") + ", cluster:" + (isClusterWidget ? "yes" : "no"))

                if (!isMapWidget && !isClusterWidget) {
                    if (windowTypes[item] === "minimized")
                        windowTypes[item] = "ivi"
                    WindowManager.setWindowProperty(item, "visibility", true)
                    root.applicationSurfaceReady(item, false)
                    break
                }
            }
        }
    }
}

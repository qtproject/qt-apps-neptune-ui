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

import QtQuick 2.0
import QtQuick.Controls 1.0
import controls 1.0
import utils 1.0
import com.pelagicore.ApplicationManager 0.1
import service.navigation 1.0
import service.apps 1.0

StackView {
    id: root
    width: Style.hspan(24)
    height: Style.vspan(24)

    property int windowItemIndex: -1
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

    function surfaceItemReadyHandler(index, item) {
        print(":::LaunchController::: WindowManager:surfaceItemReadyHandler", index, item)
        var isWidget = (WindowManager.surfaceWindowProperty(item, "windowType") === "widgetMap")
        print(":::LaunchController:::isWidget", isWidget)
        var isClusterWidget = (WindowManager.surfaceWindowProperty(item, "windowType") === "clusterWidget")
        print(":::LaunchController:::isClusterWidget", isClusterWidget)

        var acceptSurface = true;
        var appID = WindowManager.get(index).applicationId;

        if (isWidget) {
            if (ApplicationManager.get(appID).categories[0] === "navigation") {
                NavigationService.mapWidget = item
            }
            acceptSurface = false
        }
        else if (isClusterWidget) {
            if (ApplicationManager.get(appID).categories[0] === "navigation") {
                AppsService.clusterWidgetReady("navigation", item)
            }
            else if (ApplicationManager.get(appID).categories[0] === "media") {
                AppsService.clusterWidgetReady("media", item)
            }
            acceptSurface = false
        }
        else {

            for (var i = 0; i < root.blackListItems.length; ++i) {
                if (appID === root.blackListItems[i])
                    acceptSurface = false;
            }

            for (var i = 0; i < root.minimizedItems.length; ++i) {
                if (appID === root.minimizedItems[i]) {
                    acceptSurface = false;
                    // For now we assume that only navigation has a widget
                    WindowManager.setSurfaceWindowProperty(item, "windowType", "widget")
                    root.minimizedItems.pop(NavigationService.defaultNavApp)
                    break
                }
            }
        }

        if (acceptSurface) {
            root.windowItem = item
            root.windowItemIndex = index
            WindowManager.setSurfaceWindowProperty(item, "windowType", "fullScreen")
            WindowManager.setSurfaceWindowProperty(item, "visibility", true)

            root.push(item)
        }
        else {
            print("Not showing well known application : " + appID);
        }

    }

    function surfaceItemClosingHandler(index, item) {
        if (item === windowContainer.windowItem) {           // start close animation
            root.pop(item)
        } else {
            WindowManager.releaseSurfaceItem(index, item)   // immediately close anything which is not handled by this container
        }
    }

    function surfaceItemLostHandler(index, item) {
        // TODO
    }

    function getSurfaceIndex(item) {
        var appIndex = -1
        for (var i = 0; i < WindowManager.count; i++) {
            if (WindowManager.get(i).surfaceItem === item) {
                appIndex = i
                break
            }
        }
        return appIndex
    }

    Connections {
        target: WindowManager
        onSurfaceWindowPropertyChanged: {
            print(":::LaunchController::: WindowManager:surfaceWindowPropertyChanged", surfaceItem, name, value)
            if (name === "visibility" && value === false) {
                root.pop()
                var id = root.getSurfaceIndex(root.windowItem)
                if (ApplicationManager.dummy) {
                    if (WindowManager.get(id).categories === "navigation")
                        WindowManager.setSurfaceWindowProperty(root.windowItem, "windowType", "widget")
                }
                else {
                    if (ApplicationManager.get(WindowManager.get(id).applicationId).categories[0] === "navigation") {
                        // Sending after pop transition is done
                        WindowManager.setSurfaceWindowProperty(root.windowItem, "windowType", "widget")
                    }
                }
            }
            else if (name === "windowType" && value === "widgetMap") {
                // Workaround for qmlscene
                if (ApplicationManager.dummy) {
                    NavigationService.mapWidget = surfaceItem
                }
            }
            else if (name === "windowType" && value === "clusterWidget") {
                // Workaround for qmlscene
                if (ApplicationManager.dummy) {
                    AppsService.clusterWidgetReady("other", surfaceItem)
                }
            }
            else if (name === "goTo" && value === "fullScreen") {
                var appIndex = root.getSurfaceIndex(surfaceItem)
                print("indexxxx", appIndex)
                print(":::LaunchController::: App found. Going to full screen the app ", appIndex, WindowManager.get(appIndex).applicationId)
                ApplicationManager.startApplication(WindowManager.get(appIndex).applicationId)
            }
        }

        onRaiseApplicationWindow: {
            print(":::LaunchController::: WindowManager:raiseApplicaitonWindow" + id + " " + WindowManager.count)
            for (var i = 0; i < WindowManager.count; i++) {
                if (WindowManager.get(i).applicationId === id) {
                    var item = WindowManager.get(i).surfaceItem
                    print(":::LaunchController::: App found. Running the app " + id + " Item: " + item)
                    var isWidget = (WindowManager.surfaceWindowProperty(item, "windowType") === "widget")
                    var isMapWidget = (WindowManager.surfaceWindowProperty(item, "windowType") === "widgetMap")
                    var isClusterWidget = (WindowManager.surfaceWindowProperty(item, "windowType") === "clusterWidget")
                    print(":::LaunchController:::isClusterWidget", isClusterWidget)
                    print(":::LaunchController:::isWidget", isWidget, isMapWidget)
                    if (!isMapWidget && !isClusterWidget) {
                        WindowManager.setSurfaceWindowProperty(item, "visibility", true)
                        WindowManager.setSurfaceWindowProperty(item, "windowType", "fullScreen")
                        root.windowItem = item
                        root.push(item)
                        break
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        WindowManager.surfaceItemReady.connect(surfaceItemReadyHandler)
        WindowManager.surfaceItemClosing.connect(surfaceItemClosingHandler)
        WindowManager.surfaceItemLost.connect(surfaceItemLostHandler)
        if (NavigationService.defaultNavApp) {
            root.minimizedItems.push(NavigationService.defaultNavApp)
            ApplicationManager.startApplication(NavigationService.defaultNavApp)
        }
    }

}

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
import QtQuick.Window 2.2
import QtApplicationManager 1.0
import com.pelagicore.ScreenManager 1.0
import QtQuick.Controls 2.0
import "sysui/Cluster"
import "sysui"
import controls 1.0
import utils 1.0
import QtQuick.Window 2.2
import com.pelagicore.styles.neptune 1.0

BackgroundPane {
    id: root

    property bool showClusterIfPossible: ApplicationManager.systemProperties.showCluster
    property var cluster


    width: NeptuneStyle.windowWidth
    height: NeptuneStyle.windowHeight

    //Forwards the keys to the cluster to handle it without being the active window
    Keys.forwardTo: cluster ? cluster.clusterItem : null

    Display {
        id: display
        anchors.fill: parent
    }

    Component {
        id: clusterComponent
        Window {
            id: cluster
            title: "Neptune Cluster Display"
            height: Style.clusterHeight
            width: Style.clusterWidth
            visible: false

            property Item clusterItem: clusterItem

            color: "black"

            Cluster {
                id: clusterItem
            }

            Component.onCompleted: {
                WindowManager.registerCompositorView(cluster)
                ScreenManager.setScreen(cluster, 1)
                cluster.show()
            }
        }
    }

    Component.onCompleted: {
        var canDisplayCluster = Screen.desktopAvailableWidth > Screen.width || WindowManager.runningOnDesktop || ScreenManager.screenCount() > 1

        if (!showClusterIfPossible) {
            console.log("Showing Instrument Cluster was disabled");
            return
        }

        if (canDisplayCluster) {
            console.log("Showing Instrument Cluster");
            cluster = clusterComponent.createObject(root);
        } else {
            console.log("Showing the Instrument Cluster is not possible on this platform");
        }
    }
}

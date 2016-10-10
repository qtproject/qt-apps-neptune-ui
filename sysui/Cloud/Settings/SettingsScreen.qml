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
import utils 1.0

import controls 1.0
import utils 1.0
import service.settings 1.0
import models 1.0
import "SystemMonitor/"
import utils 1.0

UIElement {
    id: root

    ListViewManager {
        id: settingsListView

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top; anchors.bottom: parent.bottom
        hspan: 14

        model: SettingsService.entries

        delegate: SettingsListItem {
            hspan: settingsListView.hspan
            vspan: 2

            iconName: model.icon
            titleText: model.title
            checked: model.checked
            hasChildren: model.hasChildren
            checkedEnabled: (titleText === "SYSTEM MONITOR") ? false : true
            onClicked: {
                if ( titleText === "METRIC SYSTEM") {
                    if (checked)
                        SettingsService.unitSystem = "imp_us"
                    else
                        SettingsService.unitSystem = "metric"
                }
                else if (titleText === "SYSTEM MONITOR") {
                    systemMonitorLoader.active = true
                    ApplicationManagerInterface.applicationSurfaceReady(systemMonitorLoader.item, false)
                }
            }
        }
    }

    Image {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        source: Style.icon('cloud_bottom_shadow')
        asynchronous: true
        visible: false
    }

    Loader {
        id: systemMonitorLoader
        active: false
        sourceComponent: Component {
            MainScreen {
                id: systemMonitor
                visible: false
            }
        }
    }
}

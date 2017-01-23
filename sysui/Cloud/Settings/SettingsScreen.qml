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

import QtQml.Models 2.2
import QtQuick 2.6
import QtQuick.Controls 2.0

import utils 1.0

import controls 1.0
import utils 1.0
import service.settings 1.0
import models 1.0
import utils 1.0


Control {
    id: root
    width: Style.hspan(24)
    height: Style.vspan(21)

    ListViewManager {
        id: view

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top;
        anchors.bottom: parent.bottom
        width: Style.hspan(14)

        model: ObjectModel {
            SettingsItemDelegate {
                text: "USER PROFILE"; icon: "profile"; checked: true; hasChildren: true
            }
            SettingsItemDelegate {
                text: "SERVICE & SUPPORT"; icon: "service"; checkable: false
            }
            SettingsItemDelegate {
                text: "TRAFFIC INFORMATION"; icon: "warning"; checked: true; hasChildren: true
            }
            SettingsItemDelegate {
                text: "METRIC SYSTEM"; icon: "fees"; checked: true
                onClicked: {
                    SettingsService.unitSystem = checked? "imp_us" : "metric";
                }
            }
            SettingsItemDelegate {
                text: "APP UPDATES"; icon: "updates"; checked: true; hasChildren: true
            }
            SettingsItemDelegate {
                text: "SYSTEM MONITOR"; icon: "insurance"; checkable: false; hasChildren: true
                onClicked: {
                    systemMonitorLoader.active = true
                    ApplicationManagerInterface.applicationSurfaceReady(systemMonitorLoader.item, false)
                }
            }
        }
    }


    // TODO: Fix this relative loading. E.g. do not use '..' in paths here
    Loader {
        id: systemMonitorLoader
        active: false
        source: Qt.resolvedUrl("../../dev/SystemMonitor/MainScreen.qml")
    }

    Tracer {}

}

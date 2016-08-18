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
import QtQuick 2.1

QtObject {
    id: root

    property bool clusterVisible: true
    property string unitSystem: "metric"  // "metric" or "imp_us"
    property bool metric: unitSystem === "metric"

    property ListModel entries: ListModel {
        ListElement { title: "USER PROFILE"; icon: "profile"; checked: true; hasChildren: true }
        ListElement { title: "SERVICE & SUPPORT"; icon: "service"; checked: false; hasChildren: false }
        ListElement { title: "TRAFFIC INFORMATION"; icon: "warning"; checked: true; hasChildren: true }
        ListElement { title: "TOLL & CONGESTION FEES"; icon: "toll"; checked: false; hasChildren: true }
        ListElement { title: "METRIC SYSTEM"; icon: "fees"; checked: true; hasChildren: false }
        ListElement { title: "APP UPDATES"; icon: "updates"; checked: true; hasChildren: true }
        ListElement { title: "SYSTEM MONITOR"; icon: "insurance"; checked: false; hasChildren: true }
    }

    property var carSettings: [
        { section: "Units", option: clockOption },
        { section: "Units", option: speedOption },
        { section: "Communication", option: bluetoothOption }
    ]

    property var clockOption: QtObject {
        property string format: active === 0 ? "hh:mm" : "h:mm AP"
        property var options: ['24H', 'AM/PM']
        property string name: "Time"
        property int active: 0

        function setActive(index) { active = index }
    }

    property var speedOption: QtObject {
        property var options: ['KMH', 'MPH']
        property string name: "Speed"
        property int active: 0

        function setActive(index) { active = index }
    }

    property var bluetoothOption: QtObject {

        property string name: "Bluetooth"
        property bool active: false

        function setActive(value) { active = value }
    }

    property ListModel functions: ListModel {
        ListElement {
            description: "Hill descent control"
            icon: "hill_descent_control"
            active: true
        }
        ListElement {
            description: "Intelligent speed adaptation"
            icon: "intelligent_speed_adaptation"
            active: false
        }
        ListElement {
            description: "Automatic beam switching"
            icon: "automatic_beam_switching"
            active: true
        }
        ListElement {
            description: "Collision avoidance"
            icon: "collision_avoidance"
            active: false
        }
        ListElement {
            description: "Lane keeping assist"
            icon: "lane_keeping_assist"
            active: false
        }
        ListElement {
            description: "Traffic jam assist"
            icon: "traffic_jam_assist"
            active: false
        }
        ListElement {
            description: "Driver drowsyness alert"
            icon: "driver_drownsyness_alert"
            active: true
        }
        ListElement {
            description: "Park assist"
            icon: "park_assist"
            active: false
        }
    }
}

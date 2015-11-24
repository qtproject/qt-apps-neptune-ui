/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
** Contact: http://www.qt.io/ or http://www.pelagicore.com/
**
** This file is part of the Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:GPL3-PELAGICORE$
** Commercial License Usage
** Licensees holding valid commercial Pelagicore Neptune IVI UI
** licenses may use this file in accordance with the commercial license
** agreement provided with the Software or, alternatively, in accordance
** with the terms contained in a written agreement between you and
** Pelagicore. For licensing terms and conditions, contact us at:
** http://www.pelagicore.com.
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
** SPDX-License-Identifier: GPL-3.0
**
****************************************************************************/

pragma Singleton
import QtQuick 2.1

Item {
    id: root

    property ListModel entries: ListModel {
        ListElement { title: "USER PROFILE"; icon: "profile"; checked: true; hasChildren: true }
        ListElement { title: "SERVICE & SUPPORT"; icon: "service"; checked: false; hasChildren: false }
        ListElement { title: "TRAFFIC INFORMATION"; icon: "warning"; checked: true; hasChildren: true }
        ListElement { title: "TOLL & CONGESTION FEES"; icon: "toll"; checked: false; hasChildren: true }
        ListElement { title: "CHARGING FEES"; icon: "fees"; checked: false; hasChildren: false }
        ListElement { title: "APP UPDATES"; icon: "updates"; checked: true; hasChildren: true }
        ListElement { title: "INSURANCE FEATURES"; icon: "insurance"; checked: true; hasChildren: true }
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

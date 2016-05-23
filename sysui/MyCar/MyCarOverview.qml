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
import QtQuick.Layouts 1.0
import controls 1.0
import utils 1.0

UIElement {
    id: root

    RowLayout {
        id: content

        spacing: 0
        anchors.top: parent.top
        anchors.topMargin: Style.vspan(1)
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height

        ListViewManager {
            id: view
            width: Style.hspan(5)
            Layout.fillHeight: true

            model: ListModel {
                ListElement { name: "Tire Pressure"; symbol: "tire_pressure"; slide: "TireFault" }
                ListElement { name: "Engine"; symbol: "engine"; slide: "" }
                ListElement { name: "Fuel"; symbol: "fuel"; slide: "" }
                ListElement { name: "Trunk Open"; symbol: "trunk_open"; slide: "HatchFault" }
                ListElement { name: "Door Open"; symbol: "door_open"; slide: "DoorFault" }
            }

            delegate: CategoryListItem {
                width: ListView.view.width
                height: Style.vspan(3)

                text: model.name.toUpperCase()
                symbol: model.symbol

                onClicked: {
                    view.currentIndex = index
                }
            }
        }

        UIElement {
            id: composerParent
            hspan: 11
            Layout.fillHeight: true

            Loader {
                width: parent.width
                height: Style.vspan(15)
                sourceComponent: carDemo
            }
        }
    }

    Component {
        id: carDemo
        Image {
            source: "white.png"
        }
    }
}

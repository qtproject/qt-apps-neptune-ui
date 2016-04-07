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

import controls 1.0
import utils 1.0

BaseBoard {
    width: 800

    title: "List Items"

    ListViewManager {
        id: categoryListView
        width: 300
        height: parent.height/3
        model: 5
        header: Label {
            width: parent.width
            text: "Category List Item"
        }

        delegate: CategoryListItem {
            width: 300
            height: Style.vspan(3)

            text: "CATEGORY ITEM #" + (index + 1)
            symbol: "tire_pressure"
            onClicked: categoryListView.currentIndex = index
        }

    }

    ListViewManager {
        id: settingsListView
        anchors.top: categoryListView.bottom
        width: parent.width
        height: parent.height/3
        model: 6
        header: Label {
            width: parent.width
            text: "Settings List Item"
        }

        delegate: SettingsListItem {
            hspan: 6
            vspan: 2
            checkedEnabled: index%2 === 0 ? true : false
            titleText: index%2 === 0 ? "Settings item with check option": "Settings item without check option"
            iconName: "tire_pressure"
        }

    }

    ListViewManager {
        id: listView
        anchors.top: settingsListView.bottom
        hspan: 11
        height: parent.height/3
        model: ListModel {
            ListElement {
                text: "Normal List Item"
            }
            ListElement {
                text: "Normal List Item"
            }
            ListElement {
                text: "Normal List Item"
            }
            ListElement {
                text: "Normal List Item"
            }
            ListElement {
                text: "Normal List Item"
            }
        }

        scrollVisible: true
        header: Label {
            width: parent.width
            text: "Settings List Item"
        }

        delegate: ListItem {
            hspan: 11
            vspan: 2

            titleText: "Normal List Item"
            iconName: Style.symbol("tire_pressure", Style.defaultSymbolSize, false)
        }

    }

}

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

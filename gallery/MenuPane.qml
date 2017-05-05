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

import QtQuick 2.8
import QtQuick.Controls 2.1

Item {
    id: root
    width: 1920
    height: 1080

    ListModel {
        id: listEntries
        ListElement { title: 'Welcome!' ; source: 'gallery/pages/WelcomePage.qml' }
        ListElement { title: 'Buttons' ; source: 'gallery/pages/ButtonPage.qml' }
        ListElement { title: 'Tool Buttons' ; source: 'gallery/pages/ToolButtonPage.qml' }
        ListElement { title: 'TextField' ; source: 'gallery/pages/TextFieldPage.qml' }
        ListElement { title: 'Label' ; source: 'gallery/pages/LabelPage.qml' }
        ListElement { title: 'Slider' ; source: 'gallery/pages/SliderPage.qml' }
        ListElement { title: 'Switch' ; source: 'gallery/pages/SwitchPage.qml' }
        ListElement { title: 'Colors' ; source: 'gallery/pages/ColorPage.qml' }
        ListElement { title: 'Item Delegate' ; source: 'gallery/pages/ItemDelegatePage.qml' }
        ListElement { title: 'Switch Delegate' ; source: 'gallery/pages/SwitchDelegatePage.qml' }
        ListElement { title: 'Frame' ; source: 'gallery/pages/FramePage.qml' }
        ListElement { title: 'Pane' ; source: 'gallery/pages/PanePage.qml' }
    }

    Frame {
        id: navigationPane
        width: root.width / 4
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        ListView {
            id: view
            anchors.topMargin: 20
            anchors.fill: parent
            model: listEntries
            clip: true
            delegate: ItemDelegate {
                width: ListView.view.width
                text: model.title
                highlighted: ListView.isCurrentItem
                font.pixelSize: 20
                onClicked: {
                    view.currentIndex = index;
                    //make sure there is nothing else on the stack
                    stackView.clear();
                    stackView.replace(model.source);
                }
            }
        }
    }

    StackView {
        id: stackView
        width: root.width - navigationPane.width
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        initialItem: listEntries.get(0).source
    }
}

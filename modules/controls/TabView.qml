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
import QtQuick.Controls 1.0 as QControls

import controls 1.0
import utils 1.0

UIElement {
    id: root

    property int currentIndex: 0
    property alias tabs: repeater.model

    Row {
        id: tabRow

        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 0

        Repeater {
            id: repeater


            Tab {
                text: modelData.title
                selected: root.currentIndex === index

                onClicked: {
                    if (root.currentIndex === index)
                        return

                    root.currentIndex = index

                    tabContent.push({item: modelData.url, properties: modelData.properties, replace: true})
                }
            }
        }
    }

    QControls.StackView {
        id: tabContent

        anchors.top: tabRow.bottom; anchors.bottom: parent.bottom
        anchors.left: parent.left; anchors.right: parent.right

        clip: true

        initialItem: {"item" : root.tabs[root.currentIndex].url, "properties" : root.tabs[root.currentIndex].properties}

        delegate: QControls.StackViewDelegate {

            function transitionFinished(properties)
            {
                properties.exitItem.opacity = 1
            }

            pushTransition: QControls.StackViewTransition {
                PropertyAnimation {
                    target: enterItem
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 250
                }

                PropertyAnimation {
                    target: exitItem
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 250
                }
            }
        }
    }
}

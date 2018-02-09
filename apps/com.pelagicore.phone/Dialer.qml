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

import QtQuick 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import utils 1.0
import "."

UIScreen {
    id: root

    /*! The number to be dialed. */
    property alias number: dialInputText.text

    /*! This signal is emitted when the dial button is pressed. */
    signal dial(string number)

    /*! This signal is emitted when the hang up button is pressed. */
    signal hangUp()

    Frame {
        width: Style.hspan(10)
        height: Style.vspan(17)
        anchors.centerIn: parent

        TextField {
            id: dialInputText
            width: Style.hspan(8.5)
            anchors.top: parent.top
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
        }

        GridLayout {
            id: dialGrid
            objectName: "Dialer::DialGrid"
            columns: 3
            width: Style.hspan(8.5)
            height: Style.vspan(10)
            anchors.top: dialInputText.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            columnSpacing: 5
            rowSpacing: 5
            Repeater {
                model: ['1','2','3','4','5','6','7','8','9','*','0','#']
                Button {
                    id: button1
                    objectName: "Dialer::" + modelData.toString()
                    text: modelData
                    //15, 20 spacings divided by columns & rows accordingly
                    Layout.preferredWidth: (parent.width - 15) / 3
                    Layout.preferredHeight: (parent.height - 20) / 4
                    onClicked: {
                        dialInputText.text += text;
                    }
                }
            }
        }

        GridLayout {
            id: dialButtons
            objectName: "Dialer::DialButtons"
            width: Style.hspan(8.5)
            //20 the spacing and 4 rows
            height: (Style.vspan(10) - 20) / 4
            columns: 2
            anchors.top: dialGrid.bottom
            anchors.topMargin: 7
            anchors.horizontalCenter: parent.horizontalCenter
            columnSpacing: 5
            Button {
                id: dialButton
                objectName: "Dialer::Dial"
                text: "Dial"
                Layout.preferredWidth: (parent.width / 2) - 4
                Layout.preferredHeight: parent.height
                onClicked: {
                    dial(dialInputText.text);
                }
            }
            Button {
                objectName: "Dialer::DeleteButton"
                Layout.preferredWidth: dialButton.width
                Layout.preferredHeight: dialButton.height
                text: "\u232b " + "Delete"
                onClicked: {
                    if (dialInputText.text.length > 0) {
                        dialInputText.text = dialInputText.text.substring(0, dialInputText.text.length - 1);
                    }
                }
            }
        }
    }
}

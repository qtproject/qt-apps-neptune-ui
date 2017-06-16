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

import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

BasePage {
    id: root

    description: " The push button is perhaps the most commonly used widget in any" +
                 " graphical user interface. Pushing (or clicking) a button commands the computer" +
                 " to perform some action or answer a question. Common examples of buttons are OK," +
                 " Apply, Cancel, Close, Yes, No, and Help buttons."

    Button {
        id: buttonControl
        text: qsTr("Button")
        width: 100
        anchors.top: parent.top
        anchors.topMargin: 150
        anchors.horizontalCenter: parent.horizontalCenter

        onClicked: console.log("Button Clicked!");

        contentItem: Label {
            text: buttonControl.text
            font: buttonControl.font
            opacity: enabled ? 1.0 : 0.3
            color: buttonControl.down ? "#db9432" : "#ffffff"
            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
            elide: Label.ElideRight
        }
    }
}

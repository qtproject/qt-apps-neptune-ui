/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
** Contact: http://www.pelagicore.com/
**
** This file is part of Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Neptune IVI UI licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Pelagicore. For licensing terms
** and conditions see http://www.pelagicore.com.
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
****************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.0
import utils 1.0

UIElement {
    id: root

    property string timeFormat: "hh:mm"
    property var currentDate: new Date()

    hspan: 4
    vspan: 2

    RowLayout {
        anchors.top: parent.top
        anchors.right: parent.right
        spacing: Style.padding

        Text {
            id: clock
            Layout.preferredHeight: root.height
            verticalAlignment: Text.AlignVCenter

            font.family: Style.fontFamily
            font.weight: Font.Light
            font.pixelSize: Style.fontSizeXXL

            color: Style.colorWhite

            text: Qt.formatTime(root.currentDate, root.timeFormat)
        }

        Item {
            anchors.top: clock.top
            anchors.bottom: clock.bottom
            anchors.topMargin: Style.vspan(1) === 33 ? 4 : 9
            anchors.bottomMargin: Style.vspan(1) === 33 ? 3 : 5

            width: Style.hspan(1)

            Text {
                anchors.top: parent.top

                font.family: Style.fontFamily
                font.pixelSize: Style.fontSizeS
                font.capitalization: Font.AllUppercase

                color: Style.colorWhite

                text: Qt.formatDate(root.currentDate, 'ddd')
            }

            Text {
                anchors.bottom: parent.bottom

                font.family: Style.fontFamily
                font.pixelSize: Style.fontSizeS
                font.capitalization: Font.AllUppercase

                color: Style.colorWhite

                text: Qt.formatDate(root.currentDate, 'MMM d')
            }
        }
    }
}

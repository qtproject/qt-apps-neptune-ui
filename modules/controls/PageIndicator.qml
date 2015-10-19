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

import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import utils 1.0

UIElement {
    id: root
    hspan: 4
    vspan: 2

    property alias count: repeater.model
    property int currentIndex: 0

    signal clicked(int index)


    // Prevent click 'leakage' between items
    MouseArea {
        anchors.fill: parent
    }

    Row {
        id: row
        anchors.centerIn: parent

        Repeater {
            id: repeater

            delegate: Item {
                width: Style.hspan(1)
                height: Style.vspan(2)

                Rectangle {
                    anchors.centerIn: parent
                    width: height
                    height: parent.height * 0.3
                    color: root.currentIndex === index ? Style.colorWhite : Style.colorGrey
                    radius: width/2
                    border.color: Qt.darker(color, 1.5)

                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.clicked(index)
                }
            }
        }
    }
}

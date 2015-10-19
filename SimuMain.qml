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
import QtQuick.Controls 1.0 as QControls
import QtQuick.Layouts 1.0
import "sysui"
import controls 1.0
import utils 1.0

Item {
    id: root

    width: 1480
    height: 800

    Rectangle {
        anchors.fill: parent
        color: '#333'
    }

    Main1280x800 {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }


    Item {
        id: menu
        width: collapse?40:140
        height: parent.height
        property bool collapse
        Rectangle {
            anchors.fill: parent
            color: '#ccc'
            visible: !menu.collapse
        }


        ColumnLayout {
            anchors.fill: parent
            Rectangle {
                Layout.fillWidth: true
                height: 40
                color: '#000'
                MouseArea {
                    anchors.fill: parent
                    onClicked: menu.collapse = !menu.collapse
                }
            }
            QControls.CheckBox { text: 'Debug';
                checked: Style.debugMode
                onClicked: {
                    Style.debugMode = checked
                }
                visible: !menu.collapse

            }
            QControls.CheckBox {
                text: 'Grid';
                checked: Style.gridMode
                onClicked: {
                    Style.gridMode = checked
                }
                visible: !menu.collapse
            }
            Item {
                Layout.fillHeight: true
            }
        }
    }

}

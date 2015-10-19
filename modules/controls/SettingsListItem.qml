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
import QtQuick.Layouts 1.0

import controls 1.0
import utils 1.0

UIElement {
    id: root

    property alias iconName: icon.name
    property alias titleText: titleLabel.text
    property alias checked: switchControl.checked
    property alias hasChildren: childIndicator.visible
    property bool checkedEnabled: true

    signal clicked()

    Row {
        anchors.verticalCenter: parent.verticalCenter

        Symbol {
            id: icon

            hspan: 2; vspan: 2
            opacity: 0.4
        }

        Label {
            id: titleLabel

            hspan: 8; vspan: 2
            text: model.title
        }

        Switch {
            id: switchControl
            visible: root.checkedEnabled
            hspan: 3; vspan: 2
        }

        Icon {
            id: childIndicator

            hspan: 1; vspan: 2
            source: Style.icon("cloud_arrow")
        }
    }

    HDiv {
        anchors.verticalCenter: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        _tracer_color: 'transparent'
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.clicked()
            root.checked = !root.checked
        }
    }
}

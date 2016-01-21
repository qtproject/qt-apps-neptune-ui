/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
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

import QtQuick 2.0

import utils 1.0

Item {
    id: root
    anchors.fill: parent
    property color color: '#ac193d'
    property alias text: note.text
    property int padding: 1
    visible: Style.debugMode

    Rectangle {
        id: frame
        anchors.fill: parent
        anchors.margins: root.padding
        color: 'transparent'
        border.color: root.color
        border.width: 2
        opacity: 0.5
    }

    Text {
        id: note
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 4
        horizontalAlignment: Text.AlignRight
        font.pixelSize: 12
        color: root.color
    }
}

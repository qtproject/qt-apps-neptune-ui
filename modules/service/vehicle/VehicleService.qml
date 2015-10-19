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

pragma Singleton
import QtQuick 2.0

Item {
    id: root

    property real speed: 0
    property int displaySpeed: 0

    Timer {
        running: true
        repeat: true
        interval: 100
        onTriggered: { displaySpeed = speed }
    }

    SequentialAnimation on speed {
        running: true
        loops: Animation.Infinite
        NumberAnimation { from: 30; to: 80; duration: 3000 }
        NumberAnimation { from: 80; to: 30; duration: 2000 }
    }

    visible: false
}
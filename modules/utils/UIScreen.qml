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
import QtQuick.Controls 1.0
import utils 1.0
import controls 1.0

UIElement {
    id: root
    hspan: 24
    vspan: 24

    property Component statusItem: Item {}
    property string title
    property bool showBack: true

    signal backScreen()

    DisplayBackground {
        anchors.fill: parent
        visible: root.parent && root.parent.parent === null
    }

    Tool {
        id: backButton
        z: 5
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: Style.padding
        hspan: 2
        vspan: 2
        visible: root.showBack
        name: 'back'
        onClicked: root.backScreen()
    }

}

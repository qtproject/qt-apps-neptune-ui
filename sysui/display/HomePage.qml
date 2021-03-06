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

import QtQuick 2.6
import QtQuick.Controls 2.1

import controls 1.0
import utils 1.0
import widgets 1.0

UIPage {
    id: root

    height: Style.launcherHeight

    // Left widget side
    MapWidget {
        id: mapWidget
        width: Style.isPotrait ? Style.screenWidth : Style.screenWidth/2
        height: Style.launcherHeight
    }

    // Right widget side upper widget
    MusicWidget {
        id: musicWidget
        width: Style.screenWidth/2
        height: Style.isPotrait ? Style.launcherHeight/3 : Style.launcherHeight/2
        x: Style.isPotrait ? 0 : width
        y: Style.isPotrait ? (Style.launcherHeight - height) : 0
    }

    // Right side lower widget
    PhoneWidget {
        width: Style.screenWidth/2
        height: Style.isPotrait ? Style.launcherHeight/3 : Style.launcherHeight/2

        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
}

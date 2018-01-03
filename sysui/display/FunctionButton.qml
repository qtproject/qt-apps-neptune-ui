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
import QtGraphicalEffects 1.0

import utils 1.0

Button {
    id: root
    objectName: "FunctionButton::"+root.text

    width: Style.hspan(4)
    height: Style.vspan(7)
    topPadding: root.height * .75

    property url icon: icon.source

    RectangularGlow {
        anchors.fill: highlightBar
        glowRadius: 6
        spread: 0.1
        color: Style.colorWhite
        cornerRadius: highlightBar.radius + glowRadius
        opacity: root.highlighted ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }
    }

    Rectangle {
        id: highlightBar
        objectName: "FunctionButton::AreaButton_"+root.text
        anchors.left: root.left
        width: Style.hspan(0.1)
        height: parent.height
        border.color: Style.colorGrey
        radius: 8
        color: root.highlighted ? Style.colorOrange : Style.colorBlack
    }

    indicator: Image {
        objectName: "FunctionButton::Image_"+root.text
        anchors.centerIn: parent
        source: root.icon
    }
}

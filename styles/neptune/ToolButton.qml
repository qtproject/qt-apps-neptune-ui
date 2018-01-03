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


import QtQuick 2.8
import QtQuick.Templates 2.1 as T
import com.pelagicore.styles.neptune 1.0

T.ToolButton {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentItem.implicitHeight + topPadding + bottomPadding)
    baselineOffset: contentItem.y + contentItem.baselineOffset

    padding: 6
    font.pixelSize: control.NeptuneStyle.fontSizeM
    font.family: control.NeptuneStyle.fontFamily

    contentItem: Text {
        objectName: contentItem.parent.objectName + "_Text"
        text: control.text
        font: control.font
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        opacity: enabled ? 1.0 : 0.2
        color: control.NeptuneStyle.brightColor
    }

    background: Rectangle {
        objectName: background.parent.objectName + "_BackgroundEnabledStyle"
        implicitWidth: 68
        implicitHeight: 48

        color: control.enabled && (control.highlighted || control.checked)
               ? control.NeptuneStyle.darkColor
                 : "transparent"

        Rectangle {
            objectName: background.parent.objectName + "_BackgroundDownStyle"
            width: parent.width
            height: parent.height
            visible: control.down || control.hovered
            color: control.down
                   ? control.NeptuneStyle.lighter25(control.NeptuneStyle.darkColor)
                   : control.NeptuneStyle.darkColor
        }
    }
}

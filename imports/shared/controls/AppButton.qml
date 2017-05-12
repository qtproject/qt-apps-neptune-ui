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

import utils 1.0
import controls 1.0
import com.pelagicore.styles.neptune 1.0

Button {
    id: root

    property string name
    text: name
    property url icon: icon.source
    property bool editMode: false
    property bool removable: false
    property bool isUpdating: false
    topPadding: root.height * .75

    // Installation progress from 0.0 to 1.0, where 1.0 means
    // that the application is installed.
    property real installProgress: 1.0

    signal removeClicked()

    width: Style.hspan(4)
    height: Style.vspan(7)

    scale: editMode ? 0.8 : 1

    Behavior on scale {
        ScaleAnimator {
            easing.type: Easing.OutBounce
        }
    }


    indicator: Image {
        anchors.centerIn: parent
        source: root.icon
    }

    ProgressBar {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        padding: 6
        enabled: root.icon && (root.installProgress > 0.0 && root.installProgress < 1.0)
        visible: enabled
        value: root.installProgress
    }

    RoundButton {
        text: "\u2715"
        font.pixelSize: root.NeptuneStyle.fontSizeL
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -padding
        anchors.rightMargin: -padding
        height: width
        radius: width/2
        visible: root.editMode && root.removable
        enabled: root.editMode
        onClicked: root.removeClicked()
        scale: root.editMode ? 2.0 : 1.0
        Behavior on scale {
            ScaleAnimator {
                easing.type: Easing.OutBounce
            }
        }
    }
}

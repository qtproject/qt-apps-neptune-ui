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
import QtQuick.Layouts 1.0

import controls 1.0 as C
import utils 1.0
import QtQuick.Controls 2.1
import QtApplicationManager 1.0
import models.phone 1.0

UIPanel {
    id: root
    objectName: "PhoneWidget"
    height: Style.vspan(4)

    Rectangle {
        objectName: "PhoneWidget::ContentArea"
        anchors.fill: parent
        color: Style.colorBlack
        opacity: 0.8
    }

    C.Icon {
        id: phoneIcon
        objectName: "PhoneWidget::Phone"
        width: Style.hspan(2)
        height: Style.vspan(3)
        anchors.bottom: parent.bottom
        anchors.verticalCenter: nameLayout.verticalCenter
        source: Style.icon("widgets_phone")
    }

    ColumnLayout {
        id: nameLayout

        anchors.bottom: parent.bottom
        anchors.bottomMargin: Style.isPotrait ? Style.paddingXL * 2 : Style.paddingXL * 4
        anchors.left: phoneIcon.right
        anchors.leftMargin: Style.padding
        anchors.right: parent.right

        Label {
            objectName: "PhoneWidget::JohnDoeLabel"
            Layout.fillWidth: true
            text: qsTr("%1   | %2").arg("John Doe").arg("02:55")
            font.pixelSize: Style.fontSizeXL
            font.capitalization: Font.AllUppercase
        }

        Label {
            objectName: "PhoneWidget::NumberLabel"
            text: "555-55 55 55"
            font.pixelSize: Style.fontSizeXL
        }
    }

    MouseArea {
        objectName: "PhoneWidget::MouseClickableArea"
        anchors.fill: parent
        onClicked: PhoneModel.startPhoneApp()
    }
}

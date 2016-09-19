/****************************************************************************
**
** Copyright (C) 2016 Klarälvdalens Datakonsult AB (KDAB).
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

import QtQuick 2.5

import controls 1.0
import utils 1.0

UIPage {
    id: root

    hspan: 24
    vspan: 24

    ListModel {
        id: textFieldsModel

        ListElement { label: "Normal"; source: "Images/icon_normal.png"; inputMethodHints: Qt.ImhNone }
        ListElement { label: "Uppercase"; source: "Images/icon_upper.png"; inputMethodHints: Qt.ImhPreferUppercase }
        ListElement { label: "Lowercase"; source: "Images/icon_lower.png"; inputMethodHints: Qt.ImhPreferLowercase }
        ListElement { separator : true }
        ListElement { label: "Phone"; source: "Images/icon_phone.png"; inputMethodHints: Qt.ImhDialableCharactersOnly }
        ListElement { label: "URL"; source: "Images/icon_url.png"; inputMethodHints: Qt.ImhUrlCharactersOnly }
        ListElement { label: "Email"; source: "Images/icon_mail.png"; inputMethodHints: Qt.ImhEmailCharactersOnly }
        ListElement { separator : true }
        ListElement { label: "Password"; source: "Images/icon_password.png" }
        ListElement { label: "Digits"; source: "Images/icon_digits.png"; inputMethodHints: Qt.ImhDigitsOnly }
        ListElement { label: "Numbers"; source: "Images/icon_numbers.png"; inputMethodHints: Qt.ImhFormattedNumbersOnly }
        ListElement { label: "Date"; source: "Images/icon_date.png"; inputMethodHints: Qt.ImhDate }

        Component.onCompleted: textFieldsModel.setProperty(8, "inputMethodHints", Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText | Qt.ImhSensitiveData | Qt.ImhHiddenText)
    }

    ListView {
        id: textFieldListView

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: Style.vspan(1)
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Qt.inputMethod.visible ? Style.vspan(16) : Style.vspan(6) // FIXME use height form keyboardRectangle

        width: Style.hspan(14)

        spacing: Style.paddingS

        displayMarginBeginning: Style.vspan(1)
        displayMarginEnd: Style.vspan(2)

        model: textFieldsModel

        delegate: Loader {
            readonly property var modelData: model

            width: ListView.view.width
            height: Style.vspan(2)

            sourceComponent: separator ? separatorComponent : editorComponent

            onActiveFocusChanged: {
                if (activeFocus)
                    textFieldListView.positionViewAtIndex(index, ListView.Contain)
            }
        }
    }

    Component {
        id: separatorComponent

        HDiv {
            hspan: 14
        }
    }

    Component {
        id: editorComponent

        ClearableTextField {
            width: parent.width
            hintText: modelData ? modelData.label : ""
            icon: modelData ? Qt.resolvedUrl(modelData.source) : ""
            inputMethodHints: modelData ? modelData.inputMethodHints : Qt.ImhNone
        }
    }
}

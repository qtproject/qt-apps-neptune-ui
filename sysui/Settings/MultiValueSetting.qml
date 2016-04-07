/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
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

import QtQuick 2.1
import controls 1.0
import utils 1.0

UIElement {
    id: wrapper

    property var option

    Row {
        anchors.verticalCenter: parent.verticalCenter

        Label {
            id: titleLabel

            hspan: 10; vspan: 2
            text: option.name
            font.capitalization: Font.AllUppercase
            font.pixelSize: Style.fontSizeXL
        }

        PathView {
            id: optionsView

            width: Style.hspan(3)
            height: Style.vspan(2)

            model: option.options

            pathItemCount: 1
            clip: true
            interactive: false

            preferredHighlightBegin: 0.5
            preferredHighlightEnd: 0.5

            onCurrentIndexChanged: option.active = currentIndex

            delegate: Label {
                width: optionsView.width
                vspan: 2
                text: modelData
                color: Style.colorOrange
                horizontalAlignment: Qt.AlignRight
                font.pixelSize: Style.fontSizeXL
            }

            path: Path {
                startX: 0
                startY: optionsView.height/2

                PathLine {
                    x: optionsView.width
                    y: optionsView.height/2
                }
            }
        }

        Tool {
            name: "arrow_right"
            onClicked: optionsView.decrementCurrentIndex()
            size: Style.symbolSizeXS
        }
    }

    HDiv {
        anchors.verticalCenter: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        _tracer_color: 'transparent'
    }

    MouseArea {
        anchors.fill: parent
        onClicked: optionsView.decrementCurrentIndex()
    }
}

/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
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

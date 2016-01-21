/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
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
import QtQuick.Layouts 1.0

import controls 1.0
import utils 1.0

BaseBoard {
    id: root

    title: "Icon Board"

    Grid {
        anchors.fill: parent; anchors.margins: Style.padding
        rowSpacing: Style.padding
        columns: 2

        // Test icon w/o specifying any width/height
        Label {
            text: "No w/h specified"
            font.pixelSize: Style.fontSizeXS
        }
        Icon {
            vspan: 2
            source: Style.icon("climatebar_icon_seating_person")
        }

        // Test specify a width/height greater than the image's width/height
        Label {
            text: "w/h > image's w/h"
            font.pixelSize: Style.fontSizeXS
        }
        Icon {
            hspan: 3; vspan: 3
            source: Style.icon("climatebar_icon_seating_person")
        }

        // Test specifying a width/height which is less than the image's width/height
        Label {
            text: "w/h < image's w/h, w/ manual clip"
            font.pixelSize: Style.fontSizeXS
        }
        Icon {
            source: Style.icon("climatebar_icon_seating_person")
            hspan: 1; vspan: 1
            clip: true
        }

        // Test specifying a width/height which is less than the image's width/height
        Label {
            text: "w/h < image's w/h, w/o clip"
            font.pixelSize: Style.fontSizeXS
        }
        Icon {
            source: Style.icon("climatebar_icon_seating_person")
            Layout.preferredWidth: 30; Layout.preferredHeight: 30
        }


        // Test icon w/o specifying any width/height but use anchoring
        Label {
            text: "anchor to parent"
            font.pixelSize: Style.fontSizeXS
        }
        Item {
            width: Style.hspan(3); height: Style.vspan(3)

            Icon {
                source: Style.icon("climatebar_icon_seating_person")
                anchors.fill: parent
                Tracer {visible:true}
            }
        }

        // Test disable w/o a disable image
        Label {
            text: "Opacity on disabled"
            font.pixelSize: Style.fontSizeXS
        }
        Item {
            width: disableEnableOpacityIcon.width; height: disableEnableOpacityIcon.height

            Icon {
                id: disableEnableOpacityIcon

                vspan: 2
                source: Style.icon("climatebar_icon_seating_person")
                enabled: false
            }
            MouseArea {
                anchors.fill: parent
                onClicked: disableEnableOpacityIcon.enabled = !disableEnableOpacityIcon.enabled
            }
        }

        // Test disable w/ a disable image
        Label {
            text: "Image on disabled"
            font.pixelSize: Style.fontSizeXS
        }
        Item {
            width: disableEnableImageIcon.width; height: disableEnableImageIcon.height

            Icon {
                id: disableEnableImageIcon

                vspan: 2
                source: Style.icon ("climatebar_icon_seating_person")
                enabled: false
            }

            MouseArea {
                anchors.fill: parent
                onClicked: disableEnableImageIcon.enabled = !disableEnableImageIcon.enabled
            }
        }
    }
}

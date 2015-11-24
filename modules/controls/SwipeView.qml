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

import utils 1.0

UIElement {
    id: root

    property alias delegate: pathView.delegate
    property alias items: pathView.model
    property alias currentViewIndex: pathView.currentIndex

    property int itemWidth

    PathView {
        id: pathView

        property int padding: (width-root.itemWidth)/2

        anchors.fill: parent
        clip: true

        snapMode: PathView.SnapOneItem

        pathItemCount: 3

        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5

        path: Path {
            startX: -root.itemWidth+pathView.padding
            startY: pathView.height/2
            PathAttribute { name: "scale"; value: 0.5 }
            PathAttribute { name: "angle"; value: -100 }
            PathAttribute { name: "z"; value: 0 }
            PathAttribute { name: "yTranslate"; value: Style.vspan(4) }

            PathLine { x:  pathView.width/2; y: pathView.height/2 }
            PathAttribute { name: "scale"; value: 1 }
            PathAttribute { name: "angle"; value: 0 }
            PathAttribute { name: "z"; value: 1 }
            PathAttribute { name: "yTranslate"; value: 0 }

            PathLine { x: pathView.width + root.itemWidth-pathView.padding; y: pathView.height/2 }
            PathAttribute { name: "scale"; value: 0.5 }
            PathAttribute { name: "angle"; value: 100 }
            PathAttribute { name: "z"; value: 0 }
            PathAttribute { name: "yTranslate"; value: Style.vspan(4) }
        }
    }
}

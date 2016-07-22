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

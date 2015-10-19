/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
** Contact: http://www.pelagicore.com/
**
** This file is part of Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Neptune IVI UI licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Pelagicore. For licensing terms
** and conditions see http://www.pelagicore.com.
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
****************************************************************************/

import QtQuick 2.1
import QtQuick.Layouts 1.0

import controls 1.0
import utils 1.0
import "."

UIScreen {
    id: root
    hspan: 24
    vspan: 24


    PathView {
        id: view
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        height: Style.vspan(12)
        model: MusicProvider.model
        pathItemCount: 5
        currentIndex: MusicProvider.currentIndex
        path: Path {
            startX: -Style.hspan(3)
            startY: view.height/2
            PathLine {
                x: view.width+Style.hspan(3)
                y: view.height/2
            }
        }
        snapMode: PathView.SnapToItem
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5

        delegate: CoverItem {
            source: MusicProvider.coverPath(model.cover)
            title: model.title
            subTitle: model.artist
            onClicked: {
                MusicProvider.currentIndex = index
                root.backScreen()
            }
        }
    }

    Image {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        source: Style.gfx('shadow_left')
    }

    Image {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        source: Style.gfx('shadow_right')
    }

    Tool {
        hspan: 2
        vspan: 2
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: Style.padding
        name: 'back'
        onClicked: root.backScreen()
    }

}

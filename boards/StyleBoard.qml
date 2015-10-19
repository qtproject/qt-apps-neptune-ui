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

import QtQuick 2.0
import QtQuick.Layouts 1.0

import controls 1.0
import utils 1.0

BaseBoard {
    id: root
    title: 'Style Board'

    GridLayout {
        anchors.fill: parent
        anchors.margins: Style.padding
        columns: 2
        Label {
            text: 'Style.colorWhite'
            font.pixelSize: Style.fontSizeXS
        }
        Marker {
            color: Style.colorWhite
            solid: true
        }
        Label {
            text: 'Style.colorOrange'
            font.pixelSize: Style.fontSizeXS
        }
        Marker {
            color: Style.colorOrange
            solid: true
        }
        Label {
            id: label
            text: 'Style.colorGrey'
            font.pixelSize: Style.fontSizeXS
        }
        Marker {
            color: Style.colorGrey
            solid: true
        }
        Label {
            text: 'Style.colorBlack'
            font.pixelSize: Style.fontSizeXS
        }
        Marker {
            color: Style.colorBlack
            solid: true
        }
        Label {
            text: 'Size XS'
            font.pixelSize: Style.fontSizeXS
        }
        Label {
            text: 'Lorem Ipsum'
            font.pixelSize: Style.fontSizeXS
        }
        Label {
            text: 'Size S'
            font.pixelSize: Style.fontSizeXS
        }
        Label {
            text: 'Lorem Ipsum'
            font.pixelSize: Style.fontSizeS
        }
        Label {
            text: 'Size M'
            font.pixelSize: Style.fontSizeXS
        }
        Label {
            text: 'Lorem Ipsum'
            font.pixelSize: Style.fontSizeM
        }
        Label {
            text: 'Size L'
            font.pixelSize: Style.fontSizeXS
        }
        Label {
            text: 'Lorem Ipsum'
            font.pixelSize: Style.fontSizeL
        }
        Label {
            text: 'Size XL'
            font.pixelSize: Style.fontSizeXS
        }
        Label {
            text: 'Lorem Ipsum'
            font.pixelSize: Style.fontSizeXL
        }
        Spacer {
            Layout.fillHeight: true
        }
    }
}

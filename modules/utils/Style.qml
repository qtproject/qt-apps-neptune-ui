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

pragma Singleton
import QtQuick 2.1

QtObject {
    id: root

    property bool withCluster: false

    property int paddingXS: 2
    property int paddingS: 4
    property int padding: 8
    property int paddingL: 12
    property int paddingXL: 16

    property int displayHMargin: 11
    property int displayVMargin: 0
    property int cellWidth: 56 // (1366-22)/24 = 56
    property int cellHeight: 32 // 768/24 = 32
    property string fontFamily: true ? 'Source Sans Pro' : fontRegular.name
    property var fontWeight: Font.Light
    property int fontSizeXXS: 14
    property int fontSizeXS: 16
    property int fontSizeS: 18
    property int fontSizeM: 24
    property int fontSizeL: 28
    property int fontSizeXL: 36
    property int fontSizeXXL: 48
    property color colorWhite: '#ffffff'
    property color colorOrange: '#f07d00'
    property color colorGrey: '#999999'
    property color colorBlack: '#000000'
    property bool debugMode: false
    property bool gridMode: false
    property bool fakeBackground: false
    property real disabledIconOpacity: 0.6

    property int defaultSymbolSize: symbolSizeS
    property int defaultGfxSize: 1
    property int symbolSizeXS: 32
    property int symbolSizeS: 48
    property int symbolSizeM: 72
    property int symbolSizeL: 96
    property int symbolSizeXL: 144
    property int symbolSizeXXL: 192

    property url drawableUrl: Qt.resolvedUrl('../assets/drawable-ldpi')
    property url symbolUrl: Qt.resolvedUrl('../assets/icons')
    property url gfxUrl: Qt.resolvedUrl('../assets/gfx/')
    property url fonts: Qt.resolvedUrl('../assets/fonts/')

    property FontLoader fontRegular: FontLoader {
        source: font('SourceSansPro-Regular')
    }

    property FontLoader fontLight: FontLoader {
        source: font('SourceSansPro-Light')
    }

    function symbol(name, size, active) {
        if (size == 0)
            size = defaultSymbolSize
        return symbolUrl + (active ? '/active/' : '/') + name + '@' + size + '.png'
    }

    function symbolXS(name, active) {
        return symbol(name, symbolSizeXS, active);
    }

    function symbolS(name, active) {
        return symbol(name, symbolSizeS, active);
    }

    function symbolM(name, active) {
        return symbol(name, symbolSizeM, active);
    }

    function symbolL(name, active) {
        return symbol(name, symbolSizeL, active);
    }

    function symbolXL(name, active) {
        return symbol(name, symbolSizeXL, active);
    }

    function symbolXXL(name, active) {
        return symbol(name, symbolSizeXXL, active);
    }


    function gfx2(name) {
        return gfxUrl + name + '.png'
    }

    function gfx2Dynamic(name, size) {
        return gfxUrl + name + '@' + size + 'x.png'
    }

    function icon(name) {
        return drawableUrl + '/' + name + '.png';
    }

    function gfx(name) {
        return drawableUrl + '/' + name + '.png';
    }

    function hspan(value) {
        return cellWidth * value
    }

    function vspan(value) {
        return cellHeight * value
    }

    function asset(name) {
        return Qt.resolvedUrl('../assets/' + name)
    }

    function font(name) {
        return Qt.resolvedUrl('../assets/fonts/' + name + '.ttf')
    }
}

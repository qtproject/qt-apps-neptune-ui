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

pragma Singleton
import QtQuick 2.1
import QtApplicationManager 1.0

QtObject {
    id: root

    property bool withCluster: configValue("withCluster", false)

    property int paddingXS: configValue("paddingXS", 2)
    property int paddingS: configValue("paddingS", 4)
    property int padding: configValue("padding", 8)
    property int paddingL: configValue("paddingL", 12)
    property int paddingXL: configValue("paddingXL", 16)

    property int screenWidth: configValue("screenWidth", 1280)
    property int screenHeight: configValue("screenHeight", 800)
    property int displayHMargin: configValue("displayHMargin", 11)
    property int displayVMargin: configValue("displayVMargin", 0)
    property int cellWidth: configValue("cellWidth", 53) // 1280/24
    property int cellHeight: configValue("cellHeight", 33) // 800/24
    property string fontFamily: configValue("fontFamily", true ? 'Source Sans Pro' : fontRegular.name)
    property real fontWeight: configValue("fontWeight", Font.Light)
    property int fontSizeXXS: configValue("fontSizeXXS", 14)
    property int fontSizeXS: configValue("fontSizeXS", 16)
    property int fontSizeS: configValue("fontSizeS", 18)
    property int fontSizeM: configValue("fontSizeM", 24)
    property int fontSizeL: configValue("fontSizeL", 28)
    property int fontSizeXL: configValue("fontSizeXL", 36)
    property int fontSizeXXL: configValue("fontSizeXXL", 38)
    property color colorWhite: configValue("colorWhite", '#ffffff')
    property color colorOrange: configValue("colorOrange", '#f07d00')
    property color colorGrey: configValue("colorGrey", '#999999')
    property color colorBlack: configValue("colorBlack", '#000000')
    property bool debugMode: configValue("debugMode", false)
    property bool gridMode: configValue("gridMode", false)
    property bool fakeBackground: configValue("fakeBackground", false)
    property string displayBackground: configValue("displayBackground", "background_1280x800")
    property real disabledIconOpacity: configValue("disabledIconOpacity", 0.6)

    property int defaultSymbolSize: configValue("defaultSymbolSize", symbolSizeS)
    property int defaultGfxSize: configValue("defaultGfxSize", 1)
    property int symbolSizeXS: configValue("symbolSizeXS", 32)
    property int symbolSizeS: configValue("symbolSizeS", 48)
    property int symbolSizeM: configValue("symbolSizeM", 72)
    property int symbolSizeL: configValue("symbolSizeL", 96)
    property int symbolSizeXL: configValue("symbolSizeXL", 114)
    property int symbolSizeXXL: configValue("symbolSizeXXL", 192)

    property url drawableUrl: Qt.resolvedUrl('../assets/drawable-ldpi')
    property url symbolUrl: Qt.resolvedUrl('../assets/icons')
    property url gfxUrl: Qt.resolvedUrl('../assets/gfx/')
    property url fonts: Qt.resolvedUrl('../assets/fonts/')

    property bool isClient: ApplicationInterface
    property string styleConfig: isClient ? ApplicationInterface.additionalConfiguration.styleConfig : ApplicationManager.additionalConfiguration.styleConfig

    property Loader styleLoader: Loader {
        source: styleConfig === "auto" ? Qt.resolvedUrl("AutoConfig.qml") : styleConfig

        onLoaded: {
            print("StyleConfig loaded: ", source)
        }
    }

    property FontLoader fontRegular: FontLoader {
        source: font('SourceSansPro-Regular')
    }

    property FontLoader fontLight: FontLoader {
        source: font('SourceSansPro-Light')
    }

    function configValue(key, defaultValue) {
        return (styleLoader.item && styleLoader.item[key] )? styleLoader.item[key]: defaultValue
    }


    function symbol(name, size, active) {
        if (size === 0)
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

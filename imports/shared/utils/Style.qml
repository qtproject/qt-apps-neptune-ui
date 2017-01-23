/****************************************************************************
**
** Copyright (C) 2017 Pelagicore AG
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
import QtQuick 2.6
import QtApplicationManager 1.0
import QtQuick.Window 2.0
import com.pelagicore.styles.neptune 1.0

QtObject {
    id: root

    property bool withCluster: configValue("withCluster", false)

    property int paddingXS: configValue("paddingXS", 2)
    property int paddingS: configValue("paddingS", 4)
    property int padding: configValue("padding", 8)
    property int paddingL: configValue("paddingL", 12)
    property int paddingXL: configValue("paddingXL", 16)

    property int screenWidth: NeptuneStyle.windowWidth
    property int screenHeight: NeptuneStyle.windowHeight
    property int clusterWidth: configValue("clusterWidth", 1920)
    property int clusterHeight: configValue("clusterHeight", 720)
    property int displayHMargin: configValue("displayHMargin", 11)
    property int displayVMargin: configValue("displayVMargin", 0)
    property int cellWidth: configValue("cellWidth", screenWidth/24) // 1280/24
    property int cellHeight: configValue("cellHeight", screenHeight/24) // 800/24
    property string fontFamily: NeptuneStyle.fontFamily
    property real fontWeight: Font.Light
    property real fontFactor: NeptuneStyle.fontFactor
    property int fontSizeXXS: NeptuneStyle.fontSizeXXS
    property int fontSizeXS: NeptuneStyle.fontSizeXS
    property int fontSizeS: NeptuneStyle.fontSizeS
    property int fontSizeM: NeptuneStyle.fontSizeM
    property int fontSizeL: NeptuneStyle.fontSizeL
    property int fontSizeXL: NeptuneStyle.fontSizeXL
    property int fontSizeXXL: NeptuneStyle.fontSizeXXL
    property color colorWhite: NeptuneStyle.brightColor
    property color colorOrange: NeptuneStyle.accentColor
    property color colorGrey: NeptuneStyle.lighter25(NeptuneStyle.darkColor)
    property color colorBlack: NeptuneStyle.darkColor
    property bool debugMode: configValue("debugMode", false)
    property bool gridMode: configValue("gridMode", false)
    property bool fakeBackground: configValue("fakeBackground", false)
    property string displayBackground: NeptuneStyle.backgroundImage
    property real disabledIconOpacity: configValue("disabledIconOpacity", 0.6)

    property int defaultSymbolSize: configValue("defaultSymbolSize", symbolSizeM)
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

    property bool isClient: typeof ApplicationInterface !== 'undefined'
    property string styleConfig: isClient ? ApplicationInterface.systemProperties.styleConfig : ApplicationManager.systemProperties.styleConfig
    property bool showClusterIfPossible: isClient ? ApplicationInterface.systemProperties.showCluster :ApplicationManager.systemProperties.showCluster

    property Loader styleLoader: Loader {
        property bool showClusterIfPossible: root.showClusterIfPossible
        source: styleConfig === "auto" ? Qt.resolvedUrl("AutoConfig.qml") : styleConfig

        onLoaded: {
            print("StyleConfig loaded: ", source)
        }
    }

    function configValue(key, defaultValue) {
        return (styleLoader.item && styleLoader.item[key] )? styleLoader.item[key]: defaultValue
    }


    function symbol(name, size, active) {
        size = size || defaultSymbolSize;
        return symbolUrl + (active ? '/active/' : '/') + name + '@' + size + '.png';
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

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

import com.pelagicore.styles.neptune 1.0
import com.pelagicore.translation 1.0

QtObject {
    id: root

    property bool withCluster: true

    property int paddingXS: 2
    property int paddingS: 4
    property int padding: 8
    property int paddingL: 12
    property int paddingXL: 16

    property int screenWidth: NeptuneStyle.windowWidth
    property int screenHeight: NeptuneStyle.windowHeight
    property int clusterWidth: 1920
    property int clusterHeight: 720
    property int displayHMargin: 11
    property int displayVMargin: 0
    property int cellWidth: NeptuneStyle.cellWidth //1280/24
    property int cellHeight: NeptuneStyle.cellHeight // 800/24
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
    property bool debugMode: false
    property bool gridMode: false
    property bool fakeBackground: false
    property string displayBackground: NeptuneStyle.backgroundImage
    property real disabledIconOpacity: 0.6

    property bool isPotrait: screenWidth < screenHeight

    property int defaultSymbolSize: symbolSizeM
    property int defaultGfxSize: 1
    property int symbolSizeXS: 32
    property int symbolSizeS: 48
    property int symbolSizeM: 72
    property int symbolSizeL: 96
    property int symbolSizeXL: 114
    property int symbolSizeXXL: 192

    property int launcherSpan: 19
    property int notificationCenterSpan: 8

    // Cimate config
    property int climateCollapsedSpan: 3
    property real climateCollapsedVspan: vspan(climateCollapsedSpan)

    //StatusBar config
    property int statusBarSpan: 2
    property real statusBarHeight: vspan(statusBarSpan)

    //Popup config
    property real popupWidth: isPotrait ? hspan(12) : hspan(8)
    property real popupHeight: isPotrait ? vspan(5) : vspan(6)

    property real launcherHeight: vspan(launcherSpan)

    property string assetPath: Qt.resolvedUrl("../../assets/")
    property url drawableUrl: Qt.resolvedUrl(root.assetPath + 'drawable-ldpi')
    property url symbolUrl: Qt.resolvedUrl(root.assetPath + 'icons')
    property url gfxUrl: Qt.resolvedUrl(root.assetPath + 'gfx/')
    property url fonts: Qt.resolvedUrl(root.assetPath + 'fonts/')

    property alias languageLocale: translation.languageLocale
    property QtObject translation: Translation {
        id: translation
        Component.onCompleted: {
            setPath(root.assetPath + "translations/");
            languageLocale = "en_GB";
        }
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
        return Qt.resolvedUrl(root.assetPath +  + name)
    }

    function font(name) {
        return Qt.resolvedUrl(root.assetPath + '/fonts/' + name + '.ttf')
    }
}

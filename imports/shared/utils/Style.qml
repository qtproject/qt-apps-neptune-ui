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
import uiconfig 1.0

QtObject {
    id: root

    property QtObject configInfo: ConfigInfo {}

    property bool withCluster: configInfo.withCluster

    property int paddingXS: configInfo.paddingXS
    property int paddingS: configInfo.paddingS
    property int padding: configInfo.padding
    property int paddingL: configInfo.paddingL
    property int paddingXL: configInfo.paddingXL

    property int screenWidth: NeptuneStyle.windowWidth
    property int screenHeight: NeptuneStyle.windowHeight
    property int clusterWidth: configInfo.clusterWidth
    property int clusterHeight: configInfo.clusterHeight
    property int displayHMargin: configInfo.displayHMargin
    property int displayVMargin: configInfo.displayVMargin
    property int cellWidth: screenWidth/configInfo.cellFactor //1280/24
    property int cellHeight: screenHeight/configInfo.cellFactor // 800/24
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
    property bool debugMode: configInfo.debugMode
    property bool gridMode: configInfo.gridMode
    property bool fakeBackground: configInfo.fakeBackground
    property string displayBackground: NeptuneStyle.backgroundImage
    property real disabledIconOpacity: configInfo.disabledIconOpacity

    property int defaultSymbolSize: configInfo.defaultSymbolSize
    property int defaultGfxSize: configInfo.defaultGfxSize
    property int symbolSizeXS: configInfo.symbolSizeXS
    property int symbolSizeS: configInfo.symbolSizeS
    property int symbolSizeM: configInfo.symbolSizeM
    property int symbolSizeL: configInfo.symbolSizeL
    property int symbolSizeXL: configInfo.symbolSizeXL
    property int symbolSizeXXL: configInfo.symbolSizeXXL

    property real statusBarHeight: vspan(configInfo.statusBarSpan)
    property int notificationCenterWidth: configInfo.notificationCenterWidth
    property real climateCollapsedVspan: vspan(configInfo.climateCollapsedSpan)
    property real launcherHeight: vspan(configInfo.launcherSpan)

    property string assetPath: configInfo.assetPath
    property url drawableUrl: configInfo.drawableUrl
    property url symbolUrl: configInfo.symbolUrl
    property url gfxUrl: configInfo.gfxUrl
    property url fonts: configInfo.fonts

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

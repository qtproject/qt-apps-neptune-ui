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

import QtQuick 2.0

QtObject {

    property bool withCluster: true

    property int paddingXS: 2
    property int paddingS: 4
    property int padding: 8
    property int paddingL: 12
    property int paddingXL: 16

    property int clusterWidth: 1920
    property int clusterHeight: 720
    property int displayHMargin: 11
    property int displayVMargin: 0
    property int cellFactor: 24

    property bool debugMode: false
    property bool gridMode: false
    property bool fakeBackground: false

    property real disabledIconOpacity: 0.6

    property int defaultSymbolSize: symbolSizeM
    property int defaultGfxSize: 1
    property int symbolSizeXS: 32
    property int symbolSizeS: 48
    property int symbolSizeM: 72
    property int symbolSizeL: 96
    property int symbolSizeXL: 114
    property int symbolSizeXXL: 192

    property int statusBarSpan: 2
    property int climateCollapsedSpan: 3
    property int launcherSpan: 19
    property int notificationCenterWidth: 800

    property string assetPath: Qt.resolvedUrl("../../../assets/")
    property url drawableUrl: Qt.resolvedUrl(root.assetPath + 'drawable-ldpi')
    property url symbolUrl: Qt.resolvedUrl(root.assetPath + 'icons')
    property url gfxUrl: Qt.resolvedUrl(root.assetPath + 'gfx/')
    property url fonts: Qt.resolvedUrl(root.assetPath + 'fonts/')
}

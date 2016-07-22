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

    property alias delegate: listView.delegate
    property alias model: listView.model
    property alias currentIndex: listView.currentIndex
    property alias header: listView.header
    property bool scrollVisible: false

    ListView {
        id: listView

        anchors.fill: parent
        anchors.rightMargin: root.scrollVisible ? 5 : 0
        highlightRangeMode: root.scrollVisible ? ListView.StrictlyEnforceRange : ListView.NoHighlightRange
        clip: true
        currentIndex: root.scrollVisible ? sliderCOntainer.position*model.count : 0
    }

    ScrollIndicator {
        id: sliderCOntainer
        width: 5
        height: listView.height
        anchors.right: parent.right
        anchors.top: parent.top
        visible: root.scrollVisible

        givenPosition: (listView.currentIndex/listView.model.count) * listView.height // 0.0 up to 1.0
        scrollerSize: listView.height/listView.model.count + 100
    }
}

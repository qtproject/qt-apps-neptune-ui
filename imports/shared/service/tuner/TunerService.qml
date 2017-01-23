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
import QtQuick 2.0
import QtIvi 1.0
import QtIvi.Media 1.0

QtObject {
    id: root

    property AmFmTuner tunerControl: AmFmTuner {
        discoveryMode: AmFmTuner.AutoDiscovery

        onStationChanged: root.station.current = station
    }

    property var station: QtObject{
        property var current
    }

    property QtObject band: QtObject {
        readonly property var value: tunerControl.band
    }

    property QtObject frequency: QtObject {
        property real minimum: convertHzToMHz(tunerControl.minimumFrequency)
        property real maximum: convertHzToMHz(tunerControl.maximumFrequency)
        property real current: convertHzToMHz(tunerControl.frequency)
    }

    function setFrequency(frequency) {
        var newFrequency = Math.round(frequency * 10) * 100000 // Round to get a nice number in the MHz interval
        tunerControl.setFrequency(newFrequency);
    }

    function stepUp() {
        tunerControl.stepUp()
    }

    function stepDown() {
        tunerControl.stepDown()
    }

    function seekUp() {
        tunerControl.seekUp()
    }

    function seekDown() {
        tunerControl.seekDown()
    }

    function convertHzToMHz(frequency) {
        return frequency * 0.000001
    }
}

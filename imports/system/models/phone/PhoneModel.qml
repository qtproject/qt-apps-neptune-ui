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

import QtQuick 2.2

QtObject {
    id: root
    //This service shall be implemented as a model in the final version
    /*! Provides the name of the current paired device. */
    property string currentPairedDeviceName: ''
    /*! Provides information about if any device is currently paired. */
    property bool isAnyDevicePaired: false

    /*! Provides contacts list model of the currently paired devices'. */
    property ListModel contactsModel: ListModel {
        ListElement { name: "Andreas N." ; number: "01555222" }
        ListElement { name: "Alexandra F." ; number: "02524446" }
        ListElement { name: "Alvaro R." ; number: "0369885" }
        ListElement { name: "Bill T." ; number: "0784795" }
    }

    /*! Provides the currently available devices list model. */
    property ListModel availableDevices: ListModel {
        ListElement { name: "BlackBerry Z30" ; code: "0123" }
        ListElement { name: "Samsung-123" ; number: "0000" }
        ListElement { name: "i-Phone 6S" ; number: "1111" }
        ListElement { name: "Nexus" ; number: "8524" }
    }
}

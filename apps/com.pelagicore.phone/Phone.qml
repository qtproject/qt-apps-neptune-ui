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

/*!
\l{Neptune UI Phone Application to Neptune UI}
\title Neptune UI Phone Application
\brief This is the phone application of Neptune UI.
It's a basic implementetion where currently only
few features are supported.
\caption Features list:
\list
    \li Device pairing
    \li Display list of available devices
    \li Display list of contacts
    \li Dialer
    \li Call a contact or a number from dialer
\endlist
Dummy backend service is implemented for simulation purposes.
*/

import QtQuick 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import utils 1.0

import service.notification 1.0
import models.phone 1.0

AppUIScreen {
    id: root
    title: "Neptune Phone App"

    /*! Internal */
    property QtObject popupItem : NotificationInterface { }

    onRaiseApp: {
        if (PhoneModel.isAnyDevicePaired) {
            bar.currentIndex = 2;
        } else {
            popupItem.sticky = true;
            popupItem.summary = "No Device Paired";
            popupItem.body = "Please pair a device";
            popupItem.actions =  ["OK"];
            popupItem.show();
            bar.currentIndex = 1;
        }
    }

    onCloseApp: {
        if (popupItem.visible) {
            popupItem.timeout = 1;
            popupItem.sticky = false;
        }
    }


    Page {
        width: parent.width
        header: TabBar {
            id: bar
            TabButton {
                enabled: PhoneModel.isAnyDevicePaired
                text: qsTr("Dialer")
            }
            TabButton {
                text: qsTr("Devices")
            }
            TabButton {
                enabled: PhoneModel.isAnyDevicePaired
                text: qsTr("Contacts List")
            }
        }

        StackLayout {
            width: parent.width
            height: Style.vspan(17.4)
            currentIndex: bar.currentIndex
            Dialer {
                id: phoneTab
                onDial: {
                    popupItem.summary = "Calling...";
                    popupItem.body = number;
                    popupItem.actions =  ["Hang up"];
                    popupItem.show();
                }
                onBackScreen: {
                    root.back();
                }
            }
            DeviceList {
                onBackScreen: {
                    root.back();
                }
            }

            ContactsList {
                onDial: {
                    popupItem.summary = "Calling...";
                    popupItem.body = name + " " +  number;
                    popupItem.actions =  ["Hang up"];
                    popupItem.show();
                }
                onBackScreen: {
                    root.back();
                }
            }
        }
    }
}

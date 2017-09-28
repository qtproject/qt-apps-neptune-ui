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
import "JSONBackend.js" as JSONBackend
import QtApplicationManager 1.0

import utils 1.0

// TODO: Move this to a library and convert to QObject

Item {
    id: root
    property bool serverOnline: false
    property string serverReason
    property string server: ApplicationManager.systemProperties.appStoreServerUrl

    signal loginSuccessful()

    function goBack() {
        if (categoriesPage.state !== "")
            categoriesPage.goBack()
        else
            root.close();
    }

    function checkServer() {
        console.log(Logging.sysui, "#####################checkserver#####################")
        var url = server + "/hello"
        var data = {"platform" : "AM", "version" : "1"}
        JSONBackend.setErrorFunction(function () {
            serverOnline = false
            serverReason = "unknown"
        })
        JSONBackend.serverCall(url, data, function(data) {
            if (data !== 0) {
                if (data.status === "ok") {
                    serverOnline = true
                    root.login()
                    //refresh()
                } else if (data.status === "maintenance") {
                    serverOnline = false
                    serverReason = "maintenance"
                } else {
                    console.log(Logging.sysui, "HELLO ERROR: " + data.error)
                    serverOnline = false
                }
            } else {
                serverOnline = false
                serverReason = "unknown"
            }
        })
    }

    function login() {
        var url = server + "/login"
        var data = {"username" : "t", "password" : "t", "imei" : "112163001487801"}
        JSONBackend.serverCall(url, data, function(data) {
            if (data !== 0) {
                if (data.status === "ok") {
                    console.log(Logging.sysui, "LOGIN SUCCESSFUL");
                    loginSuccessful()
                } else {
                    console.log(Logging.sysui, "LOGIN ERROR: " + data.error)
                }
            }
        })
    }
    Component.onCompleted: checkServer()
}

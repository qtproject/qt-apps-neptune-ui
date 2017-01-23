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

import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtWebEngine 1.0
import controls 1.0
import utils 1.0

Control {
    id: root

    property alias title: webView.title
    property string url

    onUrlChanged: {
        var pattern = /^((file|http|https|ftp):\/\/)/;

        if (!pattern.test(url)) {
            url = "http://" + url;
        }
    }

    width: Style.hspan(12)
    height: Style.vspan(10)

    ColumnLayout {
        spacing: 0
        anchors.fill: parent

        Rectangle {
            id: toolBar

            Layout.fillWidth: true
            height: Style.vspan(2)
            color: "#333"

            RowLayout {
                spacing: 0
                anchors.fill: parent

                Tool {
                    width: Style.hspan(1)
                    height: Style.vspan(2)
                    symbol: "arrow_left"
                    enabled: webView.canGoBack
                    opacity: enabled ? 1 : 0.5
                    onClicked: webView.goBack()
                }
                Tool {

                    width: Style.hspan(1)
                    height: Style.vspan(2)
                    symbol: "arrow_right"
                    enabled: webView.canGoForward
                    opacity: enabled ? 1 : 0.5
                    onClicked: webView.goForward()
                }

                TextField {
                    id: urlTextField

                    height: Style.vspan(2)
                    Layout.fillWidth: true

                    text: root.url
                    hintText: qsTr('Enter an address')

                    onAccepted: root.url = text
                }

                Tool {
                    width: Style.hspan(2)
                    height: Style.vspan(2)
                    symbol: "update"

                    onClicked: webView.reload()
                }
            }

            Rectangle {
                id: progressBar

                anchors.bottom: parent.bottom
                width: parent.width * webView.loadProgress / 100
                height: 4
                color: Style.colorOrange

                opacity: webView.loading
                Behavior on opacity { NumberAnimation {} }
            }
        }

        Item {
            id: webContent

            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                id: webViewBackground

                anchors.fill: parent
                color: Style.colorWhite
            }

            WebEngineView {
                id: webView

                anchors.fill: parent
                url: root.url

                onLoadingChanged: {
                    if (loadRequest.status === WebEngineView.LoadFailedStatus) {
                        print("WebView.Loadfaild: " + loadRequest.errorString)
                        print("when loading: " + loadRequest.url)
                    }
                }
            }
        }
    }
}

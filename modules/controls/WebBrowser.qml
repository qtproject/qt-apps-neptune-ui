/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
** Contact: http://www.qt.io/ or http://www.pelagicore.com/
**
** This file is part of the Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:GPL3-PELAGICORE$
** Commercial License Usage
** Licensees holding valid commercial Pelagicore Neptune IVI UI
** licenses may use this file in accordance with the commercial license
** agreement provided with the Software or, alternatively, in accordance
** with the terms contained in a written agreement between you and
** Pelagicore. For licensing terms and conditions, contact us at:
** http://www.pelagicore.com.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU General Public License version 3 requirements will be
** met: http://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
** SPDX-License-Identifier: GPL-3.0
**
****************************************************************************/

import QtQuick 2.1
import QtQuick.Layouts 1.0
import QtWebEngine 1.0
import controls 1.0
import utils 1.0

UIElement {
    id: root

    property alias title: webView.title
    property string url

    onUrlChanged: {
        var pattern = /^((file|http|https|ftp):\/\/)/;

        if (!pattern.test(url)) {
            url = "http://" + url;
        }
    }

    hspan: 12
    vspan: 10

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
                    hspan: 1
                    vspan: 2
                    name: "arrow_left"
                    enabled: webView.canGoBack
                    opacity: enabled ? 1 : 0.5
                    onClicked: webView.goBack()
                }
                Tool {

                    hspan: 1
                    vspan: 2
                    name: "arrow_right"
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
                    hspan: 2
                    vspan: 2
                    name: "update"

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

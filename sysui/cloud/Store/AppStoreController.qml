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
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0

import controls 1.0
import utils 1.0

import "JSONBackend.js" as JSONBackend
import QtApplicationManager 1.0


// TODO: extract operations into a library, leave UI here. Think about a better name then controller

Item {
    id: root

    property int categoryid: 1
    property string filter: ""

    function download(id) {
        var url = appstore.server + "/app/purchase"
        var data = {"id": id, "device_id" : "00-11-22-33-44-55" }

        JSONBackend.serverCall(url, data, function(data) {
            if (data !== 0) {
                if (data.status === "ok") {
                    print("start downloading")
                    var icon = appstore.server + "/app/icon?id=" + id
                    var installID = ApplicationInstaller.startPackageInstallation("internal-0", data.url);
                    ApplicationInstaller.acknowledgePackageInstallation(installID);
                } else if (data.status === "fail" && data.error === "not-logged-in"){
                    print(":::AppStoreController::: not logged in")
                } else {
                    print(":::AppStoreController::: download failed: " + data.error)
                }
            }
        })
    }

    AppStore {
        id: appstore
        onLoginSuccessful: categoryModel.refresh()
    }

    JSONModel {
        id: categoryModel
        url: appstore.server + "/category/list"
    }

    JSONModel {
        id: appModel
        url: appstore.server + "/app/list"
        data: root.categoryid >= 0 ? ({ "filter" : root.filter , "category_id" : root.categoryid}) : ({ "filter" : root.filter})
    }

    function selectCategory(index) {
        var category = categoryModel.get(index);
        if (category) {
            appGrid.appCategory = category.name;
            root.categoryid = category.id;
        } else {
            appGrid.appCategory = '';
            root.categoryid = 1;
        }
        appModel.refresh();
    }

    RowLayout {
        anchors.centerIn: parent
        width: root.width*.5
        height: root.height*.75
        spacing: Style.hspan(1)

        ListView {
            id: categoryView
            clip: true
            Layout.fillHeight: true
            Layout.preferredWidth: Style.hspan(4)

            model: categoryModel

            header: Label {
                text: "CATEGORY"
                font.pixelSize: Style.fontSizeM
            }

            delegate: Button {
                width: ListView.view.width
                text: model.name
                highlighted: ListView.isCurrentItem
                onClicked: {
                    ListView.view.currentIndex = index;
                    root.selectCategory(index);
                }
            }
            ScrollBar.vertical: ScrollBar { }
        }
        AppGridView {
            id: appGrid
            // The graphics for the category list is not align to the grid, have to specify hardcoded values.
            Layout.fillWidth: true
            Layout.fillHeight: true
            loading: categoryModel.status !== "ready" || appModel.status !== "ready"
            serverUrl: appstore.server
            cellWidth: Style.hspan(3)
            cellHeight: Style.vspan(5)

            model: appModel

            onRequestDownload: {
                root.download(appId);
            }
        }
    }
}

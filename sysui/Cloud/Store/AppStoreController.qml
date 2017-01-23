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
        onLoginSuccessful: categoriesModel.refresh()
    }

    JSONModel {
        id: categoriesModel
        url: appstore.server + "/category/list"
    }

    JSONModel {
        id: appModel
        url: appstore.server + "/app/list"
        data: root.categoryid >= 0 ? { "filter" : root.filter , "category_id" : root.categoryid} : { "filter" : root.filter}
    }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter

            Column {
                width: Style.hspan(4)

                ListViewManager {
                    id: categoryView

                    anchors.left: parent.left; anchors.right: parent.right
                    height: Style.vspan(14)

                    model: categoriesModel

                    header: Label {
                        // The graphics for the category list is not align to the grid, have to specify hardcoded values.
                        height: Style.vspan(5/3)
                        anchors.left: parent.left; anchors.right: parent.right
                        anchors.margins: Style.paddingXL

                        text: "CATEGORY"
                        font.pixelSize: Style.fontSizeM
                    }

                    delegate: CategoryListItem {
                        width: ListView.view.width
                        height: Style.vspan(5/3)
                        text: model.name
                        onClicked: ListView.view.currentIndex = index
                    }

                    onCurrentIndexChanged: {
                        appGrid.appCategory = model.get(currentIndex) ? model.get(currentIndex).name : ""
                        categoryid = model.get(currentIndex) ? model.get(currentIndex).id : 1
                        appModel.refresh()
                    }
                }
            }

            AppGridView {
                id: appGrid
                // The graphics for the category list is not align to the grid, have to specify hardcoded values.
                width: Style.hspan(3)*4
                height: root.height
                loading: categoriesModel.status !== "ready" || appModel.status !== "ready"

                cellWidth: Style.hspan(3)
                cellHeight:Style.vspan(5)

                appCategory: ""

                model: appModel

                delegate: AppGridItemDelegate {
                    width: GridView.view.cellWidth
                    height: GridView.view.cellHeight

                    icon: appstore.server + "/app/icon?id=" + model.id //model.icon
                    titleText: model.name //model.title
                    subtitleText: model.category //model.subtitle

                    onClicked: download(model.id)
                }
            }
        }

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            source: Style.icon('appstore_bottom_shadow')
            asynchronous: true
            visible: false
        }
    }

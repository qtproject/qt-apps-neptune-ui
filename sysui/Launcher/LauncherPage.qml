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

import controls 1.0
import utils 1.0
import service.apps 1.0

import io.qt.ApplicationManager 1.0
import io.qt.ApplicationInstaller 1.0

UIPage {
    id: root
    hspan: 24
    vspan: 21

    title: qsTr("App Launcher")
    symbolName: "apps"

    signal updateApp()

    GridView {
        id: view

        property bool editMode: false
        property int columns: root.width/Style.hspan(4)

        anchors.top: parent.top
        anchors.topMargin: Style.vspan(3)
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: cellWidth*columns

        clip: true
        cellWidth: Style.hspan(4)
        cellHeight: Style.vspan(7)

        model: ApplicationManager

        flickableChildren: MouseArea {
            anchors.fill: parent
            onClicked: view.editMode = false
        }

        add: Transition {
            NumberAnimation { properties: "opacity, scale"; from: 0; to: 1 }
        }

        remove: Transition {
            NumberAnimation { properties: "opacity, scale"; to: 0 }
        }

        displaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 200 }
        }

        delegate: AppButton {
            width: view.cellWidth
            height: view.cellHeight

            name: model.name
            icon: Qt.resolvedUrl(model.icon)

            editMode: view.editMode
            removable: model.isRemovable
            installProgress: model.updateProgress
            isUpdating: model.isUpdating

            onIsUpdatingChanged: {
                if (isUpdating)
                    root.updateApp()
            }

            onClicked: {
                if (view.editMode) {
                    view.editMode = false
                } else {
                    if (!model.isUpdating)
                        console.log("Starting app " + model.applicationId + ": " + ApplicationManager.startApplication(model.applicationId));
                }
            }

            onRemoveClicked: {
                ApplicationInstaller.removePackage(model.applicationId, false /*keepDocuments*/, true /*force*/)
            }
            onPressAndHold: view.editMode = true
        }
    }
}

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

import QtApplicationManager 1.0


UIPage {
    id: root

    signal updateApp(int index)

    header: AppInfoPanel {
        Layout.fillWidth: true
        Layout.preferredHeight: Style.vspan(2)
        title: 'App Launcher'
        symbolName: 'apps'
    }

    GridView {
        id: view
        anchors.fill: parent

        property bool editMode: false
        property int columns: root.width/cellWidth

        clip: true
        cellWidth: Style.isPotrait ? width/3 : width/4
        cellHeight: Style.isPotrait ? height/4 : height/3

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

        delegate: Item {
            width: GridView.view.cellWidth
            height: GridView.view.cellHeight
            AppButton {
                anchors.fill: parent
                anchors.margins: padding
                name: model.name
                icon: Qt.resolvedUrl(model.icon)

                editMode: view.editMode
                removable: model.isRemovable
                installProgress: model.updateProgress
                isUpdating: model.isUpdating

                onIsUpdatingChanged: {
                    if (isUpdating)
                        root.updateApp(index)
                }

                onClicked: {
                    if (view.editMode) {
                        view.editMode = false
                    } else {
                        if (!model.isUpdating) {
                            console.log("Starting app " + model.applicationId + ": " + ApplicationManager.startApplication(model.applicationId));
                        }
                    }
                }

                onRemoveClicked: {
                    console.log('003: remove app')
                    view.editMode = false;
                    ApplicationInstaller.removePackage(model.applicationId, false /*keepDocuments*/, true /*force*/);
                }
                onPressAndHold: view.editMode = true
            }
        }
    }
}

/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
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
import service.settings 1.0

UIPage {
    id: root

    hspan: 24
    vspan: 24

    title: qsTr('Car Settings')
    symbolName: "settings"


    ListView {
        id: settingsListView

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: Style.vspan(2)
        anchors.bottom: parent.bottom
        width: Style.hspan(14)

        clip: true
        model: SettingsService.carSettings

        delegate: Loader {
            width: ListView.view.width
            height: Style.vspan(2)

            sourceComponent: modelData.option.options ? multiValueSetting : booleanSetting
            asynchronous: true
            onLoaded: item.option = modelData.option
        }
    }

    Image {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        source: Style.icon('cloud_bottom_shadow')
        asynchronous: true
        visible: false
    }

    Component {
        id: multiValueSetting

        MultiValueSetting {
        }
    }

    Component {
        id: booleanSetting

        BooleanSetting {
        }
    }
}

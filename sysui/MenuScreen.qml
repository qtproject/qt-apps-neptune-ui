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

import QtQuick 2.0
import QtQml.Models 2.1
import controls 1.0
import utils 1.0
import "MyCar"
import "Settings"
import "Home"
import "Launcher"
import "Cloud"

PageSwipeScreen {
    id: root

    title: currentItem.title

    statusItem: PageIndicator {
        count: root.count
        currentIndex: root.currentIndex
        onClicked: {
            root.currentIndex = index
        }
    }

    itemWidth: Style.hspan(24)

    currentIndex: Math.floor(root.count/2)

    items: ObjectModel {
        MyCarPage {
            width: root.itemWidth
            height: root.height
        }
        FunctionsPage {
            width: root.itemWidth
            height: root.height
        }
        HomePage {
            width: root.itemWidth
            height: root.height
        }
        LauncherPage {
            id: launcher
            width: root.itemWidth
            height: root.height
            onUpdateApp: currentIndex = 3
        }
        CloudPage {
            width: root.itemWidth
            height: root.height
        }
    }
}

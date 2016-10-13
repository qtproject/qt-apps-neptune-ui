/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
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
            visible: root.currentIndex === ObjectModel.index ||
                     root.moving &&
                     (root.currentIndex + 1  === ObjectModel.index ||
                      root.currentIndex - 1  === ObjectModel.index)
        }
        FunctionsPage {
            width: root.itemWidth
            height: root.height
            visible: root.currentIndex === ObjectModel.index ||
                     root.moving &&
                     (root.currentIndex + 1  === ObjectModel.index ||
                      root.currentIndex - 1  === ObjectModel.index)
        }
        HomePage {
            width: root.itemWidth
            height: root.height
            visible: root.currentIndex === ObjectModel.index ||
                     root.moving &&
                     (root.currentIndex + 1  === ObjectModel.index ||
                      root.currentIndex - 1  === ObjectModel.index)
        }
        LauncherPage {
            id: launcher
            width: root.itemWidth
            height: root.height
            onUpdateApp: currentIndex = 3
            visible: root.currentIndex === ObjectModel.index ||
                     root.moving &&
                     (root.currentIndex + 1  === ObjectModel.index ||
                      root.currentIndex - 1  === ObjectModel.index)
        }
        CloudPage {
            width: root.itemWidth
            height: root.height
            visible: root.currentIndex === ObjectModel.index ||
                     root.moving &&
                     (root.currentIndex + 1  === ObjectModel.index ||
                      root.currentIndex - 1  === ObjectModel.index)
        }
    }
}

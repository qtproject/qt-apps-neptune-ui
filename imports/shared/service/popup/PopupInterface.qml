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
import QtApplicationManager 1.0

/*!
    \qmltype PopupInterface
    \inqmlmodule service
    \inherits Notification
    \brief PopupInterface provides an interface for requesting popups.

    PopupInterface inherits \l {https://doc.qt.io/QtApplicationManager/qml-qtapplicationmanager-notification.html}
    {Notification} component and acts like an adapter for Neptune UI popups. Some properties are adopted
    to match Neptune UI popup requirements. Properties \c timeout and \c category are modified and adopted for Neptune UI and
    should not be used. By Neptune interaction design, popups should be dissmissed by user and
    not by the timeout.

    Example usage:

    \qml

    PopupInterface {
        id: popupInterfaceLowPrio
        actions: [ { text: "Cancel" } ]
        title: "Popup Prio 9"
        summary: "Popup Sample"
        priority: 9
    }

    \endqml

    Based on the \c priority popups will be queued. The \c actions property defines an array
    of buttons for popup.
*/

Notification {
    id: root

    category: "popup"
    timeout: 0

    /*!
         \qmlproperty string AppUIScreen::title

         This property assigns title of the popup.
    */

    property string title: ""

    /*!
         \qmlproperty string AppUIScreen::subtitle

         This property assigns subtitle of the popup.
    */

    property string subtitle: ""

    onTitleChanged: {
        root.updatePopup();
    }

    onSubtitleChanged: {
        root.updatePopup();
    }

    function updatePopup() {
        root.extended = {
            "title": root.title,
            "subtitle": root.subtitle
        }
        root.update();
    }
}

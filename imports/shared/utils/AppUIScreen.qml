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

import QtApplicationManager 1.0
import controls 1.0
import utils 1.0

/*!
    \qmltype AppUIScreen
    \inqmlmodule utils
    \inherits ApplicationManagerWindow
    \brief A base QML item for developing applications.

    AppUIScreen is a QML item which should be a root element in every
    Neptune UI application. It provides APIs for interacting with a system UI and
    for positioning the application's visual elements.

    See \l{Neptune UI Application Development} for best practices on how to use the APIs.

    \section2 Example Usage

    The following example uses \l{AppUIScreen} as a root element:

    \qml

    AppUIScreen {
        id: root
        title: "Neptune Template"

        UIScreen {
            Content {
                anchors.centerIn: parent
                width: Style.hspan(13)
                height: Style.vspan(24)
            }

            onBackScreen: root.back()
        }
    }
    \endqml

*/

ApplicationManagerWindow {
    id: pelagicoreWindow
    width: Style.hspan(24)
    height: Style.vspan(24)

    /*!
         \qmlproperty Item AppUIScreen::content

         A default property that specifies a content area for the application's visual content.
    */

    default property alias content: content.children

    /*!
         \qmlproperty Item AppUIScreen::cluster

         If a cluster is available, this property assigns visual content for the cluster window.
    */

    property alias cluster: clusterContainer.children

    /*!
         \qmlsignal AppUIScreen::clusterKeyPressed(int key)

         This signal is emitted every time a key is pressed in a cluster.

    */

    signal clusterKeyPressed(int key)

    /*!
         \qmlsignal AppUIScreen::raiseApp()

         This signal is emitted every time an application is started.

    */

    signal raiseApp()

    /*!
         \qmlsignal AppUIScreen::closeApp()

         This signal is emitted every time an application is closed by clicking
         the back button.

    */

    signal closeApp()

    /*!
        \qmlmethod AppUIScreen::back()

        This method is called when an application needs to exit. It ensures the
        system UI screen visibility when a back button is clicked.

        \qml
        AppUIScreen {
            id: root
            title: "Neptune Template"

            UIScreen {
                Content {
                    anchors.centerIn: parent
                    width: Style.hspan(13)
                    height: Style.vspan(24)
                }

                onBackScreen: root.back()
            }
        }
        \endqml

    */


    function back() {
        pelagicoreWindow.setWindowProperty("visibility", false)
        closeApp();
    }

    onWindowPropertyChanged: {
        if (name === "visibility" && value === true) {
            pelagicoreWindow.raiseApp()
        }
    }

    BackgroundPane {
        anchors.fill: parent
    }

    ApplicationManagerWindow {
        id: clusterSurface
        width: typeof parent !== 'undefined' ? parent.width : Style.hspan(24)
        height: typeof parent !== 'undefined' ? parent.height : Style.vspan(24)
        visible: clusterContainer.children.length > 0 && Style.withCluster
        color: "transparent"

        Item {
            id: clusterContainer
            anchors.fill: parent
        }

        Component.onCompleted: {
            clusterSurface.setWindowProperty("windowType", "clusterWidget")
        }

        onWindowPropertyChanged: {
            pelagicoreWindow.clusterKeyPressed(value)
        }
    }

    Item {
        id: content
        anchors.fill: parent
    }
}

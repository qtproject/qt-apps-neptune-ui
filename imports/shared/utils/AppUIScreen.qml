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
    \brief AppUIScreen provides base item for developing the applications.

    AppUIScreen is a QML item which should be a root element for every
    Neptune application. It provides APIs to interact with the system UI and
    to position application visual elements.

    Check { Neptune Application Development }  { Neptune Application Development }
    for best practices on how to use the APIs.

    Example usage:

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

         This default property specifies the content area for application visual content.
    */

    default property alias content: content.children

    /*!
         \qmlproperty Item AppUIScreen::cluster

         This property assigns visual content for the cluster window, if cluster
         is available.
    */

    property alias cluster: clusterContainer.children

    signal clusterKeyPressed(int key)

    /*!
         \qmlsignal AppUIScreen::raiseApp()

         The signal which is emitted every time application starts.

    */

    signal raiseApp()

    /*!
         \qmlsignal AppUIScreen::closeApp()

         The signal is emitted every time application closes (back button clicked).

    */

    signal closeApp()

    /*!
        \qmlmethod AppUIScreen::back()

        This method is called when an application needs to exit.

        When user clicks on back button of the application, this method
        makes sure system UI screen is shown.

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

        \sa fullScreenContent
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
            //print(":::AppUIScreen::: window property changed", name, value, Qt.Key_Up)
            pelagicoreWindow.clusterKeyPressed(value)
        }
    }

    Item {
        id: content
        anchors.fill: parent
    }
}

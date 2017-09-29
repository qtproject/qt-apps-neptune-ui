/****************************************************************************
**
** Copyright (C) 2016 The Qt Company.
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

import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import com.theqtcompany.comtqci18ndemo 1.0
import QtQuick.VirtualKeyboard.Settings 2.1

import controls 1.0
import utils 1.0

UIPage {
    id: root

    RowLayout {
        id: panes

        spacing: Style.hspan(1)

        anchors.fill: parent

        ColumnLayout {
            id: langSelectionLayout

            spacing: Style.vspan(1)

            anchors.top: parent.top
            anchors.topMargin: Style.vspan(3)
            anchors.left: parent.left
            anchors.leftMargin: Style.hspan(1)

            QtObject {
                id: langListBuilder
                property var list: VirtualKeyboardSettings.activeLocales
                //property var list: new Array("ar_AR", "de_DE", "en_GB", "fr_FR", "fi_FI", "ko_KR", "ja_JP", "zh_CN", "zh_TW", "ru_RU")

                onListChanged: {
                    var idx = 0
                    var idx_ofenGB = 0
                    var localeObj

                    if (list.length > 0) {
                        for (idx = 0;idx < list.length;idx++) {
                            if (list[idx] === "en_GB") {
                                idx_ofenGB = idx
                            }

                            localeObj = Qt.locale(list[idx])

                            langList.append( {
                                    language: list[idx],
                                    languageName: localeObj.nativeLanguageName,
                                    rtl: (localeObj.textDirection === Qt.RightToLeft)
                                    } )
                        }
                    }
                    langSelectView.currentIndex = idx_ofenGB-1
                }
            }

            ListModel {
                id: langList
            }

            Label {
                id: lblHeader
                //% "Language Selection"
                text: qsTrId("lang_selection_id") + ctd.emptyString
                width: Style.hspan(5)
                height: Style.vspan(1)
                font.pixelSize: Style.fontSizeM
                LayoutMirroring.enabled: (Qt.locale(ctd.languageLocale).textDirection === Qt.RightToLeft)
            }

            ListViewManager {
                id: langSelectView

                width: Style.hspan(5)
                height: Style.vspan(6)

                model: langList

                delegate: CategoryListItem {
                    width: ListView.view.width
                    height: Style.vspan(1)

                    text: model.languageName

                    onClicked: langSelectView.currentIndex = index
                }
                onCurrentIndexChanged: {
                    console.log(Logging.apps, "Index changed " + currentIndex)
                    ctd.languageLocale = langList.get(currentIndex)?langList.get(currentIndex).language:""
                    VirtualKeyboardSettings.locale = ctd.languageLocale
                }
            }
            Component.onCompleted: {
                VirtualKeyboardSettings.activeLocales = new Array("ar_AR", "de_DE", "en_GB", "fr_FR", "fi_FI", "ko_KR", "ja_JP", "zh_CN", "zh_TW", "ru_RU")
            }
        }

        Flickable {
            anchors.top: parent.top

            anchors.left: langSelectionLayout.right
            anchors.leftMargin: Style.hspan(1)

            ColumnLayout {
                id: elementContainer

                anchors.top: parent.top
                anchors.verticalCenter: parent.verticalCenter

                spacing: Style.vspan(1)

                LayoutMirroring.enabled: (Qt.locale(ctd.languageLocale).textDirection === Qt.RightToLeft)
                LayoutMirroring.childrenInherit: true

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label {
                        width: Style.hspan(4)
                        //% "Number"
                        text: qsTrId("number_id") + ctd.emptyString
                        font.pixelSize: Style.fontSizeL
                    }

                    Label {
                        width: Style.hspan(6)

                        text: Number(10.5456).toLocaleString(Qt.locale(ctd.languageLocale), 'f', 4)
                        font.pixelSize: Style.fontSizeL
                    }

                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label {
                        width: Style.hspan(4)
                        //% "Currency"
                        text: qsTrId("currency_id") + ctd.emptyString
                        font.pixelSize: Style.fontSizeL
                    }

                    Label {
                        width: Style.hspan(6)

                        text: Number(2900.40).toLocaleCurrencyString(Qt.locale(ctd.languageLocale))
                    }
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label {
                        width: Style.hspan(4)

                        //% "Date"
                        text: qsTrId("date_id") + ctd.emptyString
                        font.pixelSize: Style.fontSizeL
                    }

                    Label {
                        width: Style.hspan(6)

                        text: new Date().toLocaleDateString(Qt.locale(ctd.languageLocale))
                    }
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label {
                        width: Style.hspan(4)

                        //% "Time"
                        text: qsTrId("time_id") + ctd.emptyString
                        font.pixelSize: Style.fontSizeL
                    }

                    Label {
                        width: Style.hspan(6)

                        text: new Date().toLocaleTimeString(Qt.locale(ctd.languageLocale))
                    }
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label {
                        width: Style.hspan(4)

                        //% "Name"
                        text: qsTrId("name_id") + ctd.emptyString
                        font.pixelSize: Style.fontSizeL
                    }

                    TextField {
                        width: Style.hspan(6)

                        forceFocusOnClick: true
                    }
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label {
                        width: Style.hspan(4)

                        //% "Description"
                        text: qsTrId("description_id") + ctd.emptyString
                        font.pixelSize: Style.fontSizeL
                    }

                    Flickable {
                        height: Style.vspan(10)
                        width: Style.hspan(8)

                        contentWidth: txtDesc.width
                        contentHeight: txtDesc.height

                        clip: true

                        Label {
                            id: txtDesc
                            width: Style.hspan(8)
                            height: Style.vspan(10)

                            verticalAlignment: Text.AlignTop

                            //% "Demo description"
                            text: qsTrId("description_text_id") + ctd.emptyString
                            font.pixelSize: Style.fontSizeS
                            wrapMode: Text.Wrap
                        }
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        console.log(Logging.apps, "RowLayout completed " + ctd.languageLocale)
    }
}

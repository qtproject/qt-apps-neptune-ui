/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
** Contact: http://www.pelagicore.com/
**
** This file is part of Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Neptune IVI UI licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Pelagicore. For licensing terms
** and conditions see http://www.pelagicore.com.
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
****************************************************************************/

import QtQuick 2.1
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0
import controls 1.0
import utils 1.0

StackView {
    id: stack

    delegate: StackViewDelegate {
        function transitionFinished(properties)
        {
        }

        pushTransition: StackViewTransition {
            id: pushTransition
            property int duration: 400


            PropertyAnimation {
                target: exitItem
                property: "x"
                to: -(2*exitItem.width)
                duration: pushTransition.duration
            }

            PropertyAnimation {
                target: enterItem
                property: "x"
                from: 2*enterItem.width
                to: 0
                duration: pushTransition.duration
            }
        }
        popTransition: StackViewTransition {
            id: popTransition
            property int duration: 250

            PropertyAnimation {
                target: exitItem
                property: "x"
                to: 2*exitItem.width
                duration: popTransition.duration
            }

            PropertyAnimation {
                target: enterItem
                property: "x"
                from: -(2*enterItem.width)
                to: 0
                duration: popTransition.duration
            }
        }
    }
    Tracer{}
}

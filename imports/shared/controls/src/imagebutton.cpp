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

#include "imagebutton.h"

/*!
    \qmltype ImageButton
    \inherits Item
    \inqmlmodule com.pelagicore.widgets
    \brief ImageButton base type provides functionality common to buttons with images.

    ImageButton is the control for a button which requires text and image.
*/

ImageButton::~ImageButton()
{

}
/*!
    \qmlproperty string ImageButton::text

    This property holds a textual description of the button.
*/
QString ImageButton::text() const
{
    return m_text;
}

void ImageButton::setText(const QString &text)
{
    if (m_text != text) {
        m_text = text;
        emit textChanged();
    }
}
/*!
    \qmlproperty string ImageButton::imageSource

    This property holds the path to an image in addition to the text.
*/
QString ImageButton::imageSource() const
{
    return m_imageSource;
}

void ImageButton::setImageSource(const QString &imageSource)
{
    if (m_imageSource != imageSource) {
        m_imageSource = imageSource;
        emit imageSourceChanged();
    }
}
/*!
    \qmlproperty Item ImageButton::background

    This property holds the background item.

    \code
    ImageButton {
        id: control
        text: qsTr("Button")
        imageSource: "path/to/image"
        background: Rectangle {
            anchors.fill: parent
            color: "black"
        }
    }
    \endcode
*/
QQuickItem *ImageButton::background()
{
    return m_background;
}

void ImageButton::setBackground(QQuickItem *background)
{
    if (m_background != background) {
        m_background = background;
        m_background->setParentItem(this);
        m_background->setZ(-1);
        m_background->setWidth(width());
        m_background->setHeight(height());
        emit backgroundChanged();
    }
}

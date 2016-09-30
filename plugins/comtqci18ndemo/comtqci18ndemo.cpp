/****************************************************************************
**
** Copyright (C) 2016 The Qt Company
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

#include "comtqci18ndemo.h"
#include <QGuiApplication>
#include <QDebug>

ComTQCi18nDemo::ComTQCi18nDemo(QObject *parent)
    : QObject(parent),
      m_languageLocale(""),
      m_languageFilePath(""),
      m_languageFilePrefix("")
{
}

void ComTQCi18nDemo::setPrefix(QString languageFilePrefix)
{
    qDebug() << "File prefix: " << languageFilePrefix;

    m_languageFilePrefix = languageFilePrefix;
}

void ComTQCi18nDemo::setPath(QUrl languageFilePath)
{
    qDebug() << "File path: " << languageFilePath.toLocalFile();

    m_languageFilePath = languageFilePath.toLocalFile();
}

void ComTQCi18nDemo::setLanguageLocale(QString languageLocale)
{
    qDebug() << "Locale: " << languageLocale;

    if (m_languageLocale != languageLocale) {
        if ( loadTranslationFile(languageLocale) ) {
            m_languageLocale = languageLocale;

            emit languageLocaleChanged();
            emit languageChanged();
        }
    }
}

QString ComTQCi18nDemo::languageLocale() const
{
    return m_languageLocale;
}

QString ComTQCi18nDemo::emptyString() const
{
    return "";
}

bool ComTQCi18nDemo::loadTranslationFile(QString &langLocale)
{
    QString fileToLoad(m_languageFilePath + m_languageFilePrefix + "_");
    fileToLoad += langLocale + ".qm";

    qDebug() << "File to load: " << fileToLoad;

    if ( m_translator.load(fileToLoad) ) {
        qDebug() << "Translation file loaded";
        qApp->installTranslator(&m_translator);

        return true;
    }

    qDebug() << "Failed to load translation file";

    return false;
}

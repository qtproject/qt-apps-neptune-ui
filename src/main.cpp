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

#include <QtAppManCommon/global.h>
#include <QtAppManCommon/logging.h>
#include <QtAppManMain/main.h>
#include <QtAppManMain/defaultconfiguration.h>
#include <QtAppManPackage/package.h>
#include <QtAppManInstaller/sudo.h>
#include <QGuiApplication>

#ifdef NEPTUNE_ENABLE_TOUCH_EMULATION
#include "MouseTouchAdaptor.h"
#endif

QT_USE_NAMESPACE_AM

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationDisplayName(qSL("Neptune UI"));
    QGuiApplication::setApplicationVersion("0.1");

    Logging::initialize();

    Package::ensureCorrectLocale();

    QString error;
    if (Q_UNLIKELY(!forkSudoServer(DropPrivilegesPermanently, &error))) {
        qCCritical(LogSystem) << "ERROR:" << qPrintable(error);
        return 2;
    }

    try {
        setenv("QT_IM_MODULE", "qtvirtualkeyboard", 1);
        // this is needed for both WebEngine and Wayland Multi-screen rendering
        QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
#if !defined(QT_NO_SESSIONMANAGER)
        QGuiApplication::setFallbackSessionManagementEnabled(false);
#endif

        Main a(argc, argv);
        QStringList fileList;
        fileList.append(QStringLiteral("am-config.yaml"));

#ifdef NEPTUNE_ENABLE_TOUCH_EMULATION
        auto *mouseTouchAdaptor = MouseTouchAdaptor::instance();
#endif

        DefaultConfiguration cfg(fileList, "");
        cfg.parse();
        a.setup(&cfg);
        a.loadQml(cfg.loadDummyData());
        a.showWindow(cfg.fullscreen() && !cfg.noFullscreen());

        int result = MainBase::exec();

#ifdef NEPTUNE_ENABLE_TOUCH_EMULATION
        delete mouseTouchAdaptor;
#endif

        return result;
    } catch (const std::exception &e) {
        qCCritical(LogSystem) << "ERROR:" << e.what();
        return 2;
    }
}

#!/bin/sh
#****************************************************************************
#**
#** Copyright (C) 2016 The Qt Company.
#** Contact: https://www.qt.io/licensing/
#**
#** This file is part of the Neptune IVI UI.
#**
#** $QT_BEGIN_LICENSE:GPL-QTAS$
#** Commercial License Usage
#** Licensees holding valid commercial Qt Automotive Suite licenses may use
#** this file in accordance with the commercial license agreement provided
#** with the Software or, alternatively, in accordance with the terms
#** contained in a written agreement between you and The Qt Company.  For
#** licensing terms and conditions see https://www.qt.io/terms-conditions.
#** For further information use the contact form at https://www.qt.io/contact-us.
#**
#** GNU General Public License Usage
#** Alternatively, this file may be used under the terms of the GNU
#** General Public License version 3 or (at your option) any later version
#** approved by the KDE Free Qt Foundation. The licenses are as published by
#** the Free Software Foundation and appearing in the file LICENSE.GPL3
#** included in the packaging of this file. Please review the following
#** information to ensure the GNU General Public License requirements will
#** be met: https://www.gnu.org/licenses/gpl-3.0.html.
#**
#** $QT_END_LICENSE$
#**
#** SPDX-License-Identifier: GPL-3.0
#**
#****************************************************************************

QTBINPATH=~/Qt/5.7/gcc_64/bin
INPUTFILESPATH=".."

usageHelp()
{
    echo "$0"
    echo "\t-h --help                       : Show this display usage"
    echo "\t--qtdir=<path_to_qt_bin folder> : Sets path to lrelease executable"
    echo "\t                                  default value is $QTBINPATH"
    echo ""
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
#    echo "Param is " $PARAM
#    echo "Value is " $VALUE

    case $PARAM in
        -h | --help)
            usageHelp
            exit
            ;;
        --qtdir)
            QTBINPATH=$VALUE
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

# TODO: If you intend to support new language, create a file as "i18napp_<langCode>.ts"
langFileList=`ls *.ts`

# Name of the file shall match the pattern as, i18napp_<langCode>
# see the existing list above, de - german, ar - arabic, fr - french, etc.

# TODO: Change this to match the path on your machine, if you have to
translationCommand=$QTBINPATH/lrelease

if [ ! -f $translationCommand ];
then
    echo "Set correct path pointing to location where lrelease binary can be found"
    echo "Usually it is inside <QtInstallDir>/bin folder"
    echo "Uage help:"
    echo
    usageHelp
    exit
fi

echo
echo "List of languages translated to: " $langFileList
echo

echo
echo "Generating translation files"
for tsFileName in $langFileList; do
    $translationCommand -idbased $tsFileName -qm `basename -s .ts $tsFileName`.qm
done

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

#include "neptunestyle.h"
#include <QtQml/qqmlinfo.h>
#include <QtQuick/QQuickItem>
#include <QtQuick/QQuickWindow>
#include <QtGui/QGuiApplication>



class ThemeData
{
public:
    ThemeData() {}
    ThemeData(const QHash<NeptuneStyle::SystemColor, QColor>& newColors)
        : colors(newColors)
    {}

    QHash<NeptuneStyle::SystemColor, QColor> colors;
};




static QHash<NeptuneStyle::SystemColor, QColor>
GlobalLightColors {
                      {NeptuneStyle::DarkColor, QColor(0xFF1F1F1F)},
                      {NeptuneStyle::BrightColor, QColor(0xFFFEFEFE)},
                      {NeptuneStyle::AccentColor, QColor(0xFFF6A623)},
                      {NeptuneStyle::PositiveColor, QColor(0xFF50E3C2)},
                      {NeptuneStyle::NegativeColor, QColor(0xFF303030)}
                  };

static QHash<NeptuneStyle::SystemColor, QColor>
GlobalDarkColors {
                     {NeptuneStyle::DarkColor, QColor(0xFF1F1F1F)},
                     {NeptuneStyle::BrightColor, QColor(0xFFFEFEFE)},
                     {NeptuneStyle::AccentColor, QColor(0xFFF6A623)},
                     {NeptuneStyle::PositiveColor, QColor(0xFF50E3C2)},
                     {NeptuneStyle::NegativeColor, QColor(0xFF303030)}
                 };

//TODO: replace with typedef
static ThemeData GlobalDarkThemeData(GlobalDarkColors);
static ThemeData GlobalLightThemeData(GlobalLightColors);

static ThemeData& neptunestyle_theme_data(NeptuneStyle::Theme theme)
{
    return theme == NeptuneStyle::Dark? GlobalDarkThemeData : GlobalLightThemeData;
}


class StyleData {
public:
    StyleData()
        : font(QGuiApplication::font())
        , fontFactor(1.0)
        , theme(NeptuneStyle::Light)
        , windowSize(1920, 1080)
        , backgroundImage("background_1920x1080")
        , themeData(GlobalDarkThemeData)
    {
        compute();
    }
    StyleData(const StyleData &data)
        : font(data.font)
        , fontFactor(data.fontFactor)
        , theme(data.theme)
        , windowSize(data.windowSize)
        , backgroundImage(data.backgroundImage)
        , themeData(data.themeData)
    {
        compute();
    }

    void compute() {
        cell.setWidth(windowSize.width()/24);
        cell.setHeight(windowSize.height()/24);
        fontSizeXXS = font.pixelSize() * 0.4 * fontFactor;
        fontSizeXS = font.pixelSize() * 0.6 * fontFactor;
        fontSizeS = font.pixelSize() * 0.8 * fontFactor;
        fontSizeM = font.pixelSize() * 1.0 * fontFactor;
        fontSizeL = font.pixelSize() * 1.25 * fontFactor;
        fontSizeXL = font.pixelSize() * 1.5 * fontFactor;
        fontSizeXXL = font.pixelSize() * 1.75 * fontFactor;
    }

    QFont font;
    qreal fontFactor;
    NeptuneStyle::Theme theme;
    QSize windowSize;
    QString backgroundImage;
    QSize cell;
    int fontSizeXXS;
    int fontSizeXS;
    int fontSizeS;
    int fontSizeM;
    int fontSizeL;
    int fontSizeXL;
    int fontSizeXXL;
    ThemeData themeData;
};

static StyleData GlobalStyleData;


template <typename Enum>
static Enum toEnumValue(const QByteArray &data, Enum defaultValue)
{
    QMetaEnum enumeration = QMetaEnum::fromType<Enum>();
    bool ok;
    Enum value = static_cast<Enum>(enumeration.keyToValue(data, &ok));
    if (ok)
        return value;
    return defaultValue;
}

static int toInteger(const QByteArray &data, int defaultValue)
{
    bool ok;
    int value = data.toInt(&ok);
    if (ok)
        return value;
    return defaultValue;
}

static qreal toReal(const QByteArray &data, qreal defaultValue)
{
    bool ok;
    int value = data.toFloat(&ok);
    if (ok)
        return value;
    return defaultValue;
}

QString toString(const QByteArray& data, const QString& defaultValue)
{
    QString value = QString::fromLocal8Bit(data);
    if (value.isEmpty())
        return defaultValue;
    return value;
}

QColor toColor(const QByteArray& data, const QColor& defaultValue)
{
    QString value = QString::fromLocal8Bit(data);
    if (value.isEmpty())
        return defaultValue;
    QColor color(value);
    if (!color.isValid())
        qWarning() << "Invalid color: " << value;
    return color;
}

static QByteArray resolveSetting(const QSharedPointer<QSettings> &settings, const QString &name, const QByteArray &env=QByteArray())
{
    QByteArray value;
    if (!env.isNull())
        value = qgetenv(env);
    if (value.isNull() && !settings.isNull())
        value = settings->value(name).toByteArray();
    if (value.isEmpty())
        qWarning() << "NeptuneStyle settings value is empty: " << name;
    return value;
}

NeptuneStyle::NeptuneStyle(QObject *parent)
    : QQuickStyleAttached(parent)
    , m_data(new StyleData(GlobalStyleData))
{
    init();
}

NeptuneStyle::~NeptuneStyle()
{
}

NeptuneStyle *NeptuneStyle::qmlAttachedProperties(QObject *object)
{
    return new NeptuneStyle(object);
}


QColor NeptuneStyle::systemColor(SystemColor role) const
{
    return m_data->themeData.colors[role];
}

QColor NeptuneStyle::darkColor() const
{
    return systemColor(DarkColor);
}

QColor NeptuneStyle::brightColor() const
{
    return systemColor(BrightColor);
}

QColor NeptuneStyle::accentColor() const
{
    return systemColor(AccentColor);
}

QColor NeptuneStyle::positiveColor() const
{
    return systemColor(PositiveColor);
}

QColor NeptuneStyle::negativeColor() const
{
    return systemColor(NegativeColor);
}


QColor NeptuneStyle::lighter25(const QColor& color)
{
    return color.lighter(150);
}

QColor NeptuneStyle::lighter50(const QColor& color)
{
    return color.lighter(200);
}

QColor NeptuneStyle::lighter75(const QColor& color)
{
    return color.lighter(400);
}

QColor NeptuneStyle::darker25(const QColor& color)
{
    return color.darker(150);
}


QColor NeptuneStyle::darker50(const QColor& color)
{
    return color.darker(200);
}

QColor NeptuneStyle::darker75(const QColor& color)
{
    return color.darker(400);
}

qreal NeptuneStyle::cellWidth() const
{
    return m_data->cell.width();
}

qreal NeptuneStyle::cellHeight() const
{
    return m_data->cell.height();
}


int NeptuneStyle::fontSizeXXS() const
{
    return m_data->fontSizeXXS;
}

int NeptuneStyle::fontSizeXS() const
{
    return m_data->fontSizeXS;
}

int NeptuneStyle::fontSizeS() const
{
    return m_data->fontSizeS;
}

int NeptuneStyle::fontSizeM() const
{
    return m_data->fontSizeM;
}

int NeptuneStyle::fontSizeL() const
{
    return m_data->fontSizeL;
}

int NeptuneStyle::fontSizeXL() const
{
    return m_data->fontSizeXL;
}

int NeptuneStyle::fontSizeXXL() const
{
    return m_data->fontSizeXXL;
}

QString NeptuneStyle::backgroundImage() const
{
    return m_data->backgroundImage;
}

QString NeptuneStyle::fontFamily() const
{
    return m_data->font.family();
}

int NeptuneStyle::fontFactor() const
{
    return m_data->fontFactor;
}

qreal NeptuneStyle::windowWidth() const
{
    return m_data->windowSize.width();
}

qreal NeptuneStyle::windowHeight() const
{
    return m_data->windowSize.height();
}

void NeptuneStyle::init()
{
    static bool initialized = false;
    if (!initialized) {
        QSharedPointer<QSettings> settings = QQuickStyleAttached::settings(QStringLiteral("Neptune"));
        QByteArray data;

        data = resolveSetting(settings, "Theme");
        GlobalStyleData.theme = toEnumValue<Theme>(data, GlobalStyleData.theme);

        data = resolveSetting(settings, "FontSize");
        GlobalStyleData.font.setPixelSize(toInteger(data, GlobalStyleData.font.pixelSize()));

        data = resolveSetting(settings, "FontFactor");
        GlobalStyleData.fontFactor = toReal(data, GlobalStyleData.fontFactor);

        data = resolveSetting(settings, "FontFamily");
        GlobalStyleData.font.setFamily(toString(data, GlobalStyleData.font.family()));

        data = resolveSetting(settings, "WindowWidth");
        GlobalStyleData.windowSize.setWidth(toInteger(data, GlobalStyleData.windowSize.width()));

        data = resolveSetting(settings, "WindowHeight");
        GlobalStyleData.windowSize.setHeight(toInteger(data, GlobalStyleData.windowSize.height()));

        resolveGlobalThemeData(settings);
        GlobalStyleData.themeData = neptunestyle_theme_data(GlobalStyleData.theme);

        QGuiApplication::setFont(GlobalStyleData.font);
    }

    initialized = true;
    m_data.reset(new StyleData(GlobalStyleData));
    QQuickStyleAttached::init();
}

void NeptuneStyle::resolveGlobalThemeData(const QSharedPointer<QSettings> &settings)
{
    QMetaEnum themeEnumeration = QMetaEnum::fromType<Theme>();
    QMetaEnum enumeration = QMetaEnum::fromType<SystemColor>();

    for (int themeIndex=0; themeIndex<themeEnumeration.keyCount(); themeIndex++) {
        QByteArray themeKey(themeEnumeration.key(themeIndex));
        Theme themeValue = static_cast<Theme>(themeEnumeration.value(themeIndex));
        ThemeData& themeData = neptunestyle_theme_data(themeValue);

        for (int i=0; i<enumeration.keyCount(); i++) {
            SystemColor value = static_cast<SystemColor>(enumeration.value(i));
            QByteArray settingsKey = themeKey + '/' + QByteArray(enumeration.key(i));
            QByteArray data = resolveSetting(settings, settingsKey);
            QColor color = toColor(data, systemColor(value));
            themeData.colors.insert(value, color);
        }
    }
}

void NeptuneStyle::parentStyleChange(QQuickStyleAttached *newParent, QQuickStyleAttached *oldParent)
{
    Q_UNUSED(oldParent);
    NeptuneStyle* neptune = qobject_cast<NeptuneStyle *>(newParent);
    if (neptune)
        inheritStyle(*neptune->m_data);
}

void NeptuneStyle::inheritStyle(const StyleData& data)
{
    m_data.reset(new StyleData(data));
    propagateStyle(data);
    emit neptuneStyleChanged();
}

void NeptuneStyle::propagateStyle(const StyleData& data)
{
    const auto styles = childStyles();
    for (QQuickStyleAttached *child: styles) {
        NeptuneStyle* neptune = qobject_cast<NeptuneStyle *>(child);
        if (neptune)
            neptune->inheritStyle(data);
    }
}



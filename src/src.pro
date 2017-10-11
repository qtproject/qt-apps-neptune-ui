TEMPLATE = app
TARGET   = neptune-ui

include(../config.pri)

macos:CONFIG -= app_bundle
CONFIG *= no_private_qt_headers_warning

QT *= appman_main-private testlib

DEFINES *= NEPTUNE_VERSION=\\\"$$VERSION\\\"

SOURCES = main.cpp

unix:!macos: {
    CONFIG += link_pkgconfig
    PKGCONFIG += xcb x11 xi
    SOURCES += MouseTouchAdaptor.cpp
    HEADERS += MouseTouchAdaptor.h
    DEFINES += NEPTUNE_ENABLE_TOUCH_EMULATION
}

DESTDIR = $$OUT_PWD/../

target.path = $$INSTALL_PREFIX/neptune
INSTALLS += target

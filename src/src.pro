TEMPLATE = app
TARGET   = neptune-ui

include(../config.pri)

macos: {
    CONFIG -= app_bundle
}

QT = appman_main-private

SOURCES = main.cpp

DESTDIR = $$OUT_PWD/../

target.path = $$INSTALL_PREFIX/neptune
INSTALLS += target

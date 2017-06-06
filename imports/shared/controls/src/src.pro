TEMPLATE = lib
TARGET = qmlwidgets
QT += qml quick
CONFIG += qt plugin

uri = com.pelagicore.widgets
load(qmlplugin)

# Input
SOURCES += \
        plugin.cpp \
        imagebutton.cpp

HEADERS += \
        plugin.h \
        imagebutton.h

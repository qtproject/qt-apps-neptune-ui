TEMPLATE = lib
TARGET  = neptunestyle
QT += qml quick
QT += core-private gui-private qml-private quick-private quicktemplates2-private quickcontrols2-private
CONFIG += qt plugin c++11

uri = com.pelagicore.styles.neptune
load(qmlplugin)

SOURCES += \
    neptunestyle.cpp \
    neptunestyleplugin.cpp \
    neptunetheme.cpp

HEADERS += \
    neptunestyle.h \
    neptunestyleplugin.h \
    neptunetheme.h

RESOURCES += \
    neptunestyle.qrc



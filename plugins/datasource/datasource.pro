TEMPLATE = lib
TARGET = qmldatasources
QT += qml quick sql
CONFIG += qt plugin

uri = com.pelagicore.datasource
load(qmlplugin)

# Input
SOURCES += \
    logging.cpp \
    sqlquerydatasource.cpp \
    plugin.cpp \
    sqlquerymodel.cpp \
    sqltablemodel.cpp \
    sqltabledatasource.cpp

HEADERS += \
    logging.h \
    sqlquerydatasource.h \
    plugin.h \
    sqlquerymodel.h \
    sqltablemodel.h \
    sqltabledatasource.h

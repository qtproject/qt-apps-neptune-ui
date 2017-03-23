TEMPLATE = lib
TARGET  = screenmanagerplugin
QT += qml quick
CONFIG += qt plugin c++11

TARGET = $$qtLibraryTarget($$TARGET)
uri = com.pelagicore.ScreenManager

SOURCES += \
    plugin.cpp \
    screenmanager.cpp \

HEADERS += \
    screenmanager.h \

OTHER_FILES = qmldir

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$replace(OUT_PWD, /, $$QMAKE_DIR_SEP)$${QMAKE_DIR_SEP}qmldir
    copy_qmldir.depends = $$replace(_PRO_FILE_PWD_, /, $$QMAKE_DIR_SEP)$${QMAKE_DIR_SEP}qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$copy_qmldir.depends\" \"$$copy_qmldir.target\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

isEmpty(INSTALL_PREFIX) {
    INSTALL_PREFIX=/opt
}

qmldir.files = qmldir
installPath = $$INSTALL_PREFIX/neptune/imports/shared/$$replace(uri, \\., /)
qmldir.path = $$installPath
target.path = $$installPath
INSTALLS += target qmldir

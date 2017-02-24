TEMPLATE = lib
TARGET  = comtqci18ndemoplugin
QT += qml quick
CONFIG += qt plugin c++11

TARGET = $$qtLibraryTarget($$TARGET)
uri = com.theqtcompany.comtqci18ndemo

SOURCES += \
    plugin.cpp \
    comtqci18ndemo.cpp \

HEADERS += \
    comtqci18ndemo.h \

OTHER_FILES = qmldir

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
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

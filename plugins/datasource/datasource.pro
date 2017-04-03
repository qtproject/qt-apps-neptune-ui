TEMPLATE = lib
TARGET = qmldatasources
QT += qml quick sql
CONFIG += qt plugin

# Add a long padded rpath, so the installer can replace it with a relative rpath
QMAKE_RPATHDIR += "$$INSTALL_PREFIX/long_padding/long_padding/long_padding/long_padding/long_padding\
                   long_padding/long_padding/long_padding/long_padding/long_padding/long_padding/"

TARGET = $$qtLibraryTarget($$TARGET)
uri = com.pelagicore.datasource

# Input
SOURCES += \
    sqlquerydatasource.cpp \
    plugin.cpp \
    sqlquerymodel.cpp \
    sqltablemodel.cpp \
    sqltabledatasource.cpp

HEADERS += \
    sqlquerydatasource.h \
    plugin.h \
    sqlquerymodel.h \
    sqltablemodel.h \
    sqltabledatasource.h

OTHER_FILES = qmldir

isEmpty(INSTALL_PREFIX) {
    INSTALL_PREFIX=/opt
}

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$replace(OUT_PWD, /, $$QMAKE_DIR_SEP)$${QMAKE_DIR_SEP}qmldir
    copy_qmldir.depends = $$replace(_PRO_FILE_PWD_, /, $$QMAKE_DIR_SEP)$${QMAKE_DIR_SEP}qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$copy_qmldir.depends\" \"$$copy_qmldir.target\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir
installPath = $$INSTALL_PREFIX/neptune/imports/shared/$$replace(uri, \\., /)
qmldir.path = $$installPath
target.path = $$installPath
INSTALLS += target qmldir



include(doc/doc.pri)

TEMPLATE = subdirs

SUBDIRS = plugins/datasource \
          plugins/screenmanager \
          plugins/comtqci18ndemo

isEmpty(INSTALL_PREFIX) {
    INSTALL_PREFIX=/opt
}

qml.files = apps imports sysui i18n am-config.yaml Main*.qml
qml.path = $$INSTALL_PREFIX/neptune
INSTALLS += qml

OTHER_FILES += $$files($$PWD/*.qml, true)

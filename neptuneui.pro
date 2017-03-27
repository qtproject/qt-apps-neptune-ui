TEMPLATE = subdirs

SUBDIRS = plugins/datasource \
          plugins/screenmanager \
          plugins/comtqci18ndemo \
          doc

isEmpty(INSTALL_PREFIX) {
    INSTALL_PREFIX=/opt
}

qml.files = apps imports sysui am-config.yaml Main.qml
qml.path = $$INSTALL_PREFIX/neptune
INSTALLS += qml

OTHER_FILES += $$files($$PWD/*.qml, true)

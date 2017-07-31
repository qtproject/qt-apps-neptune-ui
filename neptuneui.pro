requires(linux:!android|win32-msvc2013:!winrt|win32-msvc2015:!winrt|osx|win32-g++*)

TEMPLATE = subdirs

include(config.pri)

SUBDIRS += plugins
SUBDIRS += doc
SUBDIRS += imports/shared/controls

# HACK: CI does not have appman in dependency list, which is why
# we are not building the executable to avoid failing integration tests.
qtHaveModule(appman_main-private) {
   message("Module appman_main-private found.")
   SUBDIRS += src
} else {
   message("Module appman_main-private not found. Custom executable won't be build.")
}

# Copy all QML files during the build time
copydata.commands = $(COPY_DIR) $$PWD/apps $$PWD/imports $$PWD/sysui $$PWD/styles $$PWD/am-config.yaml $$PWD/Main.qml $$OUT_PWD
first.depends = $(first) copydata
export(first.depends)
export(copydata.commands)
!equals(PWD, $$OUT_PWD): QMAKE_EXTRA_TARGETS += first copydata

# Install all required files
qml.files = apps imports sysui examples styles am-config.yaml Main.qml
qml.path = $$INSTALL_PREFIX/neptune
INSTALLS += qml

OTHER_FILES += $$files($$PWD/*.qml, true)
OTHER_FILES += $$PWD/plugins.yaml.in
PLUGINS_DIR = $$OUT_PWD/qml
QMAKE_SUBSTITUTES += $$PWD/plugins.yaml.in

requires(linux:!android|win32|osx)
requires(!winrt)

TEMPLATE = subdirs

include(config.pri)

SUBDIRS += plugins
SUBDIRS += doc

copydata.file = copydata.pro
copydata.depends = plugins

# HACK: CI does not have appman in dependency list, which is why
# we are not building the executable to avoid failing integration tests.

qtHaveModule(appman_main-private) {
    have_appman="found"
    SUBDIRS += src
    copydata.depends += src
} else {
    have_appman="not found (custom executable will not be built)")
}

log("$$escape_expand(\\n)Checking for QtApplicationManager: $$have_appman $$escape_expand(\\n\\n)")

SUBDIRS += copydata

# Install all required files
qml.files = apps imports sysui examples styles am-config.yaml Main.qml
qml.path = $$INSTALL_PREFIX/neptune
INSTALLS += qml

OTHER_FILES += $$files($$PWD/*.qml, true)
OTHER_FILES += $$PWD/plugins.yaml.in
PLUGINS_DIR = $$OUT_PWD/qml
QMAKE_SUBSTITUTES += $$PWD/plugins.yaml.in

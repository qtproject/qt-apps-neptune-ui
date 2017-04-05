TEMPLATE = lib
TARGET  = comtqci18ndemoplugin
QT += qml quick
CONFIG += qt plugin c++11

uri = com.theqtcompany.comtqci18ndemo
load(qmlplugin)

SOURCES += \
    plugin.cpp \
    comtqci18ndemo.cpp \

HEADERS += \
    comtqci18ndemo.h \

# var, prepend, append
defineReplace(prependAll) {
    for(a,$$1):result += $$2$${a}$$3
    return($$result)
}

qmlAppPath = $$PWD/../../apps/com.theqtcompany.i18ndemo
# See qml files to scan while running lupdate/lrelease
lupdate_only {
    SOURCES += $$files($$shell_quote($$shell_path($${qmlAppPath}/))*.qml, true)
}

target.path = $$installPath

supportedLocales = \
    ar_AR \
    de_DE \
    en_GB \
    fi_FI \
    fr_FR \
    ja_JP \
    ko_KR \
    ru_RU \
    zh_CN \
    zh_TW

TRANSLATIONS = $$prependAll(supportedLocales, $$qmlAppPath/translations/i18napp_, .ts)

qtPrepareTool(LUPDATE, lupdate)
qtPrepareTool(LRELEASE, lrelease)

ts.commands = $$LUPDATE $$shell_quote($$_PRO_FILE_)
QMAKE_EXTRA_TARGETS += ts

qm.input = TRANSLATIONS
qm.output = $$shadowed($$qmlAppPath/translations)/${QMAKE_FILE_BASE}.qm
qm.variable_out = PRE_TARGETDEPS
qm.commands = $${LRELEASE} -idbased ${QMAKE_FILE_IN} -qm ${QMAKE_FILE_OUT}
qm.name = LRELEASE ${QMAKE_FILE_IN}
qm.CONFIG += no_link
QMAKE_EXTRA_COMPILERS += qm

qmfiles.files = $$prependAll(supportedLocales, $$shadowed($$qmlAppPath/translations)/i18napp_, .qm)
qmfiles.path = $$INSTALL_PREFIX/neptune/apps/com.theqtcompany.i18ndemo/translations
qmfiles.CONFIG += no_check_exist

INSTALLS += qmfiles

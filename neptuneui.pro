TEMPLATE = subdirs

SUBDIRS = plugins/datasource \
          plugins/screenManager

qml.files = apps modules sysui i18n am-config.yaml Main*.qml

INSTALLS += qml

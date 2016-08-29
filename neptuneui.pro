TEMPLATE = subdirs

SUBDIRS = plugins/datasource \
          plugins/screenManager

qml.files = apps imports sysui i18n am-config.yaml Main*.qml

INSTALLS += qml

TEMPLATE = subdirs

SUBDIRS = plugins/datasource \
          plugins/screenManager \
          plugins/comtqci18ndemo

qml.files = apps imports sysui i18n am-config.yaml Main*.qml

INSTALLS += qml

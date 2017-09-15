TEMPLATE = aux

# Copy all QML files during the build time
copydata.commands = $(COPY_DIR) $$PWD/apps $$PWD/imports $$PWD/sysui $$PWD/styles $$PWD/am-config.yaml $$PWD/Main.qml $$OUT_PWD

first.depends = copydata
!equals(PWD, $$OUT_PWD):QMAKE_EXTRA_TARGETS += first copydata

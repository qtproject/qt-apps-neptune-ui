TEMPLATE = aux

# Copy all QML files during the build time
DIRECTORIES = examples apps imports sysui styles
FILES = am-config.yaml am-config-dev.yaml Main.qml

for (d , DIRECTORIES) {
    do_copydata.commands += $(COPY_DIR) $$shell_path($$PWD/$${d}) $$shell_path($$OUT_PWD/$${d}) $$escape_expand(\n\t)
}
for (f , FILES) {
    do_copydata.commands += $(COPY) $$shell_path($$PWD/$${f}) $$shell_path($$OUT_PWD/$${f}) $$escape_expand(\n\t)
}

first.depends = do_copydata
!equals(PWD, $$OUT_PWD):QMAKE_EXTRA_TARGETS += first do_copydata

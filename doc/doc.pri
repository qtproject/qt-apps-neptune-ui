isEmpty(VERSION): VERSION=1.0.0
build_online_docs: {
    QMAKE_DOCS = $$PWD/online/neptune-ui.qdocconf
} else {
    QMAKE_DOCS = $$PWD/neptune-ui.qdocconf
}

CONFIG += prepare_docs
load(qt_docs_targets)

OTHER_FILES += \
    $$PWD/*.qdocconf \
    $$PWD/src/*.qdoc \
    $$PWD/src/images/*.png

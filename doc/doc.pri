build_online_docs: {
    QMAKE_DOCS = $$PWD/online/neptuneui.qdocconf
} else {
    QMAKE_DOCS = $$PWD/neptuneui.qdocconf
}

DISTFILES += \
    $$PWD/neptuneui.qdocconf \
    $$PWD/online/neptuneui.qdocconf \
    $$PWD/src/neptuneui-index.qdoc \
    $$PWD/src/images/emulator-automotive.png \
    $$PWD/src/images/infotainment-cluster-apps.png \
    $$PWD/src/images/infotainment-cluster-carsettings.png \
    $$PWD/src/images/infotainment-cluster-mycar.png \
    $$PWD/src/images/infotainment-cluster-settings.png \
    $$PWD/src/images/infotainment-cluster.png

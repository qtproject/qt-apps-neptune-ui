# Prerequisite

Qt >= 5.6
QtIvi
Unix system
Application Manager

# Build and install neptune-ui

        $ qmake INSTALL_PREFIX=/path/to/install/folder && make && make install

This will install all qml files and plugins into the neptune subfolder of '/path/to/install/folder'. If INSTALL_PREFIX is not defined, then this will build all neptune-ui plugins and installs the complete neptune-ui to /opt/neptune folder.

The installation part is optional.

* (Optional) Run scripts within the plugins/scripts folder to scan the media on the system

# Run entire UI

Building Neptune will make 'neptune-ui' executable which will be then run:

        $ neptune-ui -r

To get more detailed log output, run:
        $ neptune-ui -r --verbose


# Run the UI without QtIVI

In case QtIVI is not installed, 'dummyimports' folder contains QML dummy implementation of QtIVI:

        $ QML2_IMPORT_PATH=/path/to/dummyimports neptune-ui -r


# Style Configuration

Neptune UI supports different style configurations which can be used to adapt the style to the needs of the Hardware the UI should be running on.
The following resolutions are available:

* 1920x1080 - default
* 1280x800
* 1080x1920
* 768x1024

To set the UI for wanted (other than default one) resolution, set the 'QT_QUICK_CONTROLS_CONF' to the location of QtQuickControls 2 configuration file. Configuration files are within 'styles' folder (https://doc.qt.io/qt-5/qtquickcontrols2-environment.html).

NOTE: You need to have Source Sans Pro font installed (see assets folder within the modules)

# Prerequisite

Qt >= 5.6
QtIvi
Unix system
Application Manager

# Build

* Build and install neptune-ui

        $ qmake INSTALL_PREFIX=$$PWD/install && make && make install

This will install all qml files and plugins into the neptune subfolder of $$PWD/install. If INSTALL_PREFIX is not defined, then this will build all neptune-ui plugins and installs the complete neptune-ui to /opt/neptune folder.

The installation part is optional.

* (Optional) Run scripts within the plugins/scripts folder to scan the media on the system

# Run entire UI with the Application Manager

        $ appman --recreate-database -c am-config.yaml -c <build-folder>/plugins.yaml -I dummyimports

# Run entire UI with the Application Manager including example applications
and support for debug wrappers

        $ appman --recreate-database -c am-config-dev.yaml <build-folder>/plugins.yaml -I dummyimports

In QtCreator you can use the following line :

        $ appman --recreate-database -c am-config-dev.yaml -c %{buildDir}/plugins.yaml -I dummyimports

# Run the UI with QtIVI installed

In case QtIVI is build and installed, 'dummyimports' are not needed.

        $ appman --recreate-database -c am-config.yaml -c <build-folder>/plugins.yaml


# Style Configuration

Neptune UI supports different style configurations which can be used to adapt the style to the needs of the Hardware the UI should be running on.
The following resolutions are available:

* 1920x1080 - default
* 1280x800
* 1080x1920
* 768x1024

To set the UI for wanted (other than default one) resolution, set the 'QT_QUICK_CONTROLS_CONF' to the location of QtQuickControls 2 configuration file. Configuration files are within 'styles' folder (https://doc.qt.io/qt-5/qtquickcontrols2-environment.html).

NOTE: You need to have Source Sans Pro font installed (see assets folder within the modules)

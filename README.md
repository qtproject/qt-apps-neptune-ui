# Prerequisite

Qt >= 5.6
QtIvi
Unix system
Application Manager

# Preparation

* You need to have Source Sans Pro font installed (see assets folder within the modules)

# Build

* Build and install neptune-ui

        $ qmake && make && make install

This will build all neptune-ui plugins and installs the complete neptune-ui to /opt/neptune
To define the install location of neptune you can use the INSTALL_PREFIX config variable:

        $ qmake INSTALL_PREFIX=$$PWD/install && make && make install

This will install all qml files and plugins into the neptune subfolder of $$PWD/install

* Run scripts within the plugins/scripts folder to scan the media on the system

# Run entire UI with the Application Manager

        $ appman --recreate-database -c am-config.yaml

# Run entire UI with the Application Manager including example applications
and debug wrappers
        $ appman --recreate-database -c am-config-dev.yaml

# Run the UI without QtIvi installed

It is possible to run the UI also without having QtIvi build and installed. For bugreports please make sure to have QtIvi installed.

        $ appman --recreate-database -c am-config.yaml -I dummyimports

# Development

As it is inconvenient to always run "make install" when working directly on the neptune-ui,
qmake is generating a plugins.yaml file which contains all the settings you need to run the
UI also without installation.

        $ appman --recreate-database -c am-config.yaml -c <build-folder>/plugins.yaml

In QtCreator you can use the following line:

        $ appman --recreate-database -c am-config.yaml -c %{buildDir}/plugins.yaml

# Style Configuration

Neptune UI supports different style configurations which can be used to adapt the style to the needs of the Hardware the UI should be running on.
The following resolutions are available:

* 1920x1080 - default
* 1280x800
* 1080x1920
* 768x1024

To set the UI for wanted (other than default one) resolution, set the 'QT_QUICK_CONTROLS_CONF' to the location of QtQuickControls 2 configuration file. Configuration files are within 'styles' folder (https://doc.qt.io/qt-5/qtquickcontrols2-environment.html).

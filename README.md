# Prerequisite

Qt >= 5.5
Unix system

# Folder Structure

* modules - QML modules and assets to be imported (e.g. import controls 1.0)
* boards - visual ui tests for easier development
* apps - container for the different applications used within the system UI
* plugins - QML and other plugins needed for fully functional UI (e.g. reading the media from database)

Please note that am-dummyimports - the Application Manager dummy imports for running within
qmlscene/qmllive - have been moved to the application-manager repository.


# Preparation

* You need to have Source Sans Pro font installed (see assets folder within the modules)

# Build

* Build datasource qml plugin

        $ cd plugins/datasource

        $ qmake && make && make install

* Run scripts within the plugins/scripts folder to scan the media on the system

# Run entire UI

        $ qmlscene -I modules/ -I /path/to/application-manager/dummyimports/ MainWithCluster.qml

or with the Application Manager

        $ appman --recreate-database -c $AM_CONFIG_FILE -c am-config.yaml

where `AM_CONFIG_FILE` is the path to the Application Manager `config.yaml` file (inside the template-opt folder within the Application Manager delivery). The default `config.yaml` points to the `/opt/am` folder. If that folder does not exists, make sure to update the config.yaml settings to the corresponding paths.

# Style Configuration

Neptune UI supports different styleConfigs which can be used to adapt the style to the needs of the Hardware the UI should be running on.
The following configurations are available:

* no config: The UI will use the original graphics and fonts and uses a resolution of 1280x800
* Config1920x1080: Same as no config but 1920x1080 will be used as the screen resolution and the UI elements will be scaled
* auto: The UI will use the current Screen resolution and tries to adapt the UI as much as possible

Which configuration should be used can be controlled using the styleConfig parameter in am-config.yaml. By default the "auto" configuration is used.
If the "auto" configuration doesn't work for a specific device a own configuration can be created by copying one of the existing configurations from modules/utils and place it somehwere on the filesystem.
The styleConfig parameter in am-config.yaml will be intepreted as file path to a QML file and if available this StyleConfig will be loaded.

# Media

To get the media used within the Music and Movie app, download the zipped file and place the media.db and media folder inside the home folder. The download link: https://seafile.pelagicore.net/f/3713457142/

# Common Terms Used In The Project

Common terms and their meaning is enumerated below:

* Display - The physical display's real estate

* Screen - A Screen is a part of the main navigation. For example the HomeScreen, CloudScreen and MusicScreen

* Control(s) - Controls are elements such as Button, Icon, Label and other _primitives_

* Twisted panel - A _twisted panel_ is the indicater for swipe navigation which are found to the left and right hand side of the _display_

* Board - A _Board_ is typically a self-hosted QML file which test a signel UI element. For example a ButtonBoard tests and shows the usage for a Button control

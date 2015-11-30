# Prerequisite

Qt >= 5.2 (development done with Qt 5.5)
Unix system

# Folder Structure

* modules - QML modules and assets to be imported (e.g. import controls 1.0)
* boards - visual ui tests for easier development
* apps - container for the different applications used within the system UI
* am-dummyimports - Application Manager dummy imports for running within qmlscene
* plugins - QML and other plugins needed for fully functional UI (e.g. reading the media from database)

# Preparation

* You need to have Source Sans Pro font installed (see assets folder within the modules)

# Build

build datasource qml plugin

* Run scripts within the plugins/scripts folder to scan the media on the system

    $ cd plugins/datasource
    $ qmake && make && make install

# Run

    $ qmlscene -I modules -I am-dummyimports MainXXXX.qml

or

    $ appman --recreate-database -c $AM_CONFIG_FILE -c am-config.yaml --verbose

where AM_CONFIG_FILE is path to the config.yaml file provided by the Application Manager


# Common Terms Used In The Project

Common terms and their meaning is enumerated below:

* Display - The physical display's real estate

* Screen - A Screen is a part of the main navigation. For example the HomeScreen, CloudScreen and MusicScreen

* Control(s) - Controls are elements such as Button, Icon, Label and other _primitives_

* Twisted panel - A _twisted panel_ is the indicater for swipe navigation which are found to the left and right hand side of the _display_

* Board - A _Board_ is typically a self-hosted QML file which test a signel UI element. For example a ButtonBoard tests and shows the usage for a Button control

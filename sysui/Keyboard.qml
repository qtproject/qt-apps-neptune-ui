import QtQuick 2.0

import QtQuick.Enterprise.VirtualKeyboard 1.3
import QtQuick.Enterprise.VirtualKeyboard.Settings 2.0

InputPanel {
    visible: active

    Component.onCompleted: {
        VirtualKeyboardSettings.styleName = "neptune"
    }
}


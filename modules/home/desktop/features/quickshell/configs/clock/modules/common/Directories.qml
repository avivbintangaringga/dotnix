pragma Singleton
import QtQuick
import Quickshell
import QtCore

Singleton {
    readonly property string config: StandardPaths.standardLocations(StandardPaths.ConfigLocation)[0]
    readonly property string shellConfig: config + "/quickshell-clock-example"
    readonly property string shellConfigName: "config.json"
    readonly property string shellConfigPath: shellConfig + "/" + shellConfigName

    Component.onCompleted: {
        Quickshell.execDetached(["mkdir", "-p", shellConfig])
    }
}
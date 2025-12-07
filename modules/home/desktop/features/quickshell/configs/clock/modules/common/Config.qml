pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.modules.common // Corrected import

Singleton {
    id: root
    property alias options: configOptionsJsonAdapter
    property bool ready: false

    FileView {
        id: configFileView
        path: Directories.shellConfigPath
        onLoaded: root.ready = true
        onLoadFailed: error => {
            if (error == FileViewError.FileNotFound) {
                writeAdapter(); // Create the file if it doesn't exist
            }
        }
        onAdapterUpdated: writeAdapter() // Save changes automatically

        JsonAdapter {
            id: configOptionsJsonAdapter
            property JsonObject clock: JsonObject {
                property bool manualPosition: false
                property real x: 0
                property real y: 0
            }
        }
    }
}
// quickshell/shell.qml

import QtQuick 2.15
import QtQuick.Layouts 1.15
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import "widgets"

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: clockWindow
            property var modelData
            screen: modelData

            property string currentWallpaperPath: ""
            property real autoClockX: screen.width / 2
            property real autoClockY: screen.height / 2
            property color dominantColor: "#FFFFFF"
            property bool isManuallyDragged: false

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            color: "transparent"
            // CRITICAL: Set mask to allow the clock widget to receive mouse input
            mask: Region {
                item: content
            }
            WlrLayershell.layer: WlrLayer.Bottom

            Timer {
                interval: 3000
                repeat: true
                running: true
                onTriggered: getWallpaperProc.running = true
                Component.onCompleted: triggered()
            }

            Process {
                id: getWallpaperProc
                command: ["dms", "ipc", "call", "wallpaper", "get"]
                stdout: StdioCollector {
                    onStreamFinished: {
                        const newPath = text.trim();
                        if (newPath && newPath !== "unknown request" && newPath !== clockWindow.currentWallpaperPath) {
                            console.log("Wallpaper changed to:", newPath);
                            clockWindow.currentWallpaperPath = newPath;
                            // Reset manual drag state when wallpaper changes
                            clockWindow.isManuallyDragged = false;
                            updateClockPosition();
                        }
                    }
                }
            }

            function updateClockPosition() {
                if (content.width <= 0 || content.height <= 0 || clockWindow.currentWallpaperPath === "") {
                    return;
                }

                console.log("Analyzing wallpaper for best clock position...");

                leastBusyRegionProc.exec([
                    Quickshell.shellPath("scripts/least-busy-region.sh"),
                    clockWindow.currentWallpaperPath,
                    "--width", Math.floor(content.width).toString(),
                    "--height", Math.floor(content.height).toString(),
                    "--screen-width", clockWindow.screen.width.toString(),
                    "--screen-height", clockWindow.screen.height.toString(),
                    "--top-padding", "20",
                    "--bottom-padding", "100",
                    "--horizontal-padding", "100"
                ]);
            }

            Process {
                id: leastBusyRegionProc
                stdout: StdioCollector {
                    onStreamFinished: {
                        if (text.trim() === "") return;
                        try {
                            const result = JSON.parse(text);
                            if (result.error) {
                                console.error("Script error:", result.error);
                                return;
                            }
                            console.log("Found least busy region:", JSON.stringify(result));
                            clockWindow.autoClockX = result.center_x;
                            clockWindow.autoClockY = result.center_y;
                            clockWindow.dominantColor = result.dominant_color;
                        } catch (e) {
                            console.error("Failed to parse region data:", e, text);
                        }
                    }
                }
            }

            // Function to sample color at current dragged position
            function sampleColorAtPosition() {
                if (clockWindow.currentWallpaperPath === "") return;

                // Calculate the center position of the widget in screen coordinates
                var centerX = content.x + content.width / 2;
                var centerY = content.y + content.height / 2;

                console.log("Sampling color at dragged position:", centerX, centerY);

                // Use the least-busy-region script but with specific position
                // We'll use padding=0 to just get color at this exact position
                colorSampleProc.exec([
                    Quickshell.shellPath("scripts/least-busy-region.sh"),
                    clockWindow.currentWallpaperPath,
                    "--width", Math.floor(content.width).toString(),
                    "--height", Math.floor(content.height).toString(),
                    "--screen-width", clockWindow.screen.width.toString(),
                    "--screen-height", clockWindow.screen.height.toString(),
                    "--top-padding", "0",
                    "--bottom-padding", "0",
                    "--horizontal-padding", "0",
                    "--stride", "1"
                ]);
            }

            Process {
                id: colorSampleProc
                stdout: StdioCollector {
                    onStreamFinished: {
                        if (text.trim() === "") return;
                        try {
                            const result = JSON.parse(text);
                            if (result.dominant_color) {
                                console.log("Sampled color at dragged position:", result.dominant_color);
                                clockWindow.dominantColor = result.dominant_color;
                            }
                        } catch (e) {
                            console.error("Failed to parse color sample:", e);
                        }
                    }
                }
            }

            Item {
                id: content
                width: clockWidget.implicitWidth
                height: clockWidget.implicitHeight

                // Calculate position: use current position when dragged, automatic otherwise
                x: {
                    var safetyMargin = 20;
                    if (clockWindow.isManuallyDragged) {
                        // Return current x (don't override while dragging)
                        return x;
                    } else {
                        // Use automatic position
                        var leftX = clockWindow.autoClockX - width / 2;
                        return Math.max(safetyMargin, Math.min(leftX, clockWindow.screen.width - width - safetyMargin));
                    }
                }

                y: {
                    var safetyMargin = 20;
                    if (clockWindow.isManuallyDragged) {
                        // Return current y (don't override while dragging)
                        return y;
                    } else {
                        // Use automatic position
                        var topY = clockWindow.autoClockY - height / 2;
                        return Math.max(safetyMargin, Math.min(topY, clockWindow.screen.height - height - safetyMargin));
                    }
                }

                // Animate only when not manually dragged
                Behavior on x {
                    enabled: !clockWindow.isManuallyDragged
                    NumberAnimation { duration: 800; easing.type: Easing.OutCubic }
                }
                Behavior on y {
                    enabled: !clockWindow.isManuallyDragged
                    NumberAnimation { duration: 800; easing.type: Easing.OutCubic }
                }

                // Trigger position update when size changes
                onWidthChanged: {
                    if (width > 0 && !clockWindow.isManuallyDragged) {
                        Qt.callLater(clockWindow.updateClockPosition);
                    }
                }

                // MouseArea for dragging
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.SizeAllCursor
                    drag.target: content
                    drag.axis: Drag.XAndYAxis
                    drag.minimumX: 20
                    drag.minimumY: 20
                    drag.maximumX: clockWindow.screen.width - content.width - 20
                    drag.maximumY: clockWindow.screen.height - content.height - 20

                    onPressed: {
                        console.log("Drag started at:", content.x, content.y);
                        clockWindow.isManuallyDragged = true;
                    }

                    onReleased: {
                        console.log("Drag ended at:", content.x, content.y);
                        // Sample color at new position after a short delay
                        Qt.callLater(clockWindow.sampleColorAtPosition);
                    }
                }

                Clock {
                    id: clockWidget
                    textColor: Qt.color(clockWindow.dominantColor).hslLightness > 0.5 ? "#1A1A1A" : "#ffffff"
                    shadowColor: Qt.color(clockWindow.dominantColor).hslLightness > 0.5 ? "#9fffffff" : "#98000000"
                }
            }
        }
    }
}

import Quickshell // for PanelWindow
import Quickshell.Io // Processes
import QtQuick // for Text

Variants {
  model: Quickshell.screens

  delegate: Component {
    PanelWindow {
      property var modelData

      screen: modelData

      anchors {
        bottom: true
        left: true
        right: true
      }

      implicitHeight: 30

      Text {
        id: clock // Reference id

        // center the bar in its parent component (the window)
        anchors.centerIn: parent

        Process {
          id: dateProc
          command: ["date"]
          running: true
          stdout: StdioCollector {
            onStreamFinished: clock.text = this.text
          }
        }

        Timer {
          interval: 1000
          running: true
          repeat: true
          onTriggered: dateProc.running = true
        }
      }
    }
  }
}
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Templates 6.2 as T


ApplicationWindow {
    visible: true
    width: 480
    height: 640
    title: qsTr("Start Me App")


    DialogConfig {
        id: dialogConfig
    }

    Formulario {
        anchors.fill: parent
    }
}

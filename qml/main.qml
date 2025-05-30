import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Templates 6.2 as T


ApplicationWindow {
    visible: true
    width: 480
    height: 640
    title: qsTr("Calculadora Panadería")


    DialogConfig {
        id: dialogConfig
    }

    FormularioPanaderia {
        anchors.fill: parent
    }
}

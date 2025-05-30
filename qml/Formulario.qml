import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    width: 480
    height: 640
    color: "#f5f5f5"  // fondo suave
    radius: 10

    property string productoSeleccionado: "Queque"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        anchors.topMargin: 20
        spacing: 15

        // --- Parte de selección y resultado ---

        // --- Resultado ---

        Rectangle {
            id: rectangle
            color: "#ffffff"
            radius: 8
            border.color: "#ccc"
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.preferredHeight: 360

            ColumnLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.margins: 15
                anchors.topMargin: 15
                anchors.bottomMargin: 15
                spacing: 10

                TextField {
                    id: harinaInput
                    height: 35
                    placeholderText: "Harina (g)"
                    Layout.fillWidth: true
                }

                TextField {
                    id: levaduraInput
                    height: 35
                    placeholderText: "Levadura (g)"
                    visible: productoSeleccionado === "Pan"
                    Layout.fillWidth: true
                }

                TextField {
                    id: mantecaInput
                    height: 35
                    placeholderText: "Manteca (g)"
                    visible: productoSeleccionado === "Pan" || productoSeleccionado === "Queque"
                    Layout.fillWidth: true
                }

                TextField {
                    id: salInput
                    height: 35
                    placeholderText: "Sal (g)"
                    visible: productoSeleccionado === "Pan"
                    Layout.fillWidth: true
                }

                TextField {
                    id: azucarInput
                    height: 35
                    placeholderText: "Azúcar (g)"
                    visible: productoSeleccionado === "Queque"
                    Layout.fillWidth: true
                }

                TextField {
                    id: huevosInput
                    height: 35
                    placeholderText: "Huevos (g)"
                    visible: productoSeleccionado === "Queque"
                    Layout.fillWidth: true
                }

                TextField {
                    id: aceiteInput
                    height: 35
                    placeholderText: "Aceite (g)"
                    visible: productoSeleccionado === "Queque"
                    Layout.fillWidth: true
                }
            }
        }

        // --- Ingredientes ---

        Rectangle {
            id: rectangle1
            height: 100
            color: "#ffffff"
            radius: 8
            border.color: "#cccccc"
            Layout.maximumHeight: 100
            Layout.preferredHeight: -1
            Layout.fillWidth: true
            Layout.fillHeight: false
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop

            Text {
                id: resultado
                text: ""
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                font.pixelSize: 16
                color: "#333"
                wrapMode: Text.WordWrap
                font.bold: true
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignLeft
            }
        }

        RowLayout {
            Layout.rightMargin: 0
            Layout.leftMargin: 0
            Layout.fillWidth: true
            spacing: 10

            TextField {
                id: huevosInput1
                height: 35
                visible: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                Layout.maximumHeight: 35
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.italic: false
                font.bold: false
                font.pointSize: 10
                placeholderText: "Cantidad Producida (kg)"
                Layout.fillWidth: true
            }

            TextField {
                id: huevosInput2
                height: 35
                visible: true
                layer.sourceRect.height: 5
                layer.sourceRect.y: 5
                layer.sourceRect.width: 5
                layer.sourceRect.x: 5
                Layout.leftMargin: 10
                Layout.maximumHeight: 35
                Layout.rightMargin: 10
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.italic: false
                font.bold: false
                font.pointSize: 10
                placeholderText: "Precio (Kg)"
                Layout.fillWidth: true
            }
        }

        RowLayout {
            spacing: 10
            ComboBox {
                id: selector1
                Layout.maximumHeight: 40
                onCurrentTextChanged: { productoSeleccionado = currentText }
                model: ["Pan", "Queque"]
                Layout.fillWidth: true
            }

            Button {
                text: "Calcular"
                onClicked: {
                    const harina = parseFloat(harinaInput.text) || 0;
                    const levadura = parseFloat(levaduraInput.text) || 0;
                    const manteca = parseFloat(mantecaInput.text) || 0;
                    const sal = parseFloat(salInput.text) || 0;
                    const azucar = parseFloat(azucarInput.text) || 0;
                    const huevos = parseFloat(huevosInput.text) || 0;
                    const aceite = parseFloat(aceiteInput.text) || 0;

                    const costoTotal = harina + levadura + manteca + sal + azucar + huevos + aceite;
                    resultado.text = "Costo total: $" + costoTotal.toFixed(2);
                }
                Layout.fillWidth: true
            }

            Button {
                text: "Establecer"
                onClicked: { dialogConfig.open() }
                Layout.fillWidth: true
            }
            Layout.fillWidth: true
        }

    }
}

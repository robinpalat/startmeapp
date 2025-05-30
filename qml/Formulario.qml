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
                spacing: 10

                TextField {
                    id: harinaInput
                    placeholderText: "Harina (g)"
                    Layout.fillWidth: true
                }

                TextField {
                    id: levaduraInput
                    placeholderText: "Levadura (g)"
                    visible: productoSeleccionado === "Pan"
                    Layout.fillWidth: true
                }

                TextField {
                    id: mantecaInput
                    placeholderText: "Manteca (g)"
                    visible: productoSeleccionado === "Pan" || productoSeleccionado === "Queque"
                    Layout.fillWidth: true
                }

                TextField {
                    id: salInput
                    placeholderText: "Sal (g)"
                    visible: productoSeleccionado === "Pan"
                    Layout.fillWidth: true
                }

                TextField {
                    id: azucarInput
                    placeholderText: "Azúcar (g)"
                    visible: productoSeleccionado === "Queque"
                    Layout.fillWidth: true
                }

                TextField {
                    id: huevosInput
                    placeholderText: "Huevos (g)"
                    visible: productoSeleccionado === "Queque"
                    Layout.fillWidth: true
                }

                TextField {
                    id: aceiteInput
                    placeholderText: "Aceite (g)"
                    visible: productoSeleccionado === "Queque"
                    Layout.fillWidth: true
                }
            }
        }

        // --- Ingredientes ---
        Text {
            id: resultado
            text: ""
            font.pixelSize: 16
            color: "#333"
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            ComboBox {
                id: selector
                model: ["Pan", "Queque"]
                Layout.fillWidth: true
                onCurrentTextChanged: productoSeleccionado = currentText
            }

            Button {
                text: "Calcular"
                Layout.fillWidth: true
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




            }

            Button {
                text: "Precios"
                Layout.fillWidth: true
                onClicked: dialogConfig.open()
            }
        }
    }
}

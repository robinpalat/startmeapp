import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog {
    id: configDialog
    title: "Precios de Insumos"
    modal: true
    standardButtons: Dialog.Save | Dialog.Cancel
    width: 400
    height: 600

    property var claves: [
        { label: "Harina", key: "harina" },
        { label: "Levadura", key: "levadura" },
        { label: "Manteca", key: "manteca" },
        { label: "Azúcar", key: "azucar" },
        { label: "Huevos", key: "huevos" },
        { label: "Aceite", key: "aceite" },
        { label: "Sal", key: "sal" },
        { label: "Manteca de Hoja", key: "manteca_hoja" },
        { label: "Crema Pastelera", key: "crema_pastelera" },
        { label: "Cacao", key: "cacao" },
        { label: "Polvos de Hornear", key: "polvos_hornear" },
        { label: "Membrillo", key: "membrillo" },
        { label: "Otros", key: "otros" },
        { label: "Gas", key: "gas" },
        { label: "Electricidad", key: "electricidad" },
        { label: "Empaque", key: "empaque" }
    ]

    ScrollView {
        anchors.fill: parent

        ColumnLayout {
            id: layout
            spacing: 10

            Repeater {
                model: claves
                delegate: RowLayout {
                    spacing: 10
                    Label {
                        text: modelData.label + ":"
                        Layout.preferredWidth: 150
                    }
                    TextField {
                        id: tf
                        objectName: modelData.key
                        text: "" // Inicialmente vacío
                        Layout.fillWidth: true
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                    }
                }
            }
        }
    }

    onAccepted: {
        for (let i = 0; i < layout.children.length; ++i) {
            const fila = layout.children[i];
            if (fila.children.length < 2) continue;
            const campo = fila.children[1];
            const valor = parseFloat(campo.text);
            if (!isNaN(valor)) {
                calculador.setPrecio(campo.objectName, valor);
            }
        }
        calculador.guardarPreciosEnJson(rutaJson);
    }

    onVisibleChanged: {
        if (visible) {
            console.log("Dialog abierto, cargando precios desde JSON...");
            calculador.cargarPreciosDesdeJson(rutaJson);

            // Espera un ciclo de eventos para asegurarse de que todo esté listo
            Qt.callLater(() => {
                for (let i = 0; i < layout.children.length; ++i) {
                    const fila = layout.children[i];
                    if (fila.children.length < 2) continue;
                    const campo = fila.children[1];
                    if (!campo.objectName) continue;

                    let valor = 0;
                    try {
                        valor = calculador.getPrecio(campo.objectName);
                    } catch (e) {
                        console.log("Error al obtener precio de:", campo.objectName, e);
                    }

                    campo.text = isNaN(valor) ? "0" : valor.toFixed(0);
                }
            });
        }
    }
}

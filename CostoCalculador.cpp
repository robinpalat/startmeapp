#include "CostoCalculador.h"
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QDebug>

// ------------------- Calculador -------------------

Calculador::Calculador(QObject *parent) : QObject(parent) {}

QVariantMap Calculador::precios() const {
    return m_precios;
}

void Calculador::setPrecio(const QString &clave, double valor) {
    m_precios[clave] = valor;
    emit preciosChanged();
}

double Calculador::getPrecio(const QString &clave) const {
    return m_precios.value(clave, 0.0).toDouble();
}

void Calculador::cargarPreciosDesdeJson(const QString &ruta) {

    QFile file(ruta);
    if (!file.exists()) {
        qWarning() << "Archivo no existe, creando archivo nuevo en:" << ruta;

        // Valores por defecto
        m_precios = {
            {"harina", 1200}, {"levadura", 1500}, {"manteca", 1800},
            {"azucar", 700}, {"huevos", 700}, {"aceite", 700},
            {"sal", 700}, {"manteca_hoja", 700}, {"crema_pastelera", 700},
            {"cacao", 700}, {"polvos_hornear", 700}, {"membrillo", 700},
            {"otros", 700}, {"gas", 900}, {"electricidad", 700},
            {"empaque", 700}
        };

        guardarPreciosEnJson(ruta);
        return;
    }


    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "No se pudo abrir el archivo para lectura:" << ruta;
        return;
    }

    QByteArray datos = file.readAll();
    file.close();

    QJsonParseError error;
    QJsonDocument doc = QJsonDocument::fromJson(datos, &error);
    if (error.error != QJsonParseError::NoError) {
        qWarning() << "Error al parsear el JSON:" << error.errorString();
        return;
    }

    if (!doc.isObject()) {
        qWarning() << "El JSON no contiene un objeto válido.";
        return;
    }

    m_precios = doc.object().toVariantMap();
    emit preciosChanged();
}

void Calculador::guardarPreciosEnJson(const QString &ruta) {
    QFile file(ruta);
    if (!file.open(QIODevice::WriteOnly)) {
        qWarning() << "No se pudo abrir el archivo para escritura:" << ruta;
        return;
    }

    QJsonObject obj = QJsonObject::fromVariantMap(m_precios);
    QJsonDocument doc(obj);
    file.write(doc.toJson(QJsonDocument::Indented));
    file.close();
}

// ------------------- CostoCalculador -------------------

double CostoCalculador::calcularCostoIngrediente(double cantidadGr, double precioPorKg) {
    return (cantidadGr / 1000.0) * precioPorKg;
}

double CostoCalculador::calcularPesoNeto(double h, double a, double m, double h2, double l, double l2, double ac, double s, double e, double c) {
    return h + a + m + h2 + l + l2 + ac + s + e + c;
}

double CostoCalculador::calcularCostoTotal(double c1, double c2, double c3, double c4, double c5,
                                           double c6, double c7, double c8, double c9, double c10) {
    return c1 + c2 + c3 + c4 + c5 + c6 + c7 + c8 + c9 + c10;
}

double CostoCalculador::calcularCostoUnitario(double costoTotal, double pesoNeto, double pesoUnidad) {
    if (pesoUnidad == 0) return 0;
    double cantidadUnidades = pesoNeto / pesoUnidad;
    return costoTotal / cantidadUnidades;
}

double CostoCalculador::calcularGananciaPorUnidad(double precioVenta, double costoUnitario) {
    return precioVenta - costoUnitario;
}

double CostoCalculador::calcularGananciaTotal(double gananciaUnidad, double cantidadUnidades) {
    return gananciaUnidad * cantidadUnidades;
}

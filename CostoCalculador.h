#ifndef COSTOCALCULADOR_H
#define COSTOCALCULADOR_H

#include <QObject>
#include <QVariantMap>

class Calculador : public QObject {
    Q_OBJECT
    Q_PROPERTY(QVariantMap precios READ precios NOTIFY preciosChanged)

public:
    explicit Calculador(QObject *parent = nullptr);

    QVariantMap precios() const;
    Q_INVOKABLE void setPrecio(const QString &clave, double valor);
    Q_INVOKABLE double getPrecio(const QString &clave) const;

    Q_INVOKABLE void cargarPreciosDesdeJson(const QString &ruta);
    Q_INVOKABLE void guardarPreciosEnJson(const QString &ruta);

signals:
    void preciosChanged();

private:
    QVariantMap m_precios;
};

class CostoCalculador : public QObject {
    Q_OBJECT

public:
    explicit CostoCalculador(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE double calcularCostoIngrediente(double cantidadGr, double precioPorKg);
    Q_INVOKABLE double calcularPesoNeto(double h, double a, double m, double h2, double l, double l2, double ac, double s, double e, double c);
    Q_INVOKABLE double calcularCostoTotal(double c1, double c2, double c3, double c4, double c5,
                                          double c6, double c7, double c8, double c9, double c10);
    Q_INVOKABLE double calcularCostoUnitario(double costoTotal, double pesoNeto, double pesoUnidad);
    Q_INVOKABLE double calcularGananciaPorUnidad(double precioVenta, double costoUnitario);
    Q_INVOKABLE double calcularGananciaTotal(double gananciaUnidad, double cantidadUnidades);
};

#endif // COSTOCALCULADOR_H

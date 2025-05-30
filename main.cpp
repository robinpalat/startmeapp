#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "CostoCalculador.h"

#include <QIcon>
#include <QDir>
#include <QStandardPaths>

#include <QtQuickControls2/QQuickStyle>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QIcon appIcon(":/qml/assets/icono.png");
    app.setWindowIcon(appIcon);

    QQuickStyle::setStyle("Material");



    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/qml/main.qml"_s);

    QString dataPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/precios.json";
    QDir().mkpath(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation));
    engine.rootContext()->setContextProperty("rutaJson", dataPath);

    // Crear instancia del calculador correctamente

    Calculador calculador;
    CostoCalculador costoCalculador;



    engine.rootContext()->setContextProperty("calculador", &calculador);
    engine.rootContext()->setContextProperty("costoCalculador", &costoCalculador);


    calculador.cargarPreciosDesdeJson(dataPath);

    // Manejo de errores de carga de QML
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}

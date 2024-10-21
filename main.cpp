#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Parser.h"
#include "ModbusClient.h"
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<Parser>("Parser", 1, 0, "Parser");
    QQmlApplicationEngine engine;
    Parser *parser = new Parser();
    ModbusClient *client = new ModbusClient();
    QObject::connect(parser, &Parser::sendCoords, client, &ModbusClient::sendValues);
    engine.rootContext()->setContextProperty("parser", parser);
    engine.rootContext()->setContextProperty("client", client);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

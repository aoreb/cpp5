#ifndef MODBUSCLIENT_H
#define MODBUSCLIENT_H

#include <QObject>
#include <QModbusTcpClient>
#include <QModbusDataUnit>
#include <QDebug>
#include <cstring>

class ModbusClient : public QObject
{
    Q_OBJECT
private:
    QModbusTcpClient *modbusClient;
    void readInputRegisters(int address, int count);
public:
    explicit ModbusClient(QObject *parent = nullptr);
    void printServerPoints(QVector<double> values);

signals:
    void sendServerCoords(double x1, double y1, double x2, double y2);
public slots:
    void sendValues(double value1, double value2, double value3, double value4);
};

#endif // MODBUSCLIENT_H

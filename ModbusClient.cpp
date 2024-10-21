#include "ModbusClient.h"

ModbusClient::ModbusClient(QObject *parent) : QObject(parent)
{
    modbusClient = new QModbusTcpClient(this);
            modbusClient->setConnectionParameter(QModbusDevice::NetworkAddressParameter, "127.0.0.1");
            modbusClient->setConnectionParameter(QModbusDevice::NetworkPortParameter, 502);
            if (!modbusClient->connectDevice()) {
                        qFatal("Unable to connect to Modbus server: %s", qPrintable(modbusClient->errorString()));
                    }

}

void ModbusClient::sendValues(double value1, double value2, double value3, double value4) {
    quint64 value64_1, value64_2, value64_3, value64_4;

        memcpy(&value64_1, &value1, sizeof(value1));
        memcpy(&value64_2, &value2, sizeof(value2));
        memcpy(&value64_3, &value3, sizeof(value3));
        memcpy(&value64_4, &value4, sizeof(value4));

        QVector<quint16> values = {
            static_cast<quint16>(value64_1 & 0xFFFF), static_cast<quint16>((value64_1 >> 16) & 0xFFFF),
            static_cast<quint16>((value64_1 >> 32) & 0xFFFF), static_cast<quint16>((value64_1 >> 48) & 0xFFFF),

            static_cast<quint16>(value64_2 & 0xFFFF), static_cast<quint16>((value64_2 >> 16) & 0xFFFF),
            static_cast<quint16>((value64_2 >> 32) & 0xFFFF), static_cast<quint16>((value64_2 >> 48) & 0xFFFF),

            static_cast<quint16>(value64_3 & 0xFFFF), static_cast<quint16>((value64_3 >> 16) & 0xFFFF),
            static_cast<quint16>((value64_3 >> 32) & 0xFFFF), static_cast<quint16>((value64_3 >> 48) & 0xFFFF),

            static_cast<quint16>(value64_4 & 0xFFFF), static_cast<quint16>((value64_4 >> 16) & 0xFFFF),
            static_cast<quint16>((value64_4 >> 32) & 0xFFFF), static_cast<quint16>((value64_4 >> 48) & 0xFFFF)
        };


     QModbusDataUnit writeUnit(QModbusDataUnit::HoldingRegisters, 0, values.size());
        writeUnit.setValues(values);

        QModbusReply *reply = modbusClient->sendWriteRequest(writeUnit, 1);
        if (!reply) {
               qDebug() << "Send failed:" << modbusClient->errorString();
               return;
           }

        connect(reply, &QModbusReply::finished, this, [reply, values]() {
               if (reply->error() == QModbusDevice::NoError) {

               } else {

                   qDebug() << "Error sending values:" << reply->errorString() << reply->rawResult().exceptionCode() << reply->error();
               }
               reply->deleteLater();
        });
        readInputRegisters(0, 16);



}

void ModbusClient::readInputRegisters(int address, int count) {
    QModbusDataUnit readUnit(QModbusDataUnit::InputRegisters, address, count);
    QModbusReply *reply = modbusClient->sendReadRequest(readUnit, 1);
 if (!reply) {
        qDebug() << "Read failed:" << modbusClient->errorString();
        return;
    }

    connect(reply, &QModbusReply::finished, this, [reply, this]() {
        if (reply->error() == QModbusDevice::NoError) {
            QModbusDataUnit data = reply->result();
            QVector<quint16> values = data.values();
            QVector<double> valuesBack;
            quint64 value64[4];
            for (int i = 0; i < 4; ++i) {
                double tempValue;
                value64[i] = (static_cast<quint64>(values[i * 4]) |
                              (static_cast<quint64>(values[i * 4 + 1]) << 16) |
                              (static_cast<quint64>(values[i * 4 + 2]) << 32) |
                              (static_cast<quint64>(values[i * 4 + 3]) << 48));
                memcpy(&tempValue, &value64[i], sizeof(double));
                valuesBack.push_back(tempValue);
            }
            printServerPoints(valuesBack);


        } else {
            qDebug() << "Error reading Input Registers:" << reply->errorString() << reply->rawResult().exceptionCode() << reply->error();
        }
        reply->deleteLater();

    });
}

void ModbusClient::printServerPoints(QVector<double> values){
    emit sendServerCoords(values[0], values[1], values[2], values[3]);
}

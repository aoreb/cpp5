#ifndef PARSER_H
#define PARSER_H
#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <sstream>
#include <cmath>
#include "Manipulator.h"
#include "Point.h"
#include <QObject>
#include <QtCore/QThread>
#include <QTimer>

class Parser : public QObject
{
    Q_OBJECT
private:
    bool isInitialized = false;
    QTimer *timer_;
    QString m_value;
    Point basicO1;
    Point basicO2;
    Manipulator M1;
    Manipulator M2;
    void start(Manipulator& m1, Manipulator& m2);
    double dist(const Manipulator& M, const Point& p);
    void printPoints (Manipulator& m1, Manipulator& m2, std::string& strm1, std::string& strm2);
public:
    explicit Parser(QObject *parent = nullptr);
     Q_INVOKABLE void coords();

signals:
    void sendCoords(double x1, double y1, double x2, double y2);
public slots:
    void resetBasic();
    void writeValue(const QString& X1, const QString& Y1, const QString& R1, const QString& X2, const QString& Y2, const QString& R2);
};

#endif // PARSER_H

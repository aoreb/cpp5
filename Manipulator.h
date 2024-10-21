#ifndef MANIPULATOR_H
#define MANIPULATOR_H
#include "Point.h"
#include <QObject>

class Manipulator : public QObject
{
    Q_OBJECT
private:
    double R;
    Point O;

public:
    explicit Manipulator(QObject *parent = nullptr);
    Manipulator(double x, double y, double r);
    double GetX() const;
    double GetY() const;
    Point GetO();
    double GetR() const;
    void SetX(double x);
    void SetY(double y);
    void SetR(double r);
    void SetAll(double x, double y, double r);
signals:

public slots:
};

#endif // MANIPULATOR_H

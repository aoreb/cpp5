#include "Parser.h"
#include <QDebug>
#include <QEventLoop>

Parser::Parser(QObject *parent) : QObject(parent), timer_(new QTimer(this)) {
}
void Parser::writeValue(const QString& X1, const QString& Y1, const QString& R1, const QString& X2, const QString& Y2, const QString& R2)
{
    if(!isInitialized){

        basicO1 = {X1.toDouble(), Y1.toDouble()};
        basicO2 = {X2.toDouble(), Y2.toDouble()};
        isInitialized = true;
        M1.SetAll(basicO1.X, basicO1.Y, R1.toDouble());
        M2.SetAll(basicO2.X, basicO2.Y, R2.toDouble());
        start(M1, M2);

    } else if ((M1.GetR()!= R1.toDouble() || M2.GetR()!= R2.toDouble())
               && basicO1.X == X1.toDouble() && basicO1.Y == Y1.toDouble()
               && basicO2.X == X2.toDouble() && basicO2.Y == Y2.toDouble()) {
        M1.SetR(R1.toDouble());
        M2.SetR(R2.toDouble());
        start(M1, M2);
    }
    else if (M1.GetR() == R1.toDouble() && M2.GetR() == R2.toDouble()
             && basicO1.X == X1.toDouble() && basicO1.Y == Y1.toDouble()
             && basicO2.X == X2.toDouble() && basicO2.Y == Y2.toDouble()){
        start(M1, M2);
    }
    else {
        basicO1 = {X1.toDouble(), Y1.toDouble()};
        basicO2 = {X2.toDouble(), Y2.toDouble()};
        M1.SetAll(basicO1.X, basicO1.Y, R1.toDouble());
        M2.SetAll(basicO2.X, basicO2.Y, R2.toDouble());
        start(M1, M2);
    }



}
void Parser::coords() {
    emit sendCoords(M1.GetX(), M1.GetY(), M2.GetX(), M2.GetY());
}
void Parser::resetBasic(){
    if(!isInitialized){

    }
    else {
        M1.SetX(this->basicO1.X);
        M1.SetY(this->basicO1.Y);
        M2.SetX(this->basicO2.X);
        M2.SetY(this->basicO2.Y);
        coords();
    }
}
double Parser::dist(const Manipulator& M, const Point& p) {
    double x1 = M.GetX();
    double y1 = M.GetY();
    double x2 = p.X;
    double y2 = p.Y;
    return sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
}

void Parser::printPoints (Manipulator& m1, Manipulator& m2, std::string& strm1, std::string& strm2){
    std::ostringstream ss;
    ss.str("");
    ss << "{" << m1.GetX() << ", " << m1.GetY() << "} ";
    strm1 += ss.str();
    ss.str("");
    ss << "{" << m2.GetX() << ", " << m2.GetY() << "} ";
    strm2 += ss.str();
}
void Parser::start(Manipulator& m1, Manipulator& m2) {

    std::string path = "points.txt";
    std::ifstream fin;
    fin.open(path);
    std::string str = "";
    double x, y;
    char comma;
    if (!fin.is_open()){
         std::cout << "File not open" << std::endl;
    }
    std::vector<Point> points;
        while (!fin.eof()) {

            getline(fin, str, '}');
            if (!str.empty())
            {
            coords();
            QEventLoop loop;
            QTimer::singleShot(3000, &loop, SLOT(quit()));
            loop.exec();
            str += '}';
            size_t start = str.find('{') + 1;
            size_t end = str.find('}');
            size_t size = end - start;
            str = str.substr(start, size);
            std::istringstream iss(str);
            iss  >> x >> comma >> y;
            points.push_back({x,y});
            if (dist(m1, points.back()) <= m1.GetR() && dist(m2, points.back()) <= m2.GetR()) {

                if(dist(m1, points.back()) > dist(m2, points.back())) {
                       m2.SetX(points.back().X);
                       m2.SetY(points.back().Y);
                }
                else {
                        M1.SetX(points.back().X);
                        M1.SetY(points.back().Y);
                }

            } else if (dist(m1, points.back()) <= m1.GetR()) {
                m1.SetX(points.back().X);
                m1.SetY(points.back().Y);

            } else if (dist(m2, points.back()) <= m2.GetR()) {
                m2.SetX(points.back().X);
                m2.SetY(points.back().Y);
            }

            }


        }
     fin.close();
    }


#ifndef PATH_H
#define PATH_H
#include <QList>
class Path{
public:
    int len;
    QList<QString> path;
    Path(){
        len=0;
    }
};
#endif // PATH_H

#ifndef SPEAKITEM_H
#define SPEAKITEM_H

#include <QObject>
#include <QTextToSpeech>

class SpeakItem : public QObject
{
    Q_OBJECT
public:
    explicit SpeakItem(QObject *parent = nullptr);

signals:

public slots:
    void speak(QString input);
private:
    QTextToSpeech speakItem;
};

#endif // SPEAKITEM_H

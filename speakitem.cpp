#include "speakitem.h"

SpeakItem::SpeakItem(QObject *parent) : QObject(parent){
    speakItem.setLocale(QLocale::Chinese);
}

void SpeakItem::speak(QString input){
    speakItem.say(input);
}

#ifndef TERMOSTAT_H
#define TERMOSTAT_H

#include <QObject>
#include <QTimer>
#include <QQmlEngine>  // Required for QML_ELEMENT and QML_SINGLETON

class Thermostat : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(int currentTemp READ currentTemp WRITE setCurrentTemp NOTIFY currentTempChanged)
    Q_PROPERTY(int targetTemp READ targetTemp WRITE setTargetTemp NOTIFY targetTempChanged)

public:
    explicit Thermostat(QObject *parent = nullptr);

    int currentTemp() const;
    void setCurrentTemp(int value);

    int targetTemp() const;
    void setTargetTemp(int value);

signals:
    void currentTempChanged();
    void targetTempChanged();
private slots:
    void simulateHeating();
private:
      int m_currentTemp= 20;
      int m_targetTemp= 20;
      QTimer m_timer;
};

#endif // TERMOSTAT_H

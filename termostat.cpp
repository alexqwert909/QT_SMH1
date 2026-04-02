#include "termostat.h"

Thermostat::Thermostat(QObject *parent)
    : QObject{parent}
{
    connect(&m_timer, &QTimer::timeout, this, &Thermostat::simulateHeating);
    m_timer.start(1000);  // Simulate heating every 1 second
}

int Thermostat::currentTemp() const {
    return m_currentTemp;
}

void Thermostat::setCurrentTemp(int value) {
    if (m_currentTemp != value) {
        m_currentTemp = value;
        emit currentTempChanged();
    }
}

int Thermostat::targetTemp() const {
    return m_targetTemp;
}

void Thermostat::setTargetTemp(int value) {
    if (m_targetTemp != value) {
        m_targetTemp = value;
        emit targetTempChanged();
    }
}

void Thermostat::simulateHeating() {
    if (m_currentTemp < m_targetTemp) {
        m_currentTemp++;
        emit currentTempChanged();
    } else if (m_currentTemp > m_targetTemp) {
        m_currentTemp--;
        emit currentTempChanged();
    }
}

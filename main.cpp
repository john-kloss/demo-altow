#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "patientList/patientlist.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<PatientList>("Medical", 1, 0, "PatientListModel");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("demo_altow", "Main");

    return app.exec();
}

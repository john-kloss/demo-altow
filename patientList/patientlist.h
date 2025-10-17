// patientlist.h
#pragma once

#include <QAbstractItemModel>
#include <QString>
#include <QVector>

struct Patient {
    int id;
    QString name;
    int age;
    QString status;
};

class PatientList : public QAbstractItemModel {
    Q_OBJECT
    // QML_ELEMENT

public:
    explicit PatientList(QObject* parent = nullptr);

    enum PatientRoles {
      NameRole,
      AgeRole,
      StatusRole
    };

    QModelIndex index(int row, int column, const QModelIndex& parent = QModelIndex()) const override;
    QModelIndex parent(const QModelIndex& index) const override;
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    int columnCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    Qt::ItemFlags flags(const QModelIndex& index) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addPatient(const QString& name, int age, const QString& status) noexcept;
    Q_INVOKABLE void removePatient(int row);

private:
    QVector<Patient> m_patients;
};

// patientlist.cpp
#include "patientlist.h"

PatientList::PatientList(QObject* parent)
: QAbstractItemModel(parent) {
    addPatient("Sophia Wber", 12, "Abgeschlossen");
    addPatient("Lisa Hahn", 2, "Geplant");
    addPatient("Lothar Beck", 8, "Abgeschlossen");
}

QModelIndex PatientList::index(int row, int column, const QModelIndex& parent) const {
    if (parent.isValid() || row < 0 || row >= m_patients.size()){
      return QModelIndex();
    }
    return createIndex(row, column);
}

QModelIndex PatientList::parent(const QModelIndex&) const {
    return QModelIndex(); // Flat list — no parent-child hierarchy
}

int PatientList::rowCount(const QModelIndex& parent) const {
    return m_patients.size();
}

int PatientList::columnCount(const QModelIndex&) const {
    return 1;
}

QVariant PatientList::data(const QModelIndex& index, int role) const {
    if (!index.isValid()) {
        return QVariant();
    }

    const auto& patient = m_patients.at(index.row());
    switch (role) {
      case PatientRoles::NameRole: return patient.name;
      case PatientRoles::AgeRole: return patient.age;
      case PatientRoles::StatusRole: return patient.status;
      default: return QVariant();
    }
}

QVariant PatientList::headerData(int section, Qt::Orientation orientation, int role) const {
    if (role != Qt::DisplayRole || orientation != Qt::Horizontal)
        return QVariant();

    switch (section) {
      case PatientRoles::NameRole: return QString("name");
      case PatientRoles::AgeRole: return QString("age");
      case PatientRoles::StatusRole: return QString("Status");
      default: return QVariant();
    }
}

Qt::ItemFlags PatientList::flags(const QModelIndex& index) const {
    if (!index.isValid()) {
      return Qt::NoItemFlags;
    }
    return Qt::ItemIsSelectable | Qt::ItemIsEnabled;
}

void PatientList::addPatient(const QString& name, int age, const QString& status) noexcept { 
    beginInsertRows(QModelIndex(), m_patients.size(), m_patients.size());
    Patient newPatient{name: name, age: age, status: status};
    m_patients.append(newPatient);
    qDebug() << newPatient.status;
    endInsertRows();
}

void PatientList::removePatient(int row) {
    if (row < 0 || row >= m_patients.size()) {
        return;
    }
    beginRemoveRows(QModelIndex(), row, row);
    m_patients.removeAt(row);
    endRemoveRows();
}

QHash<int, QByteArray> PatientList::roleNames() const 
{
  QHash<int, QByteArray> roleNames;
  roleNames.insert(PatientRoles::NameRole, "name"); 
  roleNames.insert(PatientRoles::AgeRole, "age"); 
  roleNames.insert(PatientRoles::StatusRole, "status"); 
  return roleNames;
};

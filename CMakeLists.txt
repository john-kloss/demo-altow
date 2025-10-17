cmake_minimum_required(VERSION 3.16)

project(demo_altow VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Core Gui)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appdemo_altow
    main.cpp
    patientList/patientlist.h
    patientList/patientlist.cpp
)

qt_add_qml_module(appdemo_altow
    URI demo_altow
    VERSION 1.0
    QML_FILES
        Main.qml
        StatusBar.qml
        patientList/PatientList.qml
        patientList/PatientDelegate.qml
        scan/ScanView.qml
        scan/SequenceModel.qml
        scan/SequenceDelegate.qml
)

qt_add_resources(appdemo_altow "resources"
    PREFIX "/"
    FILES
        resources/loading.json
        resources/success.json
        resources/upload.json
        resources/play.json

        resources/delete.svg
        resources/upload.svg
        resources/add.svg
        resources/add-image.svg
        resources/back.svg
        resources/play.svg
        resources/pause.svg
        resources/settings.svg

        resources/head-0.jpg
        resources/head-1.jpg
        resources/head-2.jpg
)

set_target_properties(appdemo_altow PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appdemo_altow
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appdemo_altow
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

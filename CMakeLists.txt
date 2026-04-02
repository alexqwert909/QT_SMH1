cmake_minimum_required(VERSION 3.16)

project(SMH1 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appSMH1
    main.cpp
    termostat.h
    termostat.cpp
)

qt_add_qml_module(appSMH1
    URI SMH1
    QML_FILES
        Main.qml
        QML_FILES mainPage.qml
    RESOURCES
            images/light_bulb.svg
            images/home.png
            images/home.svg
            QML_FILES roomPage.qml
            QML_FILES lightsPage.qml
            QML_FILES temperaturePage.qml
            QML_FILES
            QML_FILES sensorPage.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appSMH1 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appSMH1
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appSMH1
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appSMH1
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

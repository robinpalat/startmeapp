cmake_minimum_required(VERSION 3.16)
project(startmeapp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS
    Core
    Gui
    Qml
    Quick
    QuickControls2
)

# Configuración para manejar interfaces y recursos
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)


qt_add_resources(RESOURCES resources.qrc)

qt_standard_project_setup()

qt_add_executable(startmeapp
    main.cpp
    CostoCalculador.cpp
    CostoCalculador.h
    ${RESOURCES}
)


target_link_libraries(startmeapp
    PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
)

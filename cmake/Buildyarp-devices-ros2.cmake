# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YCM QUIET)
find_or_build_package(YARP QUIET)

# Workaround for ROS 2 Humble Python find cmake logic on Windows,
# drop when we do not support ROS 2 Humble anymore
# See https://github.com/robotology/robotology-superbuild/pull/1800#issuecomment-2677023043
set(LOCAL_CMAKE_ARGS "")
if(MSVC AND NOT ROBOTOLOGY_GENERATE_CONDA_RECIPES)
  find_package(Python3 COMPONENTS Interpreter Development REQUIRED)
  list(APPEND LOCAL_CMAKE_ARGS "-DPYTHON_EXECUTABLE=${Python3_EXECUTABLE}"
                               "-DPython_EXECUTABLE=${Python3_EXECUTABLE}"
                               "-DPython3_EXECUTABLE=${Python3_EXECUTABLE}")
endif()

if(ROBOTOLOGY_GENERATE_CONDA_RECIPES)
  list(APPEND LOCAL_CMAKE_ARGS -DBUILD_TESTING:BOOL=OFF)
  # Set the Python interpreter used to generate the ROS 2 interfaces.
  if(WIN32)
    # Shorten the ROS interface object paths to avoid MSVC C1083.
    # SHORT requires CMake 4.2 or newer in the package build environment.
    list(APPEND LOCAL_CMAKE_ARGS -DCMAKE_INTERMEDIATE_DIR_STRATEGY=SHORT)
    set(yarp-devices-ros2_CONDA_BUILD_DEPENDENCIES_EXPLICIT "cmake >=4.2")
    list(APPEND LOCAL_CMAKE_ARGS "-DPYTHON_EXECUTABLE:FILEPATH=%PYTHON%"
                                 "-DPython_EXECUTABLE:FILEPATH=%PYTHON%"
                                 "-DPython3_EXECUTABLE:FILEPATH=%PYTHON%")
  else()
    list(APPEND LOCAL_CMAKE_ARGS "-DPYTHON_EXECUTABLE:FILEPATH=$PYTHON"
                                 "-DPython_EXECUTABLE:FILEPATH=$PYTHON"
                                 "-DPython3_EXECUTABLE:FILEPATH=$PYTHON")
  endif()
endif()

ycm_ep_helper(yarp-devices-ros2 TYPE GIT
                                     STYLE GITHUB
                                     REPOSITORY robotology/yarp-devices-ros2.git
                                     TAG master
                                     COMPONENT core
                                     FOLDER src
                                     CMAKE_ARGS ${LOCAL_CMAKE_ARGS}
                                     DEPENDS YCM YARP)

# Match the Python ABI of the ROS 2 Jazzy packages used in pixi.lock instead
# of generating the full conda-forge Python variant matrix for this package.
set(yarp-devices-ros2_CONDA_DEPENDENCIES "python 3.12.*" ros-jazzy-ros-base ros-jazzy-test-msgs)
# RoboStack packages do not provide run_exports, so retain ROS at runtime too.
set(yarp-devices-ros2_CONDA_RUN_DEPENDENCIES_EXPLICIT ${yarp-devices-ros2_CONDA_DEPENDENCIES})

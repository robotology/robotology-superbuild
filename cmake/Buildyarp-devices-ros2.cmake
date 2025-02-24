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
  set(LOCAL_CMAKE_ARGS "-DPYTHON_EXECUTABLE=${Python3_EXECUTABLE} -DPython_EXECUTABLE=${Python3_EXECUTABLE} -DPython3_EXECUTABLE=${Python3_EXECUTABLE}")
endif()

ycm_ep_helper(yarp-devices-ros2 TYPE GIT
                                     STYLE GITHUB
                                     REPOSITORY robotology/yarp-devices-ros2.git
                                     TAG master
                                     COMPONENT core
                                     FOLDER src
                                     CMAKE_ARGS ${CMAKE_ARGS}
                                     DEPENDS YCM YARP)

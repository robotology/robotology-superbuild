# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

cmake_minimum_required(VERSION 3.12...3.27)

## We can't specify LANGUAGES NONE as have to enable C because it is currently used
## by CMake to describe packages (in Config*.cmake files) and FindACE requires CXX
project(robotology-superbuild LANGUAGES C CXX)

# Disable in source build
if("${PROJECT_SOURCE_DIR}" STREQUAL "${PROJECT_BINARY_DIR}")
   message(FATAL_ERROR "In-source builds of robotology-superbuild are not allowed. "
                       "Please remove CMakeCache.txt and the CMakeFiles/ directory, then build out-of-source. "
                       "If you really want to do an in-source build, feel free to comment out this error.")
endif("${PROJECT_SOURCE_DIR}" STREQUAL "${PROJECT_BINARY_DIR}")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

include(CTest)
include(FeatureSummary)

# Disable YCM-created install/INSTALL target (see https://github.com/robotology/robotology-superbuild/issues/356)
macro(install)
endmacro()

# Load options
include(RobotologySuperbuildOptions)

# Python-related logic
if(ROBOTOLOGY_USES_PYTHON)
  find_package(Python3 COMPONENTS Interpreter Development REQUIRED)
  if(Python3_VERSION VERSION_GREATER_EQUAL 3.12)
    execute_process(COMMAND ${Python3_EXECUTABLE} -c "import os;import sysconfig;relative_site_packages = sysconfig.get_path('purelib').replace(sysconfig.get_path('data'), '').lstrip(os.path.sep);print(relative_site_packages)"
      OUTPUT_VARIABLE _PYTHON_INSTDIR)
  else()
    execute_process(COMMAND ${Python3_EXECUTABLE} -c "from distutils import sysconfig; print(sysconfig.get_python_lib(1,0,prefix=''))"
      OUTPUT_VARIABLE _PYTHON_INSTDIR)
  endif()
  string(STRIP ${_PYTHON_INSTDIR} ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR)
  file(TO_CMAKE_PATH "${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR}" ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR) 

  # Check if swig is installed
  find_package(SWIG COMPONENTS python REQUIRED)
endif()

# Bootstrap YCM
set(YCM_FOLDER src)
set(YCM_COMPONENT core)
set(YCM_MINIMUM_VERSION 0.14.0)
# Quick workaround for https://github.com/robotology/robotology-superbuild/issues/1690
if(NOT ${YCM_TAG})
  set(YCM_TAG v0.16.6)
endif()
option(YCM_USE_CMAKE_NEXT "Use legacy YCM fork of ExternalProject module instead of upstream CMake ExternalProject" OFF)

# Include logic for generating Conda recipes (by default it is disabled) and exit
if(ROBOTOLOGY_GENERATE_CONDA_RECIPES)
  message(STATUS "ROBOTOLOGY_GENERATE_CONDA_RECIPES CMake option enabled, generating conda recipes.")
  list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/conda/cmake")
  include(RobotologySuperbuildGenerateCondaRecipes)
  return()
endif()

include(YCMBootstrapFetch)

include(FindOrBuildPackage)
include(YCMEPHelper)

# Include the logic of which packages should be built
# depending on which profiles are enabled
include(RobotologySuperbuildLogic)

if(ROBOTOLOGY_USES_MATLAB)
  # The following line is to properly configure the matlab and simulink software installed by the superbuild
  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/template/startup_robotology_superbuild.m.in ${CMAKE_BINARY_DIR}/startup_robotology_superbuild.m)
endif()

# Configure a setup.sh
if(ROBOTOLOGY_USES_GAZEBO)
  if(WIN32 OR ROBOTOLOGY_CONFIGURING_UNDER_CONDA)
    # On Windows or Conda we assume that the Gazebo Classic's environment variables are already set,
    # so we set as this name a file that does not exists and so will be ignored
    set(GAZEBO_SETUP_SH_PATH "on-windows-or-conda-we-assume-that-gazebo-env-variables-are-already-set")
  elseif(APPLE)
    set(GAZEBO_SETUP_SH_PATH "/usr/local/share/gazebo/setup.sh")
  else()
    set(GAZEBO_SETUP_SH_PATH "/usr/share/gazebo/setup.sh")
  endif()
endif()

if(WIN32)
    set(SHLIB_ENV_VAR "PATH")
elseif(APPLE)
    set(SHLIB_ENV_VAR "DYLD_LIBRARY_PATH")
else()
    set(SHLIB_ENV_VAR "LD_LIBRARY_PATH")
endif()

if(WIN32)
  set(BLOCKFACTORY_PLUGIN_PATH_DIRECTORY "bin")
else()
  set(BLOCKFACTORY_PLUGIN_PATH_DIRECTORY "lib")
endif()

# Make sure that setting XDG_DATA_DIRS on Linux (not conda)
# does not result in /usr/local/share and /usr/local being ignored
# See https://github.com/robotology/robotology-superbuild/issues/1187
if(UNIX AND NOT APPLE AND NOT ROBOTOLOGY_CONFIGURING_UNDER_CONDA)
  set(XDG_DATA_DIRS_DEFAULT_VALUE "/usr/local/share:/usr/share:")
else()
  set(XDG_DATA_DIRS_DEFAULT_VALUE "")
endif()

if(WIN32)
  # On Git Bash on Windows, C: is rendered as /c
  string(REGEX MATCH "^([A-Z])" PROJECT_SOURCE_DIR_DRIVE ${PROJECT_SOURCE_DIR})
  string(TOLOWER ${PROJECT_SOURCE_DIR_DRIVE} PROJECT_SOURCE_DIR_DRIVE_LOWER)
  string(REGEX REPLACE "^([A-Z]:)" "/${PROJECT_SOURCE_DIR_DRIVE_LOWER}" PROJECT_SOURCE_DIR_SETUP_SH ${PROJECT_SOURCE_DIR})
  string(REGEX MATCH "^([A-Z])" YCM_EP_INSTALL_DIR_DRIVE ${YCM_EP_INSTALL_DIR})
  string(TOLOWER ${YCM_EP_INSTALL_DIR_DRIVE} YCM_EP_INSTALL_DIR_DRIVE_LOWER)
  string(REGEX REPLACE "^([A-Z]:)" "/${YCM_EP_INSTALL_DIR_DRIVE_LOWER}" YCM_EP_INSTALL_DIR_SETUP_SH ${YCM_EP_INSTALL_DIR})
  if(ROBOTOLOGY_USES_PYTHON)
    string(REPLACE "\\" "/" ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR_SETUP_SH ${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR})
  endif()
else()
  set(PROJECT_SOURCE_DIR_SETUP_SH ${PROJECT_SOURCE_DIR})
  set(YCM_EP_INSTALL_DIR_SETUP_SH ${YCM_EP_INSTALL_DIR})
  if(ROBOTOLOGY_USES_PYTHON)
    set(ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR_SETUP_SH ${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR})
  endif()
endif()
message(STATUS "ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR_SETUP_SH: ${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR_SETUP_SH}")


include(ConfigureFileWithCMakeIf)
if(ROBOTOLOGY_USES_MATLAB AND ROBOTOLOGY_USES_MUJOCO)
  set(ROBOTOLOGY_WITH_MATLAB_AND_MUJOCO ON)
else()
  set(ROBOTOLOGY_WITH_MATLAB_AND_MUJOCO OFF)
endif()
configure_file_with_cmakeif(${CMAKE_CURRENT_SOURCE_DIR}/cmake/template/setup.sh.in ${YCM_EP_INSTALL_DIR}/share/${PROJECT_NAME}/setup.sh @ONLY)

if(WIN32)
  file(TO_NATIVE_PATH ${PROJECT_SOURCE_DIR} PROJECT_SOURCE_DIR_NATIVE_PATH)
  file(TO_NATIVE_PATH ${YCM_EP_INSTALL_DIR} YCM_EP_INSTALL_DIR_NATIVE_PATH)
  configure_file_with_cmakeif(${CMAKE_CURRENT_SOURCE_DIR}/cmake/template/setup.bat.in ${YCM_EP_INSTALL_DIR}/share/${PROJECT_NAME}/setup.bat @ONLY)
  configure_file_with_cmakeif(${CMAKE_CURRENT_SOURCE_DIR}/cmake/template/addPathsToUserEnvVariables.ps1.in
                              ${YCM_EP_INSTALL_DIR}/share/${PROJECT_NAME}/addPathsToUserEnvVariables.ps1 @ONLY)
  configure_file_with_cmakeif(${CMAKE_CURRENT_SOURCE_DIR}/cmake/template/removePathsFromUserEnvVariables.ps1.in
                              ${YCM_EP_INSTALL_DIR}/share/${PROJECT_NAME}/removePathsFromUserEnvVariables.ps1 @ONLY)
endif()

# Install qt.conf on Windows on conda as a workaround for the non-relocatable qt version used 
# See https://github.com/robotology/robotology-superbuild/issues/871 and
# https://github.com/robotology/robotology-superbuild/issues/882
if(WIN32 AND ROBOTOLOGY_CONFIGURING_UNDER_CONDA AND EXISTS $ENV{CONDA_PREFIX}/qt.conf)
  configure_file($ENV{CONDA_PREFIX}/qt.conf ${YCM_EP_INSTALL_DIR}/bin/qt.conf COPYONLY)
endif()

ycm_write_dot_file(${CMAKE_CURRENT_BINARY_DIR}/robotology-superbuild.dot)

set_package_properties(Git PROPERTIES TYPE RUNTIME)
set_package_properties(Subversion PROPERTIES TYPE RUNTIME)
set_package_properties(PkgConfig PROPERTIES TYPE RUNTIME)
set_package_properties(Doxygen PROPERTIES TYPE RUNTIME)

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)

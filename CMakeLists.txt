# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

cmake_minimum_required(VERSION 3.0)
project(robotology-superbuild NONE)

## we have to enable C because it is currently used
## by CMake to describe packages (in Config*.cmake files)
enable_language(C)

# Disable in source build
if("${PROJECT_SOURCE_DIR}" STREQUAL "${PROJECT_BINARY_DIR}")
   message(FATAL_ERROR "In-source builds of robotology-superbuild are not allowed. "
                       "Please remove CMakeCache.txt and the CMakeFiles/ directory, then build out-of-source. "
                       "If you really want to do an in-source build, feel free to comment out this error.")
endif("${PROJECT_SOURCE_DIR}" STREQUAL "${PROJECT_BINARY_DIR}")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

include(CTest)
include(FeatureSummary)

set(YCM_USE_CMAKE_PROPOSED TRUE CACHE BOOL "Use files including unmerged cmake patches")

# Compilation options

# Dependencies options 
## Matlab related options
option(ROBOTOLOGY_USES_MATLAB "Enable compilation of software that depend on Matlab and Simulink" FALSE)
option(ROBOTOLOGY_NOT_USE_SIMULINK "Disable compilation of software that depend on Simulink" FALSE)

## Other dynamic languages options
option(ROBOTOLOGY_USES_LUA "Enable compilation of software that depend on Lua" FALSE)
option(ROBOTOLOGY_USES_PYTHON "Enable compilation of software that depend on Python" FALSE)
option(ROBOTOLOGY_USES_OCTAVE "Enable compilation of software that depend on Octave" FALSE)

## Enable packages that depend on the Gazebo simulator
option(ROBOTOLOGY_USES_GAZEBO "Enable compilation of software that depends on Gazebo" FALSE)

# Enable/disable different components 
option(ROBOTOLOGY_ENABLE_CORE "Enable compilation of core software libraries." TRUE)
option(ROBOTOLOGY_ENABLE_DYNAMICS "Enable compilation of software for balancing and walking." FALSE)
option(ROBOTOLOGY_ENABLE_GRASPING "Enable compilation of software for grasping." FALSE)
option(ROBOTOLOGY_ENABLE_IOL "Enable compilation of software necessary for the Interactive Objects Learning demo." FALSE)
option(ROBOTOLOGY_ENABLE_ICUB_ROBOT_ETH "Enable compilation of software necessary on the pc running on the Ethernet-based iCub robot." FALSE)
option(ROBOTOLOGY_ENABLE_ICUB_ROBOT_CAN "Enable compilation of software necessary on the pc running on the CAN-based iCub robot." FALSE)
option(ROBOTOLOGY_ENABLE_R1_ROBOT "Enable compilation of software necessary on the pc running on the R1 robot." FALSE)

#set default build type to "Release" in single-config generators
if(NOT CMAKE_CONFIGURATION_TYPES)
    if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING
        "Choose the type of build, recommanded options are: Debug or Release" FORCE)
    endif()
    set(ROBOTOLOGY_BUILD_TYPES "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS ${ROBOTOLOGY_BUILD_TYPES})
endif()

# Optionally load a file named ProjectsTags
# for overwriting the desired branch/tag/commit
# of the included subprojects of the superbuild
# Useful for having superbuild "branches"
include(ProjectsTags OPTIONAL)

#Set CMake policies
if(NOT CMAKE_VERSION VERSION_LESS 3.0)
    cmake_policy(SET CMP0045 NEW)
    cmake_policy(SET CMP0046 NEW)
endif()
if(NOT CMAKE_VERSION VERSION_LESS 3.1)
    cmake_policy(SET CMP0054 NEW)
endif()


# Bootstrap YCM
# Version working after https://github.com/robotology/ycm/issues/108
set(YCM_TAG 9ffc3a48d99dd1bed603e796ec61638463c4790d)
# Workaround disabling hash warning until we fix https://github.com/robotology/codyco-superbuild/issues/162
set(YCM_SKIP_HASH_CHECK TRUE)
include(YCMBootstrap)

include(FindOrBuildPackage)
include(YCMEPHelper)

# Core 
if(ROBOTOLOGY_ENABLE_CORE)
  find_or_build_package(RTF)
  find_or_build_package(YARP)
  find_or_build_package(ICUB)
  if(ROBOTOLOGY_USES_GAZEBO)
    find_or_build_package(GazeboYARPPlugins)
    find_or_build_package(icub-gazebo)
  endif()
endif()

# Dynamics 
if(ROBOTOLOGY_ENABLE_DYNAMICS)
  find_or_build_package(iDynTree)
  find_or_build_package(codyco-modules)
  if(ROBOTOLOGY_USES_MATLAB)
    find_or_build_package(yarp-matlab-bindings)
    find_or_build_package(WBToolbox)
    find_or_build_package(WBIToolboxControllers)
  endif()  
endif()

# Grasping
if(ROBOTOLOGY_ENABLE_GRASPING)
  find_or_build_package(icub-grasp-demo)
endif()

# IOL 
if(ROBOTOLOGY_ENABLE_IOL)
  if(NOT ROBOTOLOGY_USES_LUA)
    message(FATAL_ERROR "Impossible to set ROBOTOLOGY_ENABLE_IOL to TRUE if ROBOTOLOGY_USES_LUA is set to false")
  endif()
  find_or_build_package(iol)
endif()

# iCub Robot
if(ROBOTOLOGY_ENABLE_ICUB_ROBOT_ETH OR ROBOTOLOGY_ENABLE_ICUB_ROBOT_CAN)
  find_or_build_package(ICUB)
  find_or_build_package(robots-configuration)
endif()

# R1 Robot
if(ROBOTOLOGY_ENABLE_R1_ROBOT)
  find_or_build_package(navigation)
  find_or_build_package(cer)
endif()


if(ROBOTOLOGY_USES_MATLAB)
  # The following line is to properly configure the matlab and simulink software installed by the superbuild
  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/template/startup_robotology_superbuild.m.in ${CMAKE_BINARY_DIR}/startup_robotology_superbuild.m)
endif()

set_package_properties(Git PROPERTIES TYPE RUNTIME)
set_package_properties(Subversion PROPERTIES TYPE RUNTIME)
set_package_properties(PkgConfig PROPERTIES TYPE RUNTIME)
set_package_properties(Doxygen PROPERTIES TYPE RUNTIME)

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
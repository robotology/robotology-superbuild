# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

cmake_minimum_required(VERSION 3.5)
project(robotology-superbuild NONE)

## we have to enable C because it is currently used
## by CMake to describe packages (in Config*.cmake files)
enable_language(C)

## FindACE requires CXX
enable_language(CXX)

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
option(ROBOTOLOGY_USES_OCTAVE "Enable compilation of software that depend on Octave" FALSE)
option(ROBOTOLOGY_USES_LUA "Enable compilation of software that depend on Lua" FALSE)
mark_as_advanced(ROBOTOLOGY_USES_LUA)
option(ROBOTOLOGY_USES_PYTHON "Enable compilation of software that depend on Python" FALSE)


## Enable packages that depend on the Gazebo simulator
if(WIN32)
  set(ROBOTOLOGY_USES_GAZEBO_DEFAULT FALSE)
else()
  set(ROBOTOLOGY_USES_GAZEBO_DEFAULT TRUE)
endif()
option(ROBOTOLOGY_USES_GAZEBO "Enable compilation of software that depends on Gazebo" ${ROBOTOLOGY_USES_GAZEBO_DEFAULT})

## Enable Oculus SDK and Cyberith treadmill options
option(ROBOTOLOGY_USES_OCULUS_SDK "Enable compilation of software that depend on Oculus SDK" FALSE)
option(ROBOTOLOGY_USES_CYBERITH_SDK "Enable compilation of software that depend on Cyberith SDK" FALSE)

# Enable/disable different profiles
option(ROBOTOLOGY_ENABLE_CORE "Enable compilation of core software libraries." TRUE)
option(ROBOTOLOGY_ENABLE_DYNAMICS "Enable compilation of software for balancing and walking." FALSE)
option(ROBOTOLOGY_ENABLE_TELEOPERATION "Enable compilation of software for teleoperation." FALSE)
option(ROBOTOLOGY_ENABLE_ICUB_HEAD "Enable compilation of software necessary on the system running in the head of the iCub robot." FALSE)
include(CMakeDependentOption)
cmake_dependent_option(ROBOTOLOGY_USES_CFW2CAN "Enable compilation of software that runs on the head of the iCub and depends on CFW2CAN." FALSE "ROBOTOLOGY_ENABLE_ICUB_HEAD" FALSE)


# Mark as advanced all the profiles that do not have a mantainer
option(ROBOTOLOGY_ENABLE_GRASPING "Enable compilation of software for grasping." FALSE)
mark_as_advanced(ROBOTOLOGY_ENABLE_GRASPING)
option(ROBOTOLOGY_ENABLE_IOL "Enable compilation of software necessary for the Interactive Objects Learning demo." FALSE)
mark_as_advanced(ROBOTOLOGY_ENABLE_IOL)
option(ROBOTOLOGY_ENABLE_R1_ROBOT "Enable compilation of software necessary on the pc running on the R1 robot." FALSE)
mark_as_advanced(ROBOTOLOGY_ENABLE_R1_ROBOT)


#set default build type to "Release" in single-config generators
if(NOT CMAKE_CONFIGURATION_TYPES)
    if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING
        "Choose the type of build, recommanded options are: Debug or Release" FORCE)
    endif()
    set(ROBOTOLOGY_BUILD_TYPES "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS ${ROBOTOLOGY_BUILD_TYPES})
endif()

# Optionally load a file named ProjectsTagsMaster
# for overwriting the desired branch/tag/commit
# of the included subprojects of the superbuild
# Useful for having superbuild "branches"
include(ProjectsTagsMaster OPTIONAL)

#Set CMake policies
if(NOT CMAKE_VERSION VERSION_LESS 3.0)
    cmake_policy(SET CMP0045 NEW)
    cmake_policy(SET CMP0046 NEW)
endif()
if(NOT CMAKE_VERSION VERSION_LESS 3.1)
    cmake_policy(SET CMP0054 NEW)
endif()


# Bootstrap YCM
set(YCM_FOLDER robotology)
set(YCM_COMPONENT core)
set(YCM_TAG v0.10.4)
set(YCM_MINIMUM_VERSION 0.10.4)
include(YCMBootstrap)

include(FindOrBuildPackage)
include(YCMEPHelper)

# Core
if(ROBOTOLOGY_ENABLE_CORE)
  find_or_build_package(RobotTestingFramework)
  find_or_build_package(YARP)
  find_or_build_package(ICUB)
  find_or_build_package(ICUBcontrib)
  find_or_build_package(icub-models)
  find_or_build_package(icub-tests)
  find_or_build_package(robots-configuration)
  if(ROBOTOLOGY_USES_GAZEBO)
    find_or_build_package(GazeboYARPPlugins)
    find_or_build_package(icub-gazebo)
  endif()
endif()

# Dynamics 
if(ROBOTOLOGY_ENABLE_DYNAMICS)
  find_or_build_package(iDynTree)
  find_or_build_package(codyco-modules)
  find_or_build_package(qpOASES)
  find_or_build_package(BlockFactory)
  find_or_build_package(WBToolbox)
  find_or_build_package(osqp)
  find_or_build_package(OsqpEigen)
  find_or_build_package(UnicyclePlanner)
  find_or_build_package(walking-controllers)
  if(ROBOTOLOGY_USES_GAZEBO)
    find_or_build_package(icub-gazebo-wholebody)
  endif()
  if(ROBOTOLOGY_USES_MATLAB OR ROBOTOLOGY_USES_OCTAVE)
    find_or_build_package(yarp-matlab-bindings)
  endif()
  if(ROBOTOLOGY_USES_MATLAB)
    if(NOT ROBOTOLOGY_NOT_USE_SIMULINK)
      find_or_build_package(whole-body-controllers)
    endif()
  endif()
endif()

# Teleoperation
if(ROBOTOLOGY_ENABLE_TELEOPERATION)
  find_or_build_package(walking-teleoperation)
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
if(ROBOTOLOGY_ENABLE_ICUB_HEAD)
  find_or_build_package(icub-firmware-shared)
  find_or_build_package(ICUB)
  find_or_build_package(xsensmt-yarp-driver)
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

# Configure a basic setup.sh for *nix system
if(ROBOTOLOGY_USES_GAZEBO)
  # TODO(traversaro): make sure that Gazebo exports this, for now hardcode
  if(APPLE)
    set(GAZEBO_SETUP_SH_PATH "/usr/local/share/gazebo/setup.sh")
  else()
    set(GAZEBO_SETUP_SH_PATH "/usr/share/gazebo/setup.sh")
  endif()
endif()

if (NOT WIN32)
  if(APPLE)
      set(SHLIB_ENV_VAR "DYLD_LIBRARY_PATH")
  else()
      set(SHLIB_ENV_VAR "LD_LIBRARY_PATH")
  endif()
endif()

include(ConfigureFileWithCMakeIf)
if(NOT WIN32)
  configure_file_with_cmakeif(${CMAKE_CURRENT_SOURCE_DIR}/cmake/template/setup.sh.in ${CMAKE_BINARY_DIR}/install/share/${PROJECT_NAME}/setup.sh @ONLY)
else()
  configure_file_with_cmakeif(${CMAKE_CURRENT_SOURCE_DIR}/cmake/template/setup.bat.in ${CMAKE_BINARY_DIR}/install/share/${PROJECT_NAME}/setup.bat @ONLY)
  configure_file_with_cmakeif(${CMAKE_CURRENT_SOURCE_DIR}/cmake/template/addPathsToUserEnvVariables.ps1.in
                              ${CMAKE_BINARY_DIR}/install/share/${PROJECT_NAME}/addPathsToUserEnvVariables.ps1 @ONLY)
  configure_file_with_cmakeif(${CMAKE_CURRENT_SOURCE_DIR}/cmake/template/removePathsFromUserEnvVariables.ps1.in
                              ${CMAKE_BINARY_DIR}/install/share/${PROJECT_NAME}/removePathsFromUserEnvVariables.ps1 @ONLY)
endif()

ycm_write_dot_file(${CMAKE_CURRENT_BINARY_DIR}/robotology-superbuild.dot)

set_package_properties(Git PROPERTIES TYPE RUNTIME)
set_package_properties(Subversion PROPERTIES TYPE RUNTIME)
set_package_properties(PkgConfig PROPERTIES TYPE RUNTIME)
set_package_properties(Doxygen PROPERTIES TYPE RUNTIME)

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)

# Copyright (C) 2020 Istituto Italiano di Tecnologia (IIT)
# All rights reserved.
#
# This software may be modified and distributed under the terms of the
# BSD-3-Clause license. See the accompanying LICENSE file for details.

cmake_minimum_required(VERSION 3.12)

set(INSTALLER_VERSION 2024.11.2)
option(RI_INCLUDE_GAZEBO "If ON include the Gazebo simulator binaries." ON)
option(RI_BUILD_FULL_INSTALLER "If ON build the full installer, otherwise the dependencies one." ON)

if(RI_BUILD_FULL_INSTALLER)
  project(robotology-full-installer
          VERSION ${INSTALLER_VERSION}
          DESCRIPTION "Installer for robotology software and its dependencies.")
else()
  project(robotology-dependencies-installer
          VERSION ${INSTALLER_VERSION}
          DESCRIPTION "Installer for robotology software dependencies.")
endif()

if(NOT DEFINED RI_VCPKG_INSTALL_DIR)
  set(RI_VCPKG_INSTALL_DIR_DEFAULT_VALUE "C:/robotology/vcpkg")
  message(STATUS "RI_VCPKG_INSTALL_DIR variable is not defined, use default value of ${RI_VCPKG_INSTALL_DIR_DEFAULT_VALUE}")
  set(RI_VCPKG_INSTALL_DIR ${RI_VCPKG_INSTALL_DIR_DEFAULT_VALUE} CACHE STRING "Location of the directory contaning the vcpkg instalation.")
endif()
if(NOT EXISTS ${RI_VCPKG_INSTALL_DIR})
  message(FATAL_ERROR "RI_VCPKG_INSTALL_DIR variable does not contain a valid directory (${RI_VCPKG_INSTALL_DIR})")
endif()

if(NOT DEFINED RI_SCRIPTS_INSTALL_DIR)
  set(RI_SCRIPTS_INSTALL_DIR_DEFAULT_VALUE "C:/robotology/scripts")
  message(STATUS "RI_SCRIPTS_INSTALL_DIR variable is not defined, use default value of ${RI_SCRIPTS_INSTALL_DIR_DEFAULT_VALUE}")
  set(RI_SCRIPTS_INSTALL_DIR ${RI_SCRIPTS_INSTALL_DIR_DEFAULT_VALUE} CACHE STRING "Location of the directory contaning the scripts.")
endif()
if(NOT EXISTS ${RI_SCRIPTS_INSTALL_DIR})
  message(FATAL_ERROR "RI_SCRIPTS_INSTALL_DIR variable does not contain a valid directory (${RI_SCRIPTS_INSTALL_DIR})")
endif()

if(RI_INCLUDE_GAZEBO)
  if(NOT DEFINED RI_GAZEBO_INSTALL_DIR)
    set(RI_GAZEBO_INSTALL_DIR_DEFAULT_VALUE "C:/robotology/gazebo")
    message(STATUS "RI_GAZEBO_INSTALL_DIR variable is not defined, use default value of ${RI_GAZEBO_INSTALL_DIR_DEFAULT_VALUE}")
    set(RI_GAZEBO_INSTALL_DIR ${RI_GAZEBO_INSTALL_DIR_DEFAULT_VALUE} CACHE STRING "Location of the directory contaning the gazebo instalation.")
  endif()
  if(NOT EXISTS ${RI_GAZEBO_INSTALL_DIR})
    message(FATAL_ERROR "RI_GAZEBO_INSTALL_DIR variable does not contain a valid directory (${RI_VCPKG_INSTALL_DIR})")
  endif()
endif()

if(RI_BUILD_FULL_INSTALLER)
  if(NOT DEFINED RI_SUPERBUILD_INSTALL_DIR)
    set(RI_SUPERBUILD_INSTALL_DIR_DEFAULT_VALUE "C:/robotology/robotology")
    message(STATUS "RI_SUPERBUILD_INSTALL_DIR variable is not defined, use default value of ${RI_SUPERBUILD_INSTALL_DIR_DEFAULT_VALUE}")
    set(RI_SUPERBUILD_INSTALL_DIR ${RI_SUPERBUILD_INSTALL_DIR_DEFAULT_VALUE} CACHE STRING "Location of the directory contaning the robotology-superbuild install prefix.")
  endif()
  if(NOT EXISTS ${RI_SUPERBUILD_INSTALL_DIR})
    message(FATAL_ERROR "RI_SUPERBUILD_INSTALL_DIR variable does not contain a valid directory (${RI_SUPERBUILD_INSTALL_DIR})")
  endif()
endif()

# Install directories
install(DIRECTORY ${RI_VCPKG_INSTALL_DIR}
        DESTINATION .
        COMPONENT vcpkg)
install(DIRECTORY ${RI_SCRIPTS_INSTALL_DIR}
        DESTINATION .
        COMPONENT vcpkg)

if(RI_INCLUDE_GAZEBO)
  install(DIRECTORY ${RI_GAZEBO_INSTALL_DIR}
          DESTINATION .
          COMPONENT gazebo)
endif()

if(RI_BUILD_FULL_INSTALLER)
  install(DIRECTORY ${RI_SUPERBUILD_INSTALL_DIR}
          DESTINATION .
          COMPONENT robotology)
endif()

# Specify CPack generation options (it needs to be before the inclusion of CPack and CPackIFW)
set(CPACK_GENERATOR "IFW" CACHE STRING ";-separated list of CPack generators to use (currently supported generators: IFW, ZIP)")

# By default, install on C:/robotology that is the same location where the binaries have been created
set(CPACK_IFW_TARGET_DIRECTORY "@RootDir@/robotology")

# Generate installer
include(CPack)
include(CPackIFW)

# Add cpack generator-indipendent script to add the necessary env variables and remove them
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/scripts/addPathsToUserEnvVariables.ps1
              ${CMAKE_CURRENT_SOURCE_DIR}/scripts/removePathsFromUserEnvVariables.ps1
              ${CMAKE_CURRENT_SOURCE_DIR}/scripts/setup.bat
              ${CMAKE_CURRENT_SOURCE_DIR}/scripts/setup.sh
        DESTINATION scripts
        COMPONENT vcpkg)

set(update_environment_variables_DEPENDS "vcpkg")
cpack_add_component(vcpkg
                    DISPLAY_NAME "vcpkg"
                    DESCRIPTION  "Custom vcpkg installation with precompiled x64-windows ports for robotology software."
                    REQUIRED)
cpack_ifw_configure_component(vcpkg SORTING_PRIORITY 80)

set(robotology_DEPENDS "vcpkg")
if(RI_INCLUDE_GAZEBO)
  cpack_add_component(gazebo
                      DISPLAY_NAME "Gazebo simulator"
                      DESCRIPTION  "Gazebo simulator installation for robotology software."
                      DEPENDS vcpkg)
  cpack_ifw_configure_component(gazebo SORTING_PRIORITY 70)
  list(APPEND robotology_DEPENDS "gazebo")
  list(APPEND update_environment_variables_DEPENDS "gazebo")
endif()



if(RI_BUILD_FULL_INSTALLER)
  cpack_add_component(robotology
                      DISPLAY_NAME "robotology software"
                      DESCRIPTION  "robotology software installed by the robotology-superbuild."
                      DEPENDS ${robotology_DEPENDS})
  cpack_ifw_configure_component(robotology SORTING_PRIORITY 60)
endif()

# Optionally update enviroment variables
# Create custom component to manage environment variables for each triplet

# Install a dummy empty file because
file(TOUCH ${CMAKE_CURRENT_BINARY_DIR}/the_installer_has_modified_the_environment_variables)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/the_installer_has_modified_the_environment_variables
        DESTINATION scripts
        COMPONENT update_environment_variables)

cpack_add_component(update_environment_variables
                    DISPLAY_NAME "Update Environment Variables."
                    DESCRIPTION  "Update Environment Variables to automatically use the installed software. Disable if you want to manually managed your environment."
                    DEPENDS vcpkg)

# Note: @TargetDir@ is actually a IFW macro, and should not be substitued by configure_file
# As a workaround, we define the TargetDir cmake variable as "@TargetDir@", so in  the file @TargetDir@ will be substitued by @TargetDir@
set(TargetDir "@TargetDir@")
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/scripts/update-env-variables.qs.in ${CMAKE_CURRENT_BINARY_DIR}/update-env-variables.qs @ONLY)
cpack_ifw_configure_component(update_environment_variables
                              NAME org.${CPACK_PACKAGE_NAME_UNDERSCORES}.installer.update_env_variables
                              VERSION ${CPACK_PACKAGE_VERSION}
                              SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/update-env-variables.qs
                              # It is important that this component is always installed last, as it refers to scripts installed by other components
                              SORTING_PRIORITY 50)

message(STATUS "CPACK_SYSTEM_NAME: ${CPACK_SYSTEM_NAME}")
message(STATUS "CPACK_IFW_TARGET_DIRECTORY: ${CPACK_IFW_TARGET_DIRECTORY}")

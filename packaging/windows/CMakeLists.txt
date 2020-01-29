# Copyright (C) 2020 Istituto Italiano di Tecnologia (IIT)
# All rights reserved.
#
# This software may be modified and distributed under the terms of the
# BSD-3-Clause license. See the accompanying LICENSE file for details.

cmake_minimum_required(VERSION 3.12)

project(robotology-installer 
        VERSION 2020.02
        DESCRIPTION "Installer for robotology software.")

if(NOT DEFINED RI_VCPKG_INSTALL_DIR)
  set(RI_VCPKG_INSTALL_DIR_DEFAULT_VALUE "C:/robotology/vcpkg")
  message(STATUS "RI_VCPKG_INSTALL_DIR variable is not defined, use default value of ${RI_VCPKG_INSTALL_DIR_DEFAULT_VALUE}")
  set(RI_VCPKG_INSTALL_DIR ${RI_VCPKG_INSTALL_DIR_DEFAULT_VALUE} CACHE STRING "Location of the directory contaning the vcpkg instalation.")
endif()

if(NOT DEFINED RI_SUPERBUILD_INSTALL_DIR)
  set(RI_SUPERBUILD_INSTALL_DIR_DEFAULT_VALUE "C:/robotology/robotology")
  message(STATUS "RI_SUPERBUILD_INSTALL_DIR variable is not defined, use default value of ${RI_SUPERBUILD_INSTALL_DIR_DEFAULT_VALUE}")
  set(RI_SUPERBUILD_INSTALL_DIR ${RI_SUPERBUILD_INSTALL_DIR_DEFAULT_VALUE} CACHE STRING "Location of the directory contaning the robotology-superbuild install prefix.")
endif()

if(NOT EXISTS ${RI_VCPKG_INSTALL_DIR})
  message(FATAL_ERROR "RI_VCPKG_INSTALL_DIR variable does not contain a valid directory (${RI_VCPKG_INSTALL_DIR})")
endif()
if(NOT EXISTS ${RI_SUPERBUILD_INSTALL_DIR})
  message(FATAL_ERROR "RI_SUPERBUILD_INSTALL_DIR variable does not contain a valid directory (${RI_SUPERBUILD_INSTALL_DIR})")
endif()

# Install directories 
install(DIRECTORY ${RI_VCPKG_INSTALL_DIR}
        DESTINATION .)
        
install(DIRECTORY ${RI_SUPERBUILD_INSTALL_DIR}
        DESTINATION .)

# Specify CPack generation options (it needs to be before the inclusion of CPack and CPackIFW)
set(CPACK_GENERATOR "IFW" CACHE STRING ";-separated list of CPack generators to use (currently supported generators: IFW, ZIP)")

# By default, install on C:/robotology that is the same location where the binaries have been created 
set(CPACK_IFW_TARGET_DIRECTORY "@RootDir@/robotology")

# Generate installer 
include(CPack)
include(CPackIFW)



# Optionally update enviroment variables 
# Create custom component to manage enviromental variables for each triplet 
cpack_add_component(update_env_variables
                    DISPLAY_NAME "Update Enviromental Variables."
                    DESCRIPTION  "Update Enviromental Variables to automatically use the installed software.")


# Add cpack generator-indipendent script to add the necessary env variables and remove them 
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/scripts/addPathsToUserEnvVariables.ps1 
              ${CMAKE_CURRENT_SOURCE_DIR}/scripts/removePathsFromUserEnvVariables.ps1
              ${CMAKE_CURRENT_SOURCE_DIR}/scripts/setup.bat
              ${CMAKE_CURRENT_SOURCE_DIR}/scripts/addPathsToUserEnvVariables-vcpkg.ps1 
              ${CMAKE_CURRENT_SOURCE_DIR}/scripts/removePathsFromUserEnvVariables-vcpkg.ps1
              ${CMAKE_CURRENT_SOURCE_DIR}/scripts/setup-vcpkg.bat
        DESTINATION scripts
        COMPONENT update_env_variables)
  
# Create custom component to manage enviromental variables for each triplet 
cpack_add_component(update_env_variables
                    DISPLAY_NAME "Update Enviromental Variables"
                    DESCRIPTION  "Update Enviromental Variables to automatically use the installed software.")

# Note: @TargetDir@ is actually a IFW macro, and should not be substitued by configure_file 
# As a workaround, we define the TargetDir cmake variable as "@TargetDir@", so in  the file @TargetDir@ will be substitued by @TargetDir@
set(TargetDir "@TargetDir@")  
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/scripts/update-env-variables.qs.in ${CMAKE_CURRENT_BINARY_DIR}/update-env-variables.qs @ONLY)
cpack_ifw_configure_component(update_env_variables
                              NAME org.${CPACK_PACKAGE_NAME_UNDERSCORES}.installer.update_env_variables
                              VERSION ${CPACK_PACKAGE_VERSION}
                              SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/update-env-variables.qs)

message(STATUS "CPACK_SYSTEM_NAME: ${CPACK_SYSTEM_NAME}")                              
message(STATUS "CPACK_IFW_TARGET_DIRECTORY: ${CPACK_IFW_TARGET_DIRECTORY}")
#=============================================================================
# Copyright 2013-2020 Istituto Italiano di Tecnologia (IIT)
#   Authors: Daniele E. Domenichelli <daniele.domenichelli@iit.it>
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of YCM, substitute the full
#  License text for the above reference.)


# This module is intentionally kept as small as possible in order to
# avoid the spreading of different modules.
#
# The real bootstrap is performed by the ycm_bootstrap macro from the
# YCMEPHelper module that is downloaded from the YCM package.

# CMake variables read as input by this module:
# YCM_MINIMUM_VERSION : minimum version of YCM requested to use a system YCM
# YCM_TAG     : if no suitable system YCM was found, bootstrap from this
#             : TAG (either branch, commit or tag) of YCM repository
# USE_SYSTEM_YCM : if defined and set FALSE, skip searching for a system
#                  YCM and always bootstrap


if(DEFINED __YCMBOOTSTRAP_INCLUDED)
  return()
endif()
set(__YCMBOOTSTRAP_INCLUDED TRUE)


########################################################################
# _YCM_CLEAN_PATH
#
# Internal function that removes a directory and its subfolder from an
# environment variable.
# This is useful because will stop CMake from finding the external
# projects built in the main project on the second CMake run.
#
# _path: path that should be removed
# _envvar: environment variable to clean

function(_YCM_CLEAN_PATH _path _envvar)
    get_filename_component(_path ${_path} REALPATH)
    set(_var_new "")
    if(NOT "$ENV{${_envvar}}" MATCHES "^$")
        file(TO_CMAKE_PATH "$ENV{${_envvar}}" _var_old)
        if(NOT WIN32)
            # CMake handles correctly ":" except for the first character
            string(REPLACE ":" ";" _var_old "${_var_old}")
        endif()
        foreach(_dir ${_var_old})
            get_filename_component(_dir ${_dir} REALPATH)
            if(NOT "${_dir}" MATCHES "^${_path}")
                list(APPEND _var_new ${_dir})
            endif()
        endforeach()
    endif()
    list(REMOVE_DUPLICATES _var_new)
    file(TO_NATIVE_PATH "${_var_new}" _var_new)
    if(NOT WIN32)
        string(REPLACE ";" ":" _var_new "${_var_new}")
    endif()
    set(ENV{${_envvar}} "${_var_new}")
endfunction()


# Remove binary dir from CMAKE_PREFIX_PATH and PATH before searching for
# YCM, in order to avoid to find the YCM version bootstrapped by YCM
# itself.
_ycm_clean_path("${CMAKE_BINARY_DIR}/install" CMAKE_PREFIX_PATH)
_ycm_clean_path("${CMAKE_BINARY_DIR}/install" PATH)

# If the USE_SYSTEM_YCM is explicitly set to false, we just skip to bootstrap.
# FIXME Where is USE_SYSTEM_YCM defined?
if(NOT DEFINED USE_SYSTEM_YCM OR USE_SYSTEM_YCM)
    find_package(YCM ${YCM_MINIMUM_VERSION} QUIET)
    if(COMMAND set_package_properties)
        set_package_properties(YCM PROPERTIES TYPE RECOMMENDED
                                              PURPOSE "Used by the build system")
    endif()
    if(YCM_FOUND)
        message(STATUS "YCM found in ${YCM_MODULE_DIR}.")
        set_property(GLOBAL APPEND PROPERTY YCM_PROJECTS YCM)
        return()
    endif()
endif()

message(STATUS "YCM not found. Bootstrapping it.")


include(FetchContent)

# FIXME We might also want to consider that using FetchContent we could avoid
# having the YCMBootstrap.cmake file in the repository.
# FIXME YCM_TAG must now be defined somewhere.
FetchContent_Declare(
  YCM
  GIT_REPOSITORY https://github.com/robotology/ycm.git
  GIT_TAG        ${YCM_TAG}
)

FetchContent_GetProperties(YCM)
if(NOT ycm_POPULATED)
  FetchContent_Populate(YCM)
  #include(${ycm_SOURCE_DIR}/YCMBootstrap.cmake)

  set(build_generator --build-generator "${CMAKE_GENERATOR}")
  if(CMAKE_GENERATOR_PLATFORM)
    list(APPEND build_generator --build-generator-platform "${CMAKE_GENERATOR_PLATFORM}")
  endif()
  if(CMAKE_GENERATOR_TOOLSET)
    list(APPEND build_generator --build-generator-toolset "${CMAKE_GENERATOR_TOOLSET}")
  endif()
  if(CMAKE_CONFIGURATION_TYPES)
    list(APPEND build_generator --build-config $<CONFIGURATION>)
  endif()

  # On multi-config generators (MSVC and Xcode) always build in
  # "Release" configuration
  if(CMAKE_CONFIGURATION_TYPES)
    set(_configuration --config Release)
  endif()

  if(NOT YCM_BOOTSTRAP_VERBOSE)
    set(_quiet_args
      OUTPUT_QUIET
      ERROR_QUIET
      COMMAND_ECHO STDOUT)
  else()
    set(_quiet_args )
  endif()

  set(YCM_INSTALL_DIR "${CMAKE_BINARY_DIR}/install")

  execute_process(
    COMMAND ${CMAKE_COMMAND} ${build_generator} -S${ycm_SOURCE_DIR} -B${ycm_BINARY_DIR} -DCMAKE_INSTALL_PREFIX:PATH=${YCM_INSTALL_DIR}
    WORKING_DIRECTORY ${ycm_BINARY_DIR}
    ${_quiet_args}
    RESULT_VARIABLE _result
    COMMAND_ECHO STDOUT
  )

  if(EXISTS "${ycm_BINARY_DIR}/install_manifest.txt")
    execute_process(
      COMMAND ${CMAKE_COMMAND} --build ${ycm_BINARY_DIR} ${_configuration} --target uninstall
      WORKING_DIRECTORY ${ycm_BINARY_DIR}
      ${_quiet_args}
      RESULT_VARIABLE _result
      COMMAND_ECHO STDOUT
    )
  endif()

  execute_process(
    COMMAND ${CMAKE_COMMAND} --build ${ycm_BINARY_DIR} ${_configuration}
    WORKING_DIRECTORY ${ycm_BINARY_DIR}
    ${_quiet_args}
    RESULT_VARIABLE _result
    COMMAND_ECHO STDOUT
  )

  execute_process(
    COMMAND ${CMAKE_COMMAND} --build ${ycm_BINARY_DIR} ${_configuration} --target install
    WORKING_DIRECTORY ${ycm_BINARY_DIR}
    ${_quiet_args}
    RESULT_VARIABLE _result
    COMMAND_ECHO STDOUT
  )

  # Find the package, so that can be used now.
  if(CMAKE_DISABLE_FIND_PACKAGE_YCM)
    # We need to disable this flag, in case the the user explicitly enabled
    # it in order to use the bootstrapped version, otherwise the next
    # find_package will fail.
    set(CMAKE_DISABLE_FIND_PACKAGE_YCM FALSE)
  endif()
  find_package(YCM PATHS ${YCM_INSTALL_DIR} NO_DEFAULT_PATH)

  # Reset YCM_DIR variable so that next find_package will fail to locate the package and this will be kept updated
  set(YCM_DIR "YCM_DIR-NOTFOUND" CACHE PATH "The directory containing a CMake configuration file for YCM." FORCE)
endif()

# FIXME The check on the YCMBootstrap version is no longer performed

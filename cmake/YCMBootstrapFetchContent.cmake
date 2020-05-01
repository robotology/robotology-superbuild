#=============================================================================
# Copyright 2013-2020 Istituto Italiano di Tecnologia (IIT)
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

# CMake variables read as input by this module:
# YCM_MINIMUM_VERSION : minimum version of YCM requested to use a system YCM 
# YCM_TAG     : if no suitable system YCM was found, bootstrap from this 
#             : TAG (either branch, commit or tag) of YCM repository 
# USE_SYSTEM_YCM : if defined and set FALSE, skip searching for a system 
#                  YCM and always bootstrap
# YCM_DISABLE_SYSTEM_PACKAGES: if  defined and set TRUE, skip searching for a system 
#                  YCM and always bootstrap


if(DEFINED __YCMBOOTSTRAP_FETCHCONTENT_INCLUDED)
  return()
endif()
set(__YCMBOOTSTRAP_FETCHCONTENT_INCLUDED TRUE)


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


# If the USE_SYSTEM_YCM is explicitly set to false or 
# YCM_DISABLE_SYSTEM_PACKAGES is explicitly set to true we just skip to bootstrap.
if((NOT DEFINED USE_SYSTEM_YCM OR USE_SYSTEM_YCM) AND (NOT DEFINED YCM_DISABLE_SYSTEM_PACKAGES OR NOT YCM_DISABLE_SYSTEM_PACKAGES))
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

if(NOT DEFINED YCM_TAG)
  set(YCM_TAG master)
endif()

include(FetchContent)
FetchContent_Declare(
  YCM
  GIT_REPOSITORY https://github.com/robotology/ycm.git
  GIT_TAG        ${YCM_TAG}
)

FetchContent_GetProperties(YCM)
if(NOT ycm_POPULATED)
  FetchContent_Populate(YCM)
  # The YCM build system downloads modules from several websites, 
  # and this makes it quite prone to failures. To avoid this kind of 
  # failures, we just add to CMAKE_MODULE_PATH the directory with the 
  # CMake modules used by a superbuild
  list(APPEND CMAKE_MODULE_PATH ${ycm_SOURCE_DIR}/find-modules)
  list(APPEND CMAKE_MODULE_PATH ${ycm_SOURCE_DIR}/modules)
endif()

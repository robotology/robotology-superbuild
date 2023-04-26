# Copyright (C) 2020  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Giulio Romualdi <giulio.romualdi@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

include(FindOrBuildPackage)

set(casadi_DEPENDS "")

find_or_build_package(osqp QUIET)
list(APPEND casadi_DEPENDS osqp)

# proxqp only supports MSVC Toolset v143, i.e. Visual Studio 2022
if(NOT MSVC OR MSVC_VERSION VERSION_GREATER_EQUAL 1930)
  find_or_build_package(proxsuite QUIET)
  list(APPEND casadi_DEPENDS proxsuite)
  set(casadi_WITH_PROXQP ON)
else()
  set(casadi_WITH_PROXQP OFF)
endif()

if(MSVC AND ROBOTOLOGY_USES_PYTHON)
  set(WITH_COPYSIGN_UNDEF ON)
else()
  set(WITH_COPYSIGN_UNDEF OFF)
endif()

ycm_ep_helper(casadi TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/casadi.git
              TAG 3.6.2_ami_integration
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DWITH_IPOPT:BOOL=ON
                         -DWITH_BUILD_IPOPT:BOOL=OFF
                         -DWITH_OSQP:BOOL=ON
                         -DWITH_BUILD_OSQP:BOOL=OFF
                         -DWITH_PROXQP:BOOL=${casadi_WITH_PROXQP}
                         -DWITH_BUILD_PROXQP:BOOL=OFF
                         -DWITH_TINYXML=ON
                         -DWITH_BUILD_TINYXML=OFF
                         -DWITH_EXAMPLES:BOOL=OFF
                         -DUSE_SYSTEM_WISE_OSQP:BOOL=ON
                         -DINCLUDE_PREFIX:PATH=include
                         -DCMAKE_PREFIX:PATH=lib/cmake/casadi
                         -DLIB_PREFIX:PATH=lib
                         -DBIN_PREFIX:PATH=bin
                         -DWITH_PYTHON:BOOL=${ROBOTOLOGY_USES_PYTHON}
                         -DWITH_PYTHON3:BOOL=${ROBOTOLOGY_USES_PYTHON}
                         -DCASADI_PYTHON_PIP_METADATA_INSTALL:BOOL=${ROBOTOLOGY_USES_PYTHON}
                         -DWITH_COPYSIGN_UNDEF:BOOL=${WITH_COPYSIGN_UNDEF}
                         -DPYTHON_PREFIX:PATH=${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR}
              DEPENDS ${casadi_DEPENDS})

set(casadi_CONDA_PKG_NAME casadi)
set(casadi_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
# This is a small hack. To avoid incompatibilities between the version tagged in the ami-iit fork
# (something like 3.6.0.x) and the version available in conda-forge when generating conda metapackages
# such as robotology-distro and robotology-distro-all, we override the conda package version of casadi
# here. This needs to be removed as soon as we stop use our fork in the superbuild 
set(casadi_CONDA_VERSION 3.6.2)


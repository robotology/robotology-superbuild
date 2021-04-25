# Copyright (C) 2020  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Giulio Romualdi <giulio.romualdi@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

include(FindOrBuildPackage)
find_or_build_package(osqp QUIET)

ycm_ep_helper(casadi TYPE GIT
              STYLE GITHUB
              REPOSITORY dic-iit/casadi.git
              TAG support_osqp_0.6.2
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DWITH_IPOPT:BOOL=ON
                         -DWITH_OSQP:BOOL=ON
                         -DWITH_EXAMPLES:BOOL=OFF
                         -DUSE_SYSTEM_WISE_OSQP:BOOL=ON
                         -DINCLUDE_PREFIX:PATH=include
                         -DCMAKE_PREFIX:PATH=lib/cmake/casadi
                         -DLIB_PREFIX:PATH=lib
                         -DBIN_PREFIX:PATH=bin
                         -DWITH_PYTHON:BOOL=${ROBOTOLOGY_USES_PYTHON}
                         -DWITH_PYTHON3:BOOL=${ROBOTOLOGY_USES_PYTHON}
                         -DWITH_COPYSIGN_UNDEF=ON
                         -DPYTHON_PREFIX:PATH=${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR}
              DEPENDS osqp)

set(casadi_CONDA_PKG_NAME casadi)
set(casadi_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

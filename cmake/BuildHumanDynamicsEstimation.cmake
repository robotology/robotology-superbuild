# Copyright (C) 2018  iCub Facility, Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)
find_or_build_package(iDynTree QUIET)
find_or_build_package(osqp QUIET)
find_or_build_package(OsqpEigen QUIET)
find_or_build_package(robometry QUIET)

# For what regards Python installation, the options changes depending
# on whether we are installing HDE in the superbuild, or generating a
# conda package
# See https://github.com/robotology/robotology-superbuild/issues/641
set(HDE_OPTIONAL_CMAKE_ARGS "")
if(ROBOTOLOGY_USES_PYTHON) 
  if (NOT ROBOTOLOGY_GENERATE_CONDA_RECIPES)
    # If we are not generating a conda recipe, the bindings need to go in the ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR
    list(APPEND HDE_OPTIONAL_CMAKE_ARGS "-DHDE_PYTHON_INSTALL_DIR=${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR}")
  else()
    # If we are building a conda package, the active environment is the correct place were to install the python bindings
    list(APPEND HDE_OPTIONAL_CMAKE_ARGS "-DHDE_DETECT_ACTIVE_PYTHON_SITEPACKAGES:BOOL=ON")
  endif()
endif()


if(WIN32)
    list(APPEND HDE_OPTIONAL_CMAKE_ARGS -DXSENS_MVN_USE_SDK:BOOL=${ROBOTOLOGY_USES_XSENS_MVN_SDK} -DENABLE_XsensSuit:BOOL=${ROBOTOLOGY_USES_XSENS_MVN_SDK} )
endif()

ycm_ep_helper(HumanDynamicsEstimation TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/human-dynamics-estimation.git
              TAG master
              COMPONENT human_dynamics
              FOLDER src
              CMAKE_ARGS -DHUMANSTATEPROVIDER_ENABLE_VISUALIZER:BOOL=ON -DHDE_COMPILE_PYTHON_BINDINGS:BOOL=${ROBOTOLOGY_USES_PYTHON} ${HDE_OPTIONAL_CMAKE_ARGS}
              DEPENDS iDynTree
                      YARP
                      osqp
                      OsqpEigen
                      ICUB
                      robometry
                      ${HumanDynamicsEstimation_OPTIONAL_DEPS})

set(HumanDynamicsEstimation_CONDA_PKG_NAME human-dynamics-estimation)
set(HumanDynamicsEstimation_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

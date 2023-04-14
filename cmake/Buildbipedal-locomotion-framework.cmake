# Copyright (C) 2020  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Giulio Romualdi <gulio.romualdi@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(robometry QUIET)
find_or_build_package(OsqpEigen QUIET)
find_or_build_package(iDynTree QUIET)
find_or_build_package(matioCpp QUIET)
find_or_build_package(UnicyclePlanner QUIET)

set(bipedal-locomotion-framework_DEPENDS "")
list(APPEND bipedal-locomotion-framework_DEPENDS YARP)
list(APPEND bipedal-locomotion-framework_DEPENDS OsqpEigen)
list(APPEND bipedal-locomotion-framework_DEPENDS iDynTree)
list(APPEND bipedal-locomotion-framework_DEPENDS matioCpp)
list(APPEND bipedal-locomotion-framework_DEPENDS UnicyclePlanner)
list(APPEND bipedal-locomotion-framework_DEPENDS robometry)

set(bipedal-locomotion-framework_USES_CppAD OFF)

if (ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS)
  find_or_build_package(manif QUIET)
  find_or_build_package(casadi QUIET)
  find_or_build_package(CppAD QUIET)
  find_or_build_package(LieGroupControllers QUIET)

  list(APPEND bipedal-locomotion-framework_DEPENDS manif)
  list(APPEND bipedal-locomotion-framework_DEPENDS casadi)
  list(APPEND bipedal-locomotion-framework_DEPENDS CppAD)
  list(APPEND bipedal-locomotion-framework_DEPENDS LieGroupControllers)

  if (ROBOTOLOGY_BUILD_QHULL)
    find_or_build_package(qhull QUIET)
    list(APPEND bipedal-locomotion-framework_DEPENDS qhull)
  endif()

  if (ROBOTOLOGY_BUILD_tomlplusplus)
    find_or_build_package(tomlplusplus QUIET)
    list(APPEND bipedal-locomotion-framework_DEPENDS tomlplusplus)
  endif()
endif()

# For what regards Python installation, the options changes depending
# on whater we are installing blf in the superbuild, or we are generating a
# conda package on Windows as in that case the installation location
# will need to be outside of CMAKE_INSTALL_PREFIX
# See https://github.com/robotology/robotology-superbuild/issues/641
set(bipedal-locomotion-framework_OPTIONAL_CMAKE_ARGS "")
if(ROBOTOLOGY_USES_PYTHON AND ROBOTOLOGY_GENERATE_CONDA_RECIPES)
  list(APPEND bipedal-locomotion-framework_OPTIONAL_CMAKE_ARGS "-DFRAMEWORK_DETECT_ACTIVE_PYTHON_SITEPACKAGES:BOOL=ON")
endif()

if(ROBOTOLOGY_USES_PCL_AND_VTK)
  list(APPEND bipedal-locomotion-framework_OPTIONAL_CMAKE_ARGS "-DFRAMEWORK_USE_PCL:BOOL=ON")
endif()

# Workaround for part of https://github.com/robotology/robotology-superbuild/issues/1307
if(APPLE OR WIN32)
  list(APPEND bipedal-locomotion-framework_OPTIONAL_CMAKE_ARGS "-DENABLE_YarpRobotLoggerDevice:BOOL=OFF")
endif()

# onnxruntime
# Just on Linux without conda, we download onnxruntime
set(FRAMEWORK_USE_onnxruntime OFF)
if(ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS)
  if(CMAKE_SYSTEM_NAME STREQUAL "Linux" AND NOT ROBOTOLOGY_CONFIGURING_UNDER_CONDA)
    include(Fetchonnxruntimebinaries)
    set(FRAMEWORK_USE_onnxruntime ON)
  endif()
endif()

ycm_ep_helper(bipedal-locomotion-framework TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/bipedal-locomotion-framework.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS -DBUILD_TESTING:BOOL=OFF
                         -DFRAMEWORK_USE_YARP:BOOL=ON
                         -DFRAMEWORK_USE_OsqpEigen:BOOL=ON
                         -DFRAMEWORK_USE_matioCpp:BOOL=ON
                         -DFRAMEWORK_USE_manif:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_USE_Qhull:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_USE_cppad:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_USE_casadi:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_USE_LieGroupControllers:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_USE_tomlplusplus:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_USE_onnxruntime:BOOL=${FRAMEWORK_USE_onnxruntime}
                         -DFRAMEWORK_COMPILE_PYTHON_BINDINGS:BOOL=${ROBOTOLOGY_USES_PYTHON}
                         ${bipedal-locomotion-framework_OPTIONAL_CMAKE_ARGS}
              DEPENDS ${bipedal-locomotion-framework_DEPENDS})

set(bipedal-locomotion-framework_CONDA_PKG_NAME bipedal-locomotion-framework)
set(bipedal-locomotion-framework_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

# Copyright (C) 2020  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Giulio Romualdi <gulio.romualdi@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(iDynTree QUIET)
find_or_build_package(matioCpp QUIET)

set(bipedal-locomotion-framework_DEPENDS "")
list(APPEND bipedal-locomotion-framework_DEPENDS YARP)
list(APPEND bipedal-locomotion-framework_DEPENDS iDynTree)
list(APPEND bipedal-locomotion-framework_DEPENDS matioCpp)

set(bipedal-locomotion-framework_USES_CppAD OFF)

if (ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS)
  find_or_build_package(manif QUIET)
  find_or_build_package(qhull QUIET)
  find_or_build_package(casadi QUIET)
  find_or_build_package(CppAD QUIET)
  find_or_build_package(LieGroupControllers QUIET)

  list(APPEND bipedal-locomotion-framework_DEPENDS manif)
  list(APPEND bipedal-locomotion-framework_DEPENDS qhull)
  list(APPEND bipedal-locomotion-framework_DEPENDS casadi)
  list(APPEND bipedal-locomotion-framework_DEPENDS CppAD)
  list(APPEND bipedal-locomotion-framework_DEPENDS LieGroupControllers)
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

ycm_ep_helper(bipedal-locomotion-framework TYPE GIT
              STYLE GITHUB
              REPOSITORY dic-iit/bipedal-locomotion-framework.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS -DBUILD_TESTING:BOOL=OFF
                         -DFRAMEWORK_USE_YARP:BOOL=ON
                         -DFRAMEWORK_USE_matioCpp:BOOL=ON
                         -DFRAMEWORK_USE_manif:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_USE_Qhull:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_USE_cppad:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_USE_casadi:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_USE_LieGroupControllers:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_COMPILE_PYTHON_BINDINGS:BOOL=ON
                         ${bipedal-locomotion-framework_OPTIONAL_CMAKE_ARGS}
              DEPENDS ${bipedal-locomotion-framework_DEPENDS})

set(bipedal-locomotion-framework_CONDA_DEPENDENCIES eigen)
list(APPEND bipedal-locomotion-framework_CONDA_DEPENDENCIES nlohmann_json)
list(APPEND bipedal-locomotion-framework_CONDA_DEPENDENCIES spdlog)

if(ROBOTOLOGY_USES_PYTHON)
  list(APPEND bipedal-locomotion-framework_CONDA_DEPENDENCIES pybind11)
  # https://conda-forge.org/docs/maintainer/knowledge_base.html#pybind11-abi-constraints
  list(APPEND bipedal-locomotion-framework_CONDA_DEPENDENCIES pybind11-abi)
  list(APPEND bipedal-locomotion-framework_CONDA_DEPENDENCIES python)
  list(APPEND bipedal-locomotion-framework_CONDA_DEPENDENCIES numpy)
  list(APPEND bipedal-locomotion-framework_CONDA_DEPENDENCIES manifpy)
endif()

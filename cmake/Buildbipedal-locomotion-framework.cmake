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
find_or_build_package(manif QUIET)
find_or_build_package(LieGroupControllers QUIET)


set(bipedal-locomotion-framework_DEPENDS "")
list(APPEND bipedal-locomotion-framework_DEPENDS YARP)
list(APPEND bipedal-locomotion-framework_DEPENDS OsqpEigen)
list(APPEND bipedal-locomotion-framework_DEPENDS iDynTree)
list(APPEND bipedal-locomotion-framework_DEPENDS matioCpp)
list(APPEND bipedal-locomotion-framework_DEPENDS UnicyclePlanner)
list(APPEND bipedal-locomotion-framework_DEPENDS robometry)
list(APPEND bipedal-locomotion-framework_DEPENDS manif)
list(APPEND bipedal-locomotion-framework_DEPENDS LieGroupControllers)

if (ROBOTOLOGY_BUILD_tomlplusplus)
  find_or_build_package(tomlplusplus QUIET)
  list(APPEND bipedal-locomotion-framework_DEPENDS tomlplusplus)
endif()

set(bipedal-locomotion-framework_USES_CppAD OFF)

if (ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS)
  find_or_build_package(casadi QUIET)
  find_or_build_package(CppAD QUIET)
  list(APPEND bipedal-locomotion-framework_DEPENDS casadi)
  list(APPEND bipedal-locomotion-framework_DEPENDS CppAD)
endif()

set(bipedal-locomotion-framework_OPTIONAL_CMAKE_ARGS "")
if(ROBOTOLOGY_USES_PYTHON)
  list(APPEND bipedal-locomotion-framework_OPTIONAL_CMAKE_ARGS "-DFRAMEWORK_PYTHON_INSTALL_DIR:PATH=${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR}")
endif()

if(ROBOTOLOGY_USES_PCL_AND_VTK)
  list(APPEND bipedal-locomotion-framework_OPTIONAL_CMAKE_ARGS "-DFRAMEWORK_USE_PCL:BOOL=ON")
endif()

# Just on Linux without conda, we download onnxruntime
# On conda instead, we install onnxruntime-cpp package
if(ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS)
  if(CMAKE_SYSTEM_NAME STREQUAL "Linux" AND NOT ROBOTOLOGY_CONFIGURING_UNDER_CONDA)
    include(Fetchonnxruntimebinaries)
  endif()
endif()

ycm_ep_helper(bipedal-locomotion-framework TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/bipedal-locomotion-framework.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS -DBUILD_TESTING:BOOL=OFF
                         -DFRAMEWORK_COMPILE_Ros1Publisher:BOOL=OFF
                         -DFRAMEWORK_USE_YARP:BOOL=ON
                         -DFRAMEWORK_USE_OsqpEigen:BOOL=ON
                         -DFRAMEWORK_USE_matioCpp:BOOL=ON
                         -DFRAMEWORK_USE_manif:BOOL=ON
                         -DFRAMEWORK_USE_Qhull:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_USE_cppad:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_USE_casadi:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_USE_LieGroupControllers:BOOL=ON
                         -DFRAMEWORK_USE_tomlplusplus:BOOL=ON
                         -DFRAMEWORK_USE_onnxruntime:BOOL=${ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS}
                         -DFRAMEWORK_COMPILE_PYTHON_BINDINGS:BOOL=${ROBOTOLOGY_USES_PYTHON}
                         -DFRAMEWORK_USE_PCL:BOOL=OFF
                         ${bipedal-locomotion-framework_OPTIONAL_CMAKE_ARGS}
                         # Remove once https://github.com/ami-iit/bipedal-locomotion-framework/pull/955 is merged and released
                         -DCMAKE_POLICY_VERSION_MINIMUM=3.16
              DEPENDS ${bipedal-locomotion-framework_DEPENDS})

set(bipedal-locomotion-framework_CONDA_PKG_NAME bipedal-locomotion-framework)
set(bipedal-locomotion-framework_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

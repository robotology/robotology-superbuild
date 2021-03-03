# Copyright (C) 2020  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Giulio Romualdi <gulio.romualdi@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(iDynTree QUIET)
find_or_build_package(matio-cpp QUIET)

set(bipedal-locomotion-framework_DEPENDS "")
list(APPEND bipedal-locomotion-framework_DEPENDS YARP)
list(APPEND bipedal-locomotion-framework_DEPENDS iDynTree)
list(APPEND bipedal-locomotion-framework_DEPENDS matio-cpp)

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
              DEPENDS ${bipedal-locomotion-framework_DEPENDS})

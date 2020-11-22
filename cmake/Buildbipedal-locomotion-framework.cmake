# Copyright (C) 2020  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Giulio Romualdi <gulio.romualdi@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

set(bipedal-locomotion-framework_DEPENDS "")
list(APPEND bipedal-locomotion-framework_DEPENDS YARP)
list(APPEND bipedal-locomotion-framework_DEPENDS iDynTree)

if (ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS)
  include(FindOrBuildPackage)

  find_or_build_package(manif QUIET)
  find_or_build_package(qhull QUIET)
  find_or_build_package(CppAD QUIET)
  find_or_build_package(casadi QUIET)

  list(APPEND bipedal-locomotion-framework_DEPENDS manif)
  list(APPEND bipedal-locomotion-framework_DEPENDS qhull)
  list(APPEND bipedal-locomotion-framework_DEPENDS CppAD)
  list(APPEND bipedal-locomotion-framework_DEPENDS casadi)

endif()

ycm_ep_helper(BipedalLocomotionFramework TYPE GIT
              STYLE GITHUB
              REPOSITORY dic-iit/bipedal-locomotion-framework.git
              TAG master
              COMPONENT dynamics
              FOLDER robotology
              CMAKE_ARGS -DBUILD_TESTING:BOOL=OFF
              DEPENDS ${bipedal-locomotion-framework_DEPENDS})

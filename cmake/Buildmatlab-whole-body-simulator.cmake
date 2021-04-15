# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT
include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(yarp-matlab-bindings QUIET)
find_or_build_package(WBToolbox QUIET)
find_or_build_package(iDynTree QUIET)
find_or_build_package(qpOASES QUIET)
find_or_build_package(icub-models QUIET)
find_or_build_package(whole-body-controllers QUIET)

set(matlab-whole-body-simulator_DEPENDS "")
list(APPEND matlab-whole-body-simulator_DEPENDS YARP)
list(APPEND matlab-whole-body-simulator_DEPENDS yarp-matlab-bindings)
list(APPEND matlab-whole-body-simulator_DEPENDS WBToolbox)
list(APPEND matlab-whole-body-simulator_DEPENDS iDynTree)
list(APPEND matlab-whole-body-simulator_DEPENDS qpOASES)
list(APPEND matlab-whole-body-simulator_DEPENDS icub-models)
list(APPEND matlab-whole-body-simulator_DEPENDS whole-body-controllers)

ycm_ep_helper(matlab-whole-body-simulator TYPE GIT
              STYLE GITHUB
              REPOSITORY dic-iit/matlab-whole-body-simulator.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              DEPENDS matlab-whole-body-simulator_DEPENDS)

# Metadata for conda package generation
# If we do not set the package name, by default the repo name would be used
# so in this case osqp-matlab-cmake-buildsystem that is not descriptive of the
# generated artifact that is contained in the conda package

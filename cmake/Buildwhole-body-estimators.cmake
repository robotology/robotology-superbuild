# Copyright (C) 2020 Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)
find_or_build_package(iDynTree QUIET)

set(whole-body-estimators_DEPENDS)

list(APPEND whole-body-estimators_DEPENDS YARP)
list(APPEND whole-body-estimators_DEPENDS ICUB)
list(APPEND whole-body-estimators_DEPENDS iDynTree)

ycm_ep_helper(whole-body-estimators TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/whole-body-estimators.git
              TAG master
              COMPONENT dynamics
              FOLDER robotology
              DEPENDS ${whole-body-estimators_DEPENDS})

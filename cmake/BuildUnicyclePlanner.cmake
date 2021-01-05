# Copyright (C) 2018  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Stefano Dafarra <stefano.dafarra@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(iDynTree 0.9.2 QUIET)

ycm_ep_helper(UnicyclePlanner TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/unicycle-footstep-planner.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              DEPENDS iDynTree)

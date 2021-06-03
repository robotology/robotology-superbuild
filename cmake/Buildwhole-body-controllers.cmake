# Copyright (C) 2021 Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(WBToolbox QUIET)
find_or_build_package(casadi-matlab-bindings QUIET)

ycm_ep_helper(whole-body-controllers TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/whole-body-controllers.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              DEPENDS WBToolbox
                      casadi-matlab-bindings)

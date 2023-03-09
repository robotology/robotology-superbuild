# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(manif QUIET)

ycm_ep_helper(LieGroupControllers TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/lie-group-controllers.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              DEPENDS manif)

set(LieGroupControllers_CONDA_PKG_NAME liblie-group-controllers)
set(LieGroupControllers_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

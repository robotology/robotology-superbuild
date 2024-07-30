# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

ycm_ep_helper(gz-sim-yarp-plugins TYPE GIT
                                STYLE GITHUB
                                REPOSITORY robotology/gz-sim-yarp-plugins
                                TAG main
                                COMPONENT core
                                FOLDER src
                                DEPENDS YARP)

set(gz-sim-yarp-plugins_CONDA_PKG_NAME libgz-sim-yarp-plugins)
set(gz-sim-yarp-plugins_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

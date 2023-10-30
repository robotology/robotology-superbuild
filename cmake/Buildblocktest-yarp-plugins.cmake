# Copyright (C) 2020 iCub Facility, Istituto Italiano di Tecnologia
# Authors: Nicolò Genesio <nicolo.genesio@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(blocktestcore QUIET)

ycm_ep_helper(blocktest-yarp-plugins TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/blocktest-yarp-plugins.git
              TAG master
              COMPONENT core
              FOLDER src
              DEPENDS YARP
                      blocktestcore
              CMAKE_ARGS -DENABLE_MSVC_WARNINGS:BOOL=OFF)
              
set(blocktest-yarp-plugins_CONDA_DEPENDENCIES boost-cpp)

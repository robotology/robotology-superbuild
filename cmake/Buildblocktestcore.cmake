# Copyright (C) 2020 iCub Facility, Istituto Italiano di Tecnologia
# Authors: Nicolò Genesio <nicolo.genesio@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

find_or_build_package(YCM QUIET)

ycm_ep_helper(blocktestcore TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/blocktest.git
              TAG master
              COMPONENT core
              FOLDER src
              CMAKE_CACHE_ARGS -DENABLE_MSVC_WARNINGS:BOOL=OFF
              DEPENDS YCM)

set(blocktestcore_CONDA_DEPENDENCIES qt boost-cpp)
set(blocktestcore_CONDA_VERSION "2.3.0.1")

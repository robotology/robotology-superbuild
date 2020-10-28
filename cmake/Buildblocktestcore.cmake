# Copyright (C) 2020 iCub Facility, Istituto Italiano di Tecnologia
# Authors: Nicolò Genesio <nicolo.genesio@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

ycm_ep_helper(blocktestcore TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/blocktest.git
              TAG master
              COMPONENT core
              FOLDER robotology
              CMAKE_CACHE_ARGS -DENABLE_MSVC_WARNINGS:BOOL=OFF)

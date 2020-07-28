# Copyright (C) 2020 iCub Facility, Istituto Italiano di Tecnologia
# Authors: Nicolò Genesio <nicolo.genesio@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

find_or_build_package(YARP QUIET)
find_or_build_package(icub_firmware_shared QUIET)

ycm_ep_helper(diagnosticdaemon TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/diagnostic-daemon.git
              TAG master
              CMAKE_ARGS -DCOMPILE_WITHYARP_DEF:BOOL=ON
              COMPONENT core
              FOLDER robotology
              DEPENDS YARP
                      icub_firmware_shared)

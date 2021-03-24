# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YCM QUIET)

ycm_ep_helper(icub_firmware_shared TYPE GIT
                                   STYLE GITHUB
                                   REPOSITORY robotology/icub-firmware-shared.git
                                   COMPONENT iCub
                                   FOLDER src
                                   DEPENDS YCM)

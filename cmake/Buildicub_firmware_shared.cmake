# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

# The parameter is set as a workaround for https://github.com/robotology/robotology-superbuild/issues/1881
# In a nutshell, the non-CMake based setup of icub-firmware requires the icub-firmware-shared folder to be name
# exact icub-firmware-shared, while by default ycm_ep_helper would name the folder icub_firmware_shared coherently
# with the CMake package name. As a workaround, we keep the project name as icub_firmware_shared, but we pass the 
# PROJECT_FOLDER_NAME parameter to change the name just of the folder, see https://github.com/robotology/ycm-cmake-modules/pull/480
# This fixes the problem if the user is using YCM>=0.18.4, while the parameter is ignored if an earlier YCM is used
ycm_ep_helper(icub_firmware_shared TYPE GIT
                                   STYLE GITHUB
                                   REPOSITORY robotology/icub-firmware-shared.git
                                   COMPONENT iCub
                                   FOLDER src
                                   PROJECT_FOLDER_NAME icub-firmware-shared
                                   DEPENDS YCM)

set(icub_firmware_shared_CONDA_PKG_NAME icub-firmware-shared)
set(icub_firmware_shared_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

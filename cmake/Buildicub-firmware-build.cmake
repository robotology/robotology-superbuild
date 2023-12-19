# SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia (IIT)
# SPDX-License-Identifier: BSD-3-Clause

include(YCMEPHelper)
include(FindOrBuildPackage)

# The SHALLOW TRUE option in ycm_ep_helper translates to GIT_SHALLOW
# passed to ExternalProject_Add, that only works for branches and tags
# if you need to set icub-firmware-build_TAG to a commit hash, then also set
# icub-firmware-build_SHALLOW to FALSE, to override the SHALLOW TRUE option
ycm_ep_helper(icub-firmware-build TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/icub-firmware-build.git
              COMPONENT iCub
              FOLDER src
              SHALLOW TRUE)

# We want to make sure that the conda package is called icub-firmware,
# as it is the output of the robotology/icub-firmware repo, the
# icub-firmware-build repo is just a place where binaries are hosted
set(icub-firmware-build_CONDA_PKG_NAME icub-firmware)

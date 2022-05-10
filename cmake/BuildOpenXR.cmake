# SPDX-FileCopyrightText: 2022 Fondazione Istituto Italiano di Tecnologia (IIT)
# SPDX-License-Identifier: BSD-3-Clause

include(YCMEPHelper)
include(FindOrBuildPackage)

ycm_ep_helper(OpenXR TYPE GIT
              STYLE GITHUB
              REPOSITORY KhronosGroup/OpenXR-SDK.git
              TAG master
              COMPONENT external
              FOLDER src)

set(OpenXR_CONDA_PKG_NAME openxr-sdk)
set(OpenXR_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

# SPDX-FileCopyrightText: 2022 Fondazione Istituto Italiano di Tecnologia (IIT)
# SPDX-License-Identifier: BSD-3-Clause

include(YCMEPHelper)
include(FindOrBuildPackage)

ycm_ep_helper(OpenXR TYPE GIT
              STYLE GITHUB
              REPOSITORY KhronosGroup/OpenXR-SDK.git
              TAG main
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DBUILD_SHARED_LIBS:BOOL=ON
                         -DHAVE_FILESYSTEM_WITHOUT_LIB:BOOL=OFF
                         -DDYNAMIC_LOADER:BOOL=ON
                         # Workaround for jsonCppConfig.cmake not being compatible with CMake 4.0, remove
                         # once we drop support for Ubuntu 22.04 with apt dependencies
                         -DCMAKE_POLICY_VERSION_MINIMUM=3.5)

set(OpenXR_CONDA_PKG_NAME openxr-sdk)
set(OpenXR_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

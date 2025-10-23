# SPDX-FileCopyrightText: 2022 Fondazione Istituto Italiano di Tecnologia (IIT)
# SPDX-License-Identifier: BSD-3-Clause

include(YCMEPHelper)

ycm_ep_helper(OpenVR TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/openvr.git
              TAG fix_upstream_oct_2025 
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DBUILD_SHARED:BOOL=ON
                         # Workaround for CMake 4.0 compatibility, this is a reason why we need to drop OpenVR
                         -DCMAKE_POLICY_VERSION_MINIMUM=3.10)

set(OpenVR_CONDA_PKG_NAME openvr)

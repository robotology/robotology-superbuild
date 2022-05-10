# SPDX-FileCopyrightText: 2022 Fondazione Istituto Italiano di Tecnologia (IIT)
# SPDX-License-Identifier: BSD-3-Clause

include(YCMEPHelper)

ycm_ep_helper(OpenVR TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/openvr.git
              TAG fix_upstream
              COMPONENT external
              FOLDER src)

set(OpenVR_CONDA_PKG_NAME openvr)

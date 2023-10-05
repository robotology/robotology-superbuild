# SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
# SPDX-License-Identifier: BSD-3-Clause

include(RobSupPurePythonYCMEPHelper)

rob_sup_pure_python_ycm_ep_helper(resolve-robotics-uri-py
                                  REPOSITORY ami-iit/resolve-robotics-uri-py.git
                                  TAG main
                                  COMPONENT dynamics
                                  FOLDER src)

set(resolve-robotics-uri-py_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

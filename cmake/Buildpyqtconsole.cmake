# SPDX-FileCopyrightText: 2022 Fondazione Istituto Italiano di Tecnologia
# SPDX-License-Identifier: BSD-3-Clause

include(RobSupPurePythonYCMEPHelper)

rob_sup_pure_python_ycm_ep_helper(pyqtconsole
                                  REPOSITORY pyqtconsole/pyqtconsole.git
                                  TAG master
                                  COMPONENT dynamics
                                  FOLDER src)

# Copyright (C) 2023 Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

ycm_ep_helper(tomlplusplus
              TYPE GIT
              STYLE GITHUB
              REPOSITORY marzer/tomlplusplus.git
              TAG master
              COMPONENT core
              FOLDER src)

set(tomlplusplus_CONDA_PKG_NAME tomlplusplus)
set(tomlplusplu_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

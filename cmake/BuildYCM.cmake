# Copyright (C) 2022 iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

ycm_ep_helper(YCM TYPE GIT
                  STYLE GITHUB
                  REPOSITORY robotology/ycm.git
                  COMPONENT core
                  FOLDER src)

set(YCM_CONDA_PKG_NAME ycm-cmake-modules)
set(YCM_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

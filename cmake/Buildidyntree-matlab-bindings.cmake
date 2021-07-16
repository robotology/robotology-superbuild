# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT
include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(iDynTree QUIET)

# The version of idyntree-matlab-bindings is always exactly the same of iDynTree, as we use the exact same repo
set(idyntree-matlab-bindings_TAG ${iDynTree_TAG})

ycm_ep_helper(idyntree-matlab-bindings TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/idyntree.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS -DIDYNTREE_USES_MATLAB:BOOL=${ROBOTOLOGY_USES_MATLAB}
              DEPENDS iDynTree
              SOURCE_SUBDIR bindings)

set(idyntree-matlab-bindings_CONDA_PKG_NAME idyntree-matlab-bindings)

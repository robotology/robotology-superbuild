# Copyright (C) 2020  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Giulio Romualdi <gulio.romualdi@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

# We pass CMAKE_CXX_STANDARD=17 as we encountered problems when using -march=native
# and mixing libraries compiled with C++11 and C++17, see
# https://github.com/artivis/manif/issues/274
ycm_ep_helper(manif TYPE GIT
              STYLE GITHUB
              REPOSITORY artivis/manif.git
              TAG master
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DCMAKE_CXX_STANDARD=17 -DBUILD_TESTING:BOOL=OFF -DBUILD_EXAMPLES:BOOL=OFF -DBUILD_PYTHON_BINDINGS:BOOL=${ROBOTOLOGY_USES_PYTHON}  -DMANIFPY_PKGDIR:PATH=${YCM_EP_INSTALL_DIR}/${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR})

set(manif_CONDA_PKG_NAME manif)
set(manif_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)


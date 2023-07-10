# Copyright (C) 2020  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Giulio Romualdi <gulio.romualdi@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

# Workaround for https://github.com/robotology/robotology-superbuild/pull/838#issuecomment-887367047
if(ROBOTOLOGY_USES_PYTHON AND NOT WIN32)
  set(BUILD_PYTHON_BINDINGS ON)
else()
  set(BUILD_PYTHON_BINDINGS OFF)
endif()

# We pass CMAKE_CXX_STANDARD=17 as we encountered problems when using -march=native
# and mixing libraries compiled with C++11 and C++17, see
# https://github.com/artivis/manif/issues/274
ycm_ep_helper(manif TYPE GIT
              STYLE GITHUB
              REPOSITORY artivis/manif.git
              TAG master
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DCMAKE_CXX_STANDARD=17 -DBUILD_TESTING:BOOL=OFF -DBUILD_EXAMPLES:BOOL=OFF -DBUILD_PYTHON_BINDINGS:BOOL=${BUILD_PYTHON_BINDINGS}  -DMANIFPY_PKGDIR:PATH=${YCM_EP_INSTALL_DIR}/${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR})

set(manif_CONDA_PKG_NAME manif)
set(manif_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
# This is a small hack. To avoid incompatibilities between the version tagged in the ami-iit fork
# (something like 0.0.4.x) and the version available in conda-forge when generating conda metapackages
# such as robotology-distro and robotology-distro-all, we override the conda package version of manif
# here. This needs to be removed as soon as we stop using our fork in the superbuild 
set(manif_CONDA_VERSION 0.0.4)

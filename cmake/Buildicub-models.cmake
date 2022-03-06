# Copyright (C) 2018  iCub Facility, Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

# For what regards Python installation, the options changes depending
# on whater we are installing blf in the superbuild, or we are generating a
# conda package on Windows as in that case the installation location
# will need to be outside of CMAKE_INSTALL_PREFIX
# See https://github.com/robotology/robotology-superbuild/issues/641
set(icub-models_OPTIONAL_CMAKE_ARGS "")
list(APPEND icub-models_OPTIONAL_CMAKE_ARGS "-DICUB_MODELS_COMPILE_PYTHON_BINDINGS:BOOL=${ROBOTOLOGY_USES_PYTHON}")

ycm_ep_helper(icub-models
              TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/icub-models.git
              TAG master
              COMPONENT iCub
              FOLDER src
              CMAKE_ARGS ${icub-models_OPTIONAL_CMAKE_ARGS})

set(icub-models_CONDA_PKG_NAME icub-models)
set(icub-models_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

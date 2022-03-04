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
if(ROBOTOLOGY_USES_PYTHON AND ROBOTOLOGY_GENERATE_CONDA_RECIPES)
  list(APPEND icub-models_OPTIONAL_CMAKE_ARGS "-DICUB_MODELS_DETECT_ACTIVE_PYTHON_SITEPACKAGES:BOOL=ON")
endif()

ycm_ep_helper(icub-models
              TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/icub-models.git
              TAG master
              COMPONENT iCub
              FOLDER src
              CMAKE_ARGS ${icub-models_OPTIONAL_CMAKE_ARGS})

if(ROBOTOLOGY_USES_PYTHON)
  set(icub-models_CONDA_DEPENDENCIES python)
  list(APPEND icub-models_CONDA_DEPENDENCIES pybind11)
endif()

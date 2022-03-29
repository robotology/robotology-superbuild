# Copyright (C) 2018  iCub Facility, Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

set(icub-models_OPTIONAL_CMAKE_ARGS "")
list(APPEND icub-models_OPTIONAL_CMAKE_ARGS "-DICUB_MODELS_COMPILE_PYTHON_BINDINGS:BOOL=${ROBOTOLOGY_USES_PYTHON}")
list(APPEND icub-models_OPTIONAL_CMAKE_ARGS "-DICUB_MODELS_USES_PYTHON:BOOL=${ROBOTOLOGY_USES_PYTHON}")

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

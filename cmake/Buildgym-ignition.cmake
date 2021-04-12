# Copyright (C) 2021 iCub Facility, Istituto Italiano di Tecnologia
# Authors: Diego Ferigo <diego.ferigo@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(iDynTree QUIET)

ycm_ep_helper(gym-ignition TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/gym-ignition.git
              TAG master
              COMPONENT core
              FOLDER src
              CMAKE_ARGS -DSCENARIO_USE_IGNITION:BOOL=${ROBOTOLOGY_USES_IGNITION}
                         -DSCENARIO_ENABLE_BINDINGS:BOOL=${ROBOTOLOGY_USES_PYTHON}
                         -DBINDINGS_INSTALL_PREFIX:PATH=${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR}
              DEPENDS iDynTree)

# TODO: gym-ignition_CONDA_DEPENDENCIES

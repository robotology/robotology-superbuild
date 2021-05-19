# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT
include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(casadi QUIET)

ycm_ep_helper(casadi-matlab-bindings TYPE GIT
              STYLE GITHUB
              REPOSITORY dic-iit/casadi-matlab-bindings.git
              TAG main
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS -DCASADI_MATLAB_BINDINGS_USES_MATLAB:BOOL=${ROBOTOLOGY_USES_MATLAB}
              DEPENDS casadi)

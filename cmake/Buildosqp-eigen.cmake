# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT
include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(osqp QUIET)

ycm_ep_helper(osqp-matlab TYPE GIT
              STYLE GITHUB
              REPOSITORY dic-iit/osqp-matlab.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS -DOSQP_MATLAB_USES_MATLAB:BOOL=${ROBOTOLOGY_USES_MATLAB}
              DEPENDS osqp)

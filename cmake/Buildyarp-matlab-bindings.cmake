# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

ycm_ep_helper(yarp-matlab-bindings TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/yarp-matlab-bindings.git
              TAG master
              COMPONENT core
              FOLDER robotology
              CMAKE_ARGS -DYARP_USES_MATLAB:BOOL=${ROBOTOLOGY_USES_MATLAB}
                         -DYARP_USES_OCTAVE:BOOL=${ROBOTOLOGY_USES_OCTAVE}
              DEPENDS YARP)

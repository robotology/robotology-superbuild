#.rst:
# BuildqpOASES
# --------
#
# qpOASES

#=============================================================================
# Copyright 2014 iCub Facility, Istituto Italiano di Tecnologia
#   Authors: Daniele E. Domenichelli <daniele.domenichelli@iit.it>
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of YCM, substitute the full
#  License text for the above reference.)

# qpOASES
include(YCMEPHelper)

ycm_ep_helper(qpOASES TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology-dependencies/qpOASES.git
              TAG master
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DQPOASES_BUILD_BINDINGS_MATLAB:BOOL=OFF)

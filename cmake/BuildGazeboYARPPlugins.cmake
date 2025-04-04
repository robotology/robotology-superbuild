#.rst:
# BuildGazeboYARPPlugins
# ----------------------
#
# GazeboYARPPlugins

#=============================================================================
# Copyright 2013-2014 iCub Facility, Istituto Italiano di Tecnologia
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

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

ycm_ep_helper(GazeboYARPPlugins TYPE GIT
                                STYLE GITHUB
                                REPOSITORY robotology/gazebo-yarp-plugins.git
                                TAG master
                                COMPONENT core
                                FOLDER src
                                DEPENDS YARP
                                # CMAKE_POLICY_VERSION_MINIMUM is a workaround for https://github.com/robotology/robotology-superbuild/pull/1837#issuecomment-2778698649
                                CMAKE_ARGS -DGAZEBO_YARP_PLUGINS_HAS_OPENCV:BOOL=ON -DCMAKE_POLICY_VERSION_MINIMUM=3.5)

set(GazeboYARPPlugins_CONDA_PKG_NAME libgazebo-yarp-plugins)
set(GazeboYARPPlugins_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

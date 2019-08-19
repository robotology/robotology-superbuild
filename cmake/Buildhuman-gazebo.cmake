# Copyright (C) 2019  iCub Facility, Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

ycm_ep_helper(human-gazebo TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/human-gazebo.git
              TAG master
              COMPONENT human_dynamics
              FOLDER robotology)

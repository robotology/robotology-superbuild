# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

ycm_ep_helper(icub-gazebo-wholebody
              TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology-playground/icub-gazebo-wholebody.git
              TAG master
              COMPONENT robotology)

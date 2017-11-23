# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

ycm_ep_helper(WBIToolboxControllers TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology-playground/WBI-Toolbox-controllers.git
              TAG master
              COMPONENT robotology)

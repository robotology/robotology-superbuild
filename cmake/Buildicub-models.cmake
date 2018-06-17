# Copyright (C) 2018  iCub Facility, Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

ycm_ep_helper(icub-models
              TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/icub-models.git
              TAG master
              COMPONENT iCub
              FOLDER robotology)

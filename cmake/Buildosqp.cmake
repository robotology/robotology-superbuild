# Copyright (C) 2018  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Stefano Dafarra <stefano.dafarra@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

ycm_ep_helper(osqp TYPE GIT
              STYLE GITHUB
              REPOSITORY oxfordcontrol/osqp.git
              TAG  v0.5.0
              COMPONENT dynamics
              FOLDER external
              CMAKE_ARGS -DUNITTESTS:BOOL=OFF)

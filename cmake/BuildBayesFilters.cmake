# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

ycm_ep_helper(BayesFilters TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/bayes-filters-lib.git
              TAG master
              COMPONENT dynamics
              FOLDER src)

set(BayesFilters_CONDA_PKG_NAME libbayes-filters-lib)
set(BayesFilters_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

# This number needs to be increased at each full rebuild,
# to ensure that binaries belonging to different rebuilds
# can be distinguished even if the version number is the same
if(NOT CONDA_BUILD_NUMBER)
  set(CONDA_BUILD_NUMBER 49)
endif()

# This option is enabled only when the metapackages robotology-distro and robotology-distro-all are
# generated, so only in case a robotology-superbuild distro is released
option(CONDA_GENERATE_ROBOTOLOGY_METAPACKAGES "If on, generate recipes for robotology-distro and robotology-distro-all conda metapackages." OFF)

# This variable is automatically set to contain the robotology-superbuild version in case of releases
if(NOT CONDA_ROBOTOLOGY_SUPERBUILD_VERSION)
  set(CONDA_ROBOTOLOGY_SUPERBUILD_VERSION "")
endif()

# For more conda generation options, check the specific project Build<CMakeProject>.cmake
# file for variables that start with `<CMakeProject>_CONDA`

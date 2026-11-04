# This number needs to be increased at each full rebuild,
# to ensure that binaries belonging to different rebuilds
# can be distinguished even if the version number is the same
if(NOT CONDA_BUILD_NUMBER)
  set(CONDA_BUILD_NUMBER 208)
endif()

# This option is enabled only when the metapackages robotology-distro are
# generated, so only in case a robotology-superbuild distro is released
option(CONDA_GENERATE_ROBOTOLOGY_METAPACKAGES "If on, generate recipes for robotology-distro conda metapackages." OFF)

# This variable is automatically set to contain the robotology-superbuild version in case of releases
if(NOT CONDA_ROBOTOLOGY_SUPERBUILD_VERSION)
  set(CONDA_ROBOTOLOGY_SUPERBUILD_VERSION "")
endif()

# Temporarily rebuild BLF with our Eigen 3.4 and YARP pins. The conda-forge
# builds for YARP 3.12.3 require Eigen 5. Remove when we migrate to Eigen 5.
set(bipedal-locomotion-framework_CONDA_PKG_CONDA_FORGE_OVERRIDE OFF)
# Robometry 2 is available on conda-forge for YARP 3.12.3 without Boost.
# Require it so the solver cannot fall back to the Boost-dependent 1.x builds.
set(bipedal-locomotion-framework_CONDA_DEPENDENCIES
    eigen fmt spdlog tomlplusplus nlohmann_json tiny-process-library libopencv
    "librobometry >=2.0.0")
# These public header dependencies do not provide run_exports.
set(bipedal-locomotion-framework_CONDA_RUN_DEPENDENCIES_EXPLICIT
    manif tomlplusplus "eigen >=3.4.0,<4.0a0")
# This recipe bundles the C++ library and Python bindings. Prevent the
# conda-forge split packages from installing a second copy of the same files.
set(bipedal-locomotion-framework_CONDA_RUN_CONSTRAINTS
    "libbipedal-locomotion-framework <0a0" "bipedal-locomotion-framework-python <0a0")
# The conda-forge package with the same name is a metapackage for a different
# Eigen build. Consumers must retain the exact BLF build used for compilation.
set(bipedal-locomotion-framework_CONDA_RUN_EXPORTS_EXACT ON)

if(ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS)
  list(APPEND bipedal-locomotion-framework_CONDA_DEPENDENCIES qhull onnxruntime-cpp)
endif()

if(ROBOTOLOGY_USES_PCL_AND_VTK)
  # VTK 9.7 has no Eigen 3 builds. A recipe constraint takes precedence over
  # the conda-forge variant pin, without changing VTK for other recipes.
  list(APPEND bipedal-locomotion-framework_CONDA_DEPENDENCIES pcl "vtk <9.7" libboost-devel)
endif()

if(ROBOTOLOGY_USES_PYTHON)
  list(APPEND bipedal-locomotion-framework_CONDA_DEPENDENCIES python pybind11 pybind11-abi)
  list(APPEND bipedal-locomotion-framework_CONDA_RUN_DEPENDENCIES_EXPLICIT python manifpy)
endif()

# For more conda generation options, check the specific project Build<CMakeProject>.cmake
# file for variables that start with `<CMakeProject>_CONDA`

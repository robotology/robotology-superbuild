# Changelog
All notable changes to this project will be documented in this file.

The format of this document is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Added
- Added dependency on `graphviz` to compile `yarpviz` YARP tool (https://github.com/robotology/robotology-superbuild/pull/988).
 
### Changed
- On Windows the option `ROBOTOLOGY_USES_ESDCAN` is now enabled when generating conda packages (https://github.com/robotology/robotology-superbuild/pull/935).
- For the YARP package, the compilation of the `usbCamera` device on Linux is enabled even if `ROBOTOLOGY_ENABLE_ICUB_HEAD` is `OFF` (https://github.com/robotology/robotology-superbuild/pull/989).
- `walking-controllers` now depends on `bipedal-locomotion-framework`, so it is now compiled if `ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS` option is enabled (https://github.com/robotology/robotology-superbuild/pull/1013).

## [2021.11.1] - 2022-01-05

### Fixed
- Backport several bugfixes (https://github.com/robotology/robotology-superbuild/pull/982).

## [2021.11.0] - 2021-12-06

### Changed
- Enable the compilation of the `bcbBattery` device on `icub-main` when using the `ICUB_HEAD` profile (https://github.com/robotology/robotology-superbuild/pull/912).
- Added `assimp` dependency and enabled `IDYNTREE_USES_ASSIMP` option in iDynTree (https://github.com/robotology/robotology-superbuild/pull/918).

### Fixed
- Fixed the values assigned to the `AMENT_PREFIX_PATH` environment variable for ROS2 compatibility (https://github.com/robotology/robotology-superbuild/pull/868).
- Fixed the missing dependency of `bipedal-locomotion-framework` on `UnicyclePlanner` (https://github.com/robotology/robotology-superbuild/pull/909).

## [2021.08] - 2021-08-31

### Added
- Add `nlohmann-json` dependency to the superbuild (https://github.com/robotology/robotology-superbuild/pull/776).
- In `YARP`, all the `fake***` YARP devices are now enabled (https://github.com/robotology/robotology-superbuild/pull/797).
- `pybind11` has been added as dependency for the `ROBOTOLOGY_USES_PYTHON` option (https://github.com/robotology/robotology-superbuild/pull/800), to enable compilation of Python bindings of `manif` and `bipedal-locomotion-framework`.
- `ycm-cmake-modules`, `osqp-eigen`, `robot-testing-framework` and `idyntree` conda packages are now part of the `conda-forge` channel. The new `idyntree-matlab-bindings` package is now contained in the `robotology` channel (https://github.com/robotology/robotology-superbuild/pull/807, https://github.com/robotology/robotology-superbuild/pull/817).
- The `idyntree-yarp-tools` was added to the Dynamics component of the superbuild (https://github.com/robotology/robotology-superbuild/pull/818).
- An `apt.txt` file and a `scripts/install_apt_dependencies.sh` script have been added to the superbuild to report the required apt packages in a machine readable form. People that mantain either Docker recipes or documentation on how to instal the robotology-superbuild are suggest to switch to use these files instead of hardcoding the dependencies manually (https://github.com/robotology/robotology-superbuild/pull/825). 

### Deprecated
- This release is the last one with Gazebo 9/10 support. From the next release, Gazebo 11 will be required (https://github.com/robotology/community/discussions/534).
- The Homebrew-based installation procedure is deprecated, and the release 2021.11 will be the last one with support for it (https://github.com/robotology/robotology-superbuild/issues/842).

### Fixed
- The `human-dynamics-estimation` project as been renamed to `HumanDynamicsEstimation` for consistency with the CMake name of the project (https://github.com/robotology/robotology-superbuild/pull/844).
- Added the missing dependency of `walking-teleoperation` on `HumanDynamicsEstimation` (https://github.com/robotology/robotology-superbuild/pull/844).

## [2021.05] - 2021-05-31

### Added
- Add support for installing robotology superbuild packages as Conda binary packages (https://github.com/robotology/robotology-superbuild/blob/master/doc/conda-forge.md, https://github.com/robotology/robotology-superbuild/pull/652).
- Add `spdlog` dependency to the superbuild (https://github.com/robotology/robotology-superbuild/pull/645)
- Add `YARP_telemetry` component to the Dynamics profile (https://github.com/robotology/robotology-superbuild/pull/677).
- Append `<superbuild_install_prefix>/share` to `XDG_DATA_DIRS` to enable YARP auto completion on Bash terminal (https://github.com/robotology/robotology-superbuild/pull/759).
- Add `casadi-matlab-bindings` package containing the MATLAB bindings for CasADi. The package is enabled if ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS is ON and ROBOTOLOGY_USES_MATLAB is ON (https://github.com/robotology/robotology-superbuild/pull/747).
- Add `matlab-whole-body-simulator` package (https://github.com/robotology/robotology-superbuild/pull/689).
- Add `osqp-matlab` package (https://github.com/robotology/robotology-superbuild/pull/585).
- Add `gym-ignition` package and the relative `ROBOTOLOGY_USES_IGNITION` option (https://github.com/robotology/robotology-superbuild/pull/685). 

### Removed
- The `icub-gazebo` project was removed from the superbuild (https://github.com/robotology/robotology-superbuild/pull/646).
- The `ROBOTOLOGY_USES_MATLAB` is not enable in Windows/vcpkg installer. Windows binaries for MATLAB/Simulink projects are avalable in Windows/conda, including in the form of One-line installation script (https://github.com/robotology/robotology-superbuild/blob/master/doc/matlab-one-line-install.md, https://github.com/robotology/robotology-superbuild/pull/775).

## [2021.02] - 2021-02-25

### Changed
- All the subproject repos are now cloned in `robotology-superbuild/src` and the corresponding build directories are created in `robotology-superbuild/build/src` ( https://github.com/robotology/community/discussions/451 ).
- iDynTree is now compiled with the `IDYNTREE_USES_IRRLICHT` option. As a consequence, [`irrlicht`](http://irrlicht.sourceforge.net/) has been added as a dependency on all supported platforms (https://github.com/robotology/robotology-superbuild/pull/618).
- The `GAZEBO_YARP_PLUGINS_HAS_OPENCV` CMake option of `gazebo-yarp-plugins` is now set to `ON` (https://github.com/robotology/robotology-superbuild/pull/619).

### Deprecated 
- The `icub-gazebo` repository has been deprecated and will be removed in 2021.05 release.

### Removed
- The `icub-gazebo-wholebody` project was removed from the superbuild (https://github.com/robotology/robotology-superbuild/issues/543, https://github.com/robotology/robotology-superbuild/pull/555).
- Support for compiling the `MATLAB` bindings of qpOASES have been removed (https://github.com/robotology/robotology-superbuild/pull/613).



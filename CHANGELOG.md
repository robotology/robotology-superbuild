# Changelog
All notable changes to this project will be documented in this file.

The format of this document is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

## [2021.05] - 2021-05-31

### Added
- Add support for installing robotology superbuild packages as Conda binary packages (https://github.com/robotology/robotology-superbuild/blob/master/doc/conda-forge.md, https://github.com/robotology/robotology-superbuild/pull/652).
- Add spdlog dependency to the superbuild (https://github.com/robotology/robotology-superbuild/pull/645)
- Add `YARP_telemetry` component to the Dynamics profile (https://github.com/robotology/robotology-superbuild/pull/677).
- Append `<superbuild_install_prefix>/share` to `XDG_DATA_DIRS` to enable YARP auto completion on Bash terminal (https://github.com/robotology/robotology-superbuild/pull/759).
- Add `casadi-matlab-bindings` package containing the MATLAB bindings for CasADi. The package is enabled if ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS is ON and ROBOTOLOGY_USES_MATLAB is ON (https://github.com/robotology/robotology-superbuild/pull/747).
- Add `matlab-whole-body-simulator` package (https://github.com/robotology/robotology-superbuild/pull/689).
- Add `osqp-matlab` package (https://github.com/robotology/robotology-superbuild/pull/585).
- Add `gym-ignition` package and the relative `ROBOTOLOGY_USES_IGNITION` option (https://github.com/robotology/robotology-superbuild/pull/685). 

### Removed
- The `icub-gazebo` project was removed from the superbuild (https://github.com/robotology/robotology-superbuild/pull/646).

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



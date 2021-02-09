# Changelog
All notable changes to this project will be documented in this file.

The format of this document is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Changed
- All the subproject repos are now cloned in `robotology-superbuild/src` and the corresponding build directories are created in `robotology-superbuild/build/src` ( https://github.com/robotology/community/discussions/451 ).
- The `GAZEBO_YARP_PLUGINS_HAS_OPENCV` CMake option of `gazebo-yarp-plugins` is now set to `ON` (https://github.com/robotology/robotology-superbuild/pull/619).

### Removed
- The `icub-gazebo-wholebody` project was removed from the superbuild (https://github.com/robotology/robotology-superbuild/issues/543, https://github.com/robotology/robotology-superbuild/pull/555).

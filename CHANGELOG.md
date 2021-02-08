# Changelog
All notable changes to this project will be documented in this file.

The format of this document is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Changed
- All the subproject repos are now cloned in `robotology-superbuild/src` and the corresponding build directories are created in `robotology-superbuild/build/src` ( https://github.com/robotology/community/discussions/451 ).

### Removed
- The `icub-gazebo-wholebody` project was removed from the superbuild (https://github.com/robotology/robotology-superbuild/issues/543, https://github.com/robotology/robotology-superbuild/pull/555).
- Support for compiling the `MATLAB` bindings of qpOASES have been removed (https://github.com/robotology/robotology-superbuild/pull/613).

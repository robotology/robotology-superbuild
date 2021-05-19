Developers' Frequently Asked Questions (FAQs)
===========================================

##  How to add a new package
* Decide in which "profile" of the superbuild the project should be installed
* If the software package is available on GitHub and can be built with CMake (the most common case), just add a `Build<package>.cmake` in  the `cmake` directory of the superbuild. You can take inspiration from the `Build***.cmake` files already available, but if you want to add a package that is called <package>, that dependens on CMake packages `<pkgA>`, `<pkgB>` and `<pkgC>` and is available at `https://github.com/robotology/<package-repo-name>` and that is part of profile <profile>, you can add it based on this template:
~~~cmake
# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(<pkgA> QUIET)
find_or_build_package(<pkgB> QUIET)
find_or_build_package(<pkgC> QUIET)

ycm_ep_helper(<package> TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/<package-repo-name>.git
              TAG master
              COMPONENT <profile>
              FOLDER robotology
              DEPENDS <pkgA>
                      <pkgB>
                      <pkgC>)
~~~
* Add `find_or_build_package(<package>)` in the `cmake/RobotologySuperbuildLogic.cmake` file, under the `if(ROBOTOLOGY_ENABLE_<profile>)` of the selected profile.
* If the package is important "enough" (it was not added just because it is a dependency) added it to the table in [`doc/cmake-options.md#profile-cmake-options`](cmake-options.md#profile-cmake-options) .
* If the dependencies of the packages are available in `apt`, `homebrew` or Windows installers, document how to install them in the profile docs in the README. If any dependency is not available through this means, add it as a new package of the superbuid.
* For more details, see  upstream YCM docs http://robotology.github.io/ycm/gh-pages/latest/manual/ycm-superbuild-example.7.html#superbuild-example-developer-point-of-view

## How to add a new profile
* Decide a name for the profile and decide who will be the mantainer of the profile
* Add the profile name in [`doc/cmake-options.md#profile-cmake-options`](cmake-options.md#profile-cmake-options) and the mantainer name in https://github.com/robotology/robotology-superbuild#mantainers .
* Add the `ROBOTOLOGY_ENABLE_<profile>` CMake option in the file `cmake/RobotologySuperbuildOptions.cmake`
* Add any new package required by the profile to the superbuild, following the instructions in "How to add a new package" FAQ
* Add a part of code with a `find_or_build_package(<pkg1_profile>)`  in the `cmake/RobotologySuperbuildLogic.cmake` file, guarded by the `if(ROBOTOLOGY_ENABLE_<profile>)` clause, something like:
~~~cmake
if(ROBOTOLOGY_ENABLE_<profile>)
  find_or_build_package(<pkg1_profile>)
  find_or_build_package(<pkg2_profile>)
endif()
~~~
* Add the profile documentation in [`doc/cmake-options.md#profile-specific-documentation`](cmake-options.md#profile-specific-documentation). Take inspiration from the documentation of existing profiles. If the profile need a specific enviroment variable to be set of a value to be appended (such as `YARP_DATA_DIRS`), document it in the documentation and add it in the templates in https://github.com/robotology/robotology-superbuild/blob/master/cmake/template and in [`doc/environment-variables-configuration.md`](environment-variables-configuration.md).
* Add the profile option in the `.ci/initial-cache.ci.cmake`, so it will be tested in the Continuous Integration and binaries will be generated for it.

## How to bump the version of a subproject
* The superbuild contains a `releases/latest.releases.yaml` file that is meant to contain the latest release of each subproject of the superbuild.
* This file is automatically updated by the `update-latest-releases.yml` GitHub action, that periodically checks the default branches of the repo (the one used if `ROBOTOLOGY_PROJECT_TAGS` is set to `Stable`) and extract the latest tag done on that branch. The action can also be run manually using the [`workflow_dispatch` event](https://github.blog/changelog/2020-07-06-github-actions-manual-triggers-with-workflow_dispatch/).
* If you have any project for which you want to manually manage the release used in the `releases/latest.releases.yaml` file,
you can disable the automatical update of the tags by adding its CMake name in the `projects_to_skip` array in the `scripts/robotologyUpdateLatestReleases.sh` script.

## How to do a new release
To do a new release, just run via [`workflow_dispatch`](https://github.blog/changelog/2020-07-06-github-actions-manual-triggers-with-workflow_dispatch/) the [`release` GitHub Actions workflow](https://github.com/robotology/robotology-superbuild/actions/workflows/release.yml) on the `master` branch.

This action will automatically perform the following steps:
* It copies the `releases/latest.releases.yaml` file in `releases/yyyy.mm.yaml` file, containing the version of package contained in the new release.
* It creates a `releases/yyyy.mm` branch from `master`
* On the branch `releases/yyyy.mm`, it modifies the default value of the `ROBOTOLOGY_PROJECT_TAGS` CMake option to be `Custom` and of the `ROBOTOLOGY_PROJECT_TAGS_CUSTOM_FILE` to the point to the `yyyy.mm.yaml` file.
* It creates a new tag and release `vyyyy.mm` on the  `releases/yyyy.mm` branch



## How to ensure that binary packages are correctly generated for a new package
* If the package is already available in [`conda-forge`](https://conda-forge.org), then no binary should be created and the `conda-forge` version should be used. This is done by setting in the `Build<pkg>.cmake` file the `<pkg>_CONDA_PKG_NAME` variable to the name of the package in `conda-forge`, and setting to `ON` the `<pkg>_CONDA_PKG_CONDA_FORGE_OVERRIDE` variable. For an example of such package, see [Buildosqp.cmake](../cmake/Buildosqp.cmake).
* If instead the package is not part of conda-forge, then it is appropriate to generate a binary package as part of the `robotology` channel, providing the following CMake options in the `Build<pkg>.cmake` file:

| Variable | Meaning | Default Value |
|:--------:|:-------:|:--------------:|
| `<pkg>_CONDA_PKG_NAME`  | The name that will be used for the conda package name. The convention is to use lowercase names separated by dashes. | The name of the github repo of the package. | 
| `<pkg>_CONDA_DEPENDENCIES` | The list of conda-forge dependencies required by this package. Note that dependencies managed by the robotology-superbuild should not be listed, as those are handled automatically. | The default value is empty. |
| `<pkg>_CONDA_VERSION` | The version that will be used for the conda package, by default it is not set as the value from the tag will be extracted. | The default value is to use the value of the tag, removing any occurence of the `v` letter. |

For any doubt, double check the existing `Build<pkg>.cmake` files for inspiration.
* If your package needs to set or modify some environment variables to work correctly, it should provide a pair of [multisheller](https://github.com/wolfv/multisheller) scripts named `<condaPkgName>_activate.msh` and `<condaPkgName>_deactivate.msh` in the `conda/multisheller` directory to describe how the environment should be modified. Refer to the existing scripts for more details.


## How often are conda binary packages generated?
* The conda binaries hosted in the [robotology conda channel](https://anaconda.org/robotology) are re-generated weekly by [`generate-conda-packages`](../.github/workflows/generate-conda-packages.yaml) GitHub Action CI job. At each new re-build, remember to bump the `CONDA_BUILD_NUMBER` in the [`conda/cmake/CondaGenerationOptions.cmake`](../conda/cmake/CondaGenerationOptions.cmake) file. The latest released version of the packages, as specified in the [`releases/latest.releases.yaml`](../releases/latest.releases.yaml) file is used to generate the binaries, that is in turn updated weekly automatically by the [`update-latest-releases`](../.github/workflows/update-latest-releases.yml) GitHub Action CI job. If you need to quickly generate a new binary for a new release, feel free to [open an issue to request that](https://github.com/robotology/robotology-superbuild/issues/new).

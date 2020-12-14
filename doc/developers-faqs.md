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
* If the package is important "enough" (it was not added just because it is a dependency) added it to the table in [`doc/profile.md#profile-cmake-options`](profiles.md#profile-cmake-options) .
* If the dependencies of the packages are available in `apt`, `homebrew` or Windows installers, document how to install them in the profile docs in the README. If any dependency is not available through this means, add it as a new package of the superbuid.
* For more details, see  upstream YCM docs http://robotology.github.io/ycm/gh-pages/latest/manual/ycm-superbuild-example.7.html#superbuild-example-developer-point-of-view

## How to add a new profile
* Decide a name for the profile and decide who will be the mantainer of the profile
* Add the profile name in [`doc/profile.md#profile-cmake-options`](profiles.md#profile-cmake-options) and the mantainer name in https://github.com/robotology/robotology-superbuild#mantainers .
* Add the `ROBOTOLOGY_ENABLE_<profile>` CMake option in the file `cmake/RobotologySuperbuildOptions.cmake`
* Add any new package required by the profile to the superbuild, following the instructions in "How to add a new package" FAQ
* Add a part of code with a `find_or_build_package(<pkg1_profile>)`  in the `cmake/RobotologySuperbuildLogic.cmake` file, guarded by the `if(ROBOTOLOGY_ENABLE_<profile>)` clause, something like:
~~~cmake
if(ROBOTOLOGY_ENABLE_<profile>)
  find_or_build_package(<pkg1_profile>)
  find_or_build_package(<pkg2_profile>)
endif()
~~~
* Add the profile documentation in [`doc/profile.md#profile-specific-documentation`](profiles.md#profile-specific-documentation). Take inspiration from the documentation of existing profiles. If the profile need a specific enviroment variable to be set of a value to be appended (such as `YARP_DATA_DIRS`), document it in the documentation and add it in the templates in https://github.com/robotology/robotology-superbuild/blob/master/cmake/template and in [`doc/environment-variables-configuration.md`](environment-variables-configuration.md).
* Add the profile option in the `.ci/initial-cache.ci.cmake`, so it will be tested in the Continuous Integration and binaries will be generated for it.

## How to do a new release
* Sometime before the release, add a `yyyy.mm.yaml` file in https://github.com/robotology/robotology-superbuild/tree/master/releases, containing the version of package contained in the new release.
* Modify the CI scripts to start testing the `yyyy.mm.yaml`
* Once the release is ready to be made, create a `releases/yyyy.mm` branch from `master`
* On the branch `releases/yyyy.mm` modify the default value of the `ROBOTOLOGY_PROJECT_TAGS` CMake option to be `Custom` and of the `ROBOTOLOGY_PROJECT_TAGS_CUSTOM_FILE` to the point to the `yyyy.mm.yaml` file.
* Create a new tag and release `vyyyy.mm` on the  `releases/yyyy.mm` branch

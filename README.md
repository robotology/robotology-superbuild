# robotology-superbuild

This is a meta repository (so-called "superbuild") that uses [CMake](https://cmake.org/) and [YCM](https://github.com/robotology/ycm) to automatically
download and compile software developed in the robotology GitHub organization, such as the YARP middleware or software used to run the iCub humanoid robot.

[CMake](https://cmake.org/) is an open-source, cross-platform family of tools designed to build, test and package software.
A [YCM Superbuild](http://robotology.github.io/ycm/gh-pages/git-master/index.html#superbuild) is a CMake project whose only goal is to download and build several other projects.
If you are familiar with ROS, it is something similar to [catkin](http://wiki.ros.org/catkin/workspaces) or [colcon workspace](https://colcon.readthedocs.io/en/released/user/quick-start.html), but using pure CMake for portability reasons and for customizing the build via CMake options. Furthermore, the `robotology-superbuild` also contains some infrastructure to build **binaries** of the contained projects for some platforms. 
You can read more about the superbuild concept in [YCM documentation](http://robotology.github.io/ycm/gh-pages/latest/index.html) or in the [related IRC paper](http://lornat75.github.io/papers/2018/domenichelli-irc.pdf).

| System  | Continuous Integration Status |
|:------:|:------:|
|  Linux/macOS/Windows  |  ![GitHub Actions Status](https://github.com/robotology/robotology-superbuild/workflows/C++%20CI%20Workflow/badge.svg)     |

Table of Contents
=================
  * [Superbuild](#superbuild)
  * [Binary Installation](#binary-installation)
  * [Source Installation](#source-installation)
    * [Clone the repo](#clone-the-repo)
    * [Debian/Ubuntu Linux with dependencies provided by apt](#linux-from-source-with-dependencies-provided-by-apt)
    * [Linux, macOS or Windows with dependencies provided by conda-forge](#linux-macos-or-windows-from-source-with-dependencies-provided-by-conda-forge)
    * [Update](#update)
  * [FAQs](#faqs)
  * [Mantainers](#mantainers)

Superbuild 
==========

The `robotology-superbuild` is an infrastructure to simplify development and use of **open source research software** developed at the **[Italian Institute of Technology](https://iit.it/)**, in particular as part of the **[iCub project](https://icub.iit.it/)**. 

### Profiles and Optional Dependencies
As a huge number of software projects are contained in the `robotology-superbuild`, and a tipical user is only interested in some of them, there are several **options** to instruct the superbuild on which packages should be built and which one should not be built. In particular, the robotology-superbuild is divided in different **profiles**, that specify the specific subset of robotology packages to build. You can read more on the available **profiles** and how to enable them in the [`doc/cmake-options.md#profile-specific-documentation`](doc/cmake-options.md#profile-specific-documentation).

Furthermore, some **dependencies** of software contained in the `robotology-superbuild` are either tricky to install or proprietary, and for this reason software that depends on those  optional dependencies can be **enabled** or **disabled** with specific options,as documented in [`doc/cmake-options.md#dependencies-specific-documentation`](doc/cmake-options.md#dependencies-specific-documentation).

### Versioning
For what regards versioning, software in the robotology-superbuild can be consumed in two forms: 

#### [Rolling update](https://en.wikipedia.org/wiki/Rolling_release)
In this form, the superbuild will get the latest changes for a branch of each subproject, and will build it. This has the advantage that you get all the latest changes from the software contained in the `robotology-superbuild`, while the downside that the specific software that you use may change at each update. The **rolling update** can be used only when building robotology-superbuild software **from source**. By default, the `robotology-superbuild` uses the latest "stable" branches of the robotology repositories, but in some cases it may be necessary to use the "unstable" active development branches. For this advanced functionalities, please refer to the documentation on changing the default project tags, available at [`doc/change-project-tags.md`](doc/change-project-tags.md).


#### [Releases](https://en.wikipedia.org/wiki/Software_release_life_cycle)
Once every three months, a set of releases of the software in the robotology-superbuild is freezed and used as a "Distro Release", following the policies of iCub software described in https://icub-tech-iit.github.io/documentation/sw_versioning_table/ . **Releases** can be used both when **building the software from source**, and when obtaining it **from binaries**.

The available releases can be seen on [GitHub's release page](https://github.com/robotology/robotology-superbuild/releases).

Binary Installation
===================

We provide binary packages for Linux, macOS and Windows of the software contained in the robotology-superbuild via the [conda package manager](https://docs.conda.io), relying on the community-mantained [`conda-forge`](https://conda-forge.org/) channel and for some packages on on our own `robotology` conda channel. 

Please refer to [`doc/conda-forge.md`](doc/conda-forge.md) document for instruction on how to install the conda binary packages, in particualr the [`Binary Installation`](doc/conda-forge.md#binary-installation) section.

Note that the default binary installed by the conda package manager is the latest available, so if you need to get exactly the version corresponding to a specific robotology-superbuild distro release (for example for compatibility with an existing robot setup), please install the required versions by inspecting the version tables of the specific distro you are interested in https://icub-tech-iit.github.io/documentation/sw_versioning_table/ .

If you need to use the robotology packages with dependencies provided by other package managers, for example with the `apt`packages on Debina/Ubuntu distributions, please install [robotology-superbuild from source code](#source-installation) as explained in the approprate section, as we do not provide binary packages for all software contained in the robotology-superbuild for the `apt` package manager.

We also support a deprecated way of installing binary packages just on Windows using dependencies provided by [vcpkg](https://vcpkg.io/), documentation for it can be found in [`doc/deprecated-installation-methods.md`](doc/deprecated-installation-methods.md#windows-from-binary-installer-generated-with-vcpkg-dependencies). However for new deployments we recommend to use `conda` binary packages also on Windows.

Source Installation
===================

## Clone the repo
The first step to install `robotology-superbuild` from source is to download the `robotology-superbuild` code itself, and this is done through [Git](https://git-scm.com/).

Once you install Git, you need to set your name and email to sign your commits, as this is required by the superbuild:
```
git config --global user.name FirstName LastName
git config --global user.email user@email.domain
```

Once git is configured, you can open a command line terminal. If you want to use the `robotology-superbuild` in **rolling update** mode, just clone the superbuild:
~~~
git clone https://github.com/robotology/robotology-superbuild
~~~
this will clone the superbuild in its default branch.

You can download and use the `robotology-superbuild` anywhere on your system, but if you are installing it 
on an [**iCub robot laptop** following the official iCub instructions](https://icub-tech-iit.github.io/documentation/icub_operating_systems/other-machines/generic-machine/), you should clone it in the `/usr/local/src/robot` directory.

If instead you want to use a **specific release** of the robotology superbuild, after you clone switch to use to a specific release tag: 
~~~
git checkout v<YYYY.MM>
~~~

For the list of actually available tags, see the [GitHub's releases page](https://github.com/robotology/robotology-superbuild/releases).

Once you cloned the repo, to go forward you can follow the different instructions on how to install robotology-superbuild from the source code, depending on your operating system and the package manager you want to use to install the required dependencies:
* [**Linux with dependencies provided by apt**](#linux-from-source-with-dependencies-provided-by-apt): use the superbuild on Debian/Ubuntu distributions installing the dependencies with apt,
* [**Linux, macOS or Windows with dependencies provided by conda-forge**](#linux-macos-or-windows-from-source-with-dependencies-provided-by-conda-forge): use the superbuild on any supported operating system, installing the dependencies with conda package manager,
* [**Windows Subsystem For Linux**](#windows-subsystem-for-linux-from-source): use the superbuild on [Windows Subsystem For Linux](https://docs.microsoft.com/en-us/windows/wsl/about).

The exact versions of the operating systems supported by the robotology-superbuild follow the one supported by the YARP library, that are documented in https://github.com/robotology/yarp/blob/master/.github/CONTRIBUTING.md#supported-systems .

Complete documentation on how to use a YCM-based superbuild is available in the [YCM documentation](http://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-superbuild.7.html).

When compiled from source, `robotology-superbuild` will download and build a number of software.
For each project, the repository will be downloaded in the `src/<package_name>` subdirectory of the superbuild root. 
The build directory for a given project will be instead the `src/<package_name>` subdirectory of the superbuild build directory. 
All the software packages are installed using the `install` directory of the build as installation prefix.

We also support two additional deprecated ways of compiling the superbuild, on Windows using dependencies provided by [vcpkg](https://vcpkg.io/) or on macOS using dependencies provided by Homebrew](https://brew.sh/). Documentation for them can be found in [`doc/deprecated-installation-methods.md`](doc/deprecated-installation-methods.md). 

## Linux from source with dependencies provided by apt
### System Dependencies
On Debian based systems (as Ubuntu) you can install the C++ toolchain, Git, CMake and Eigen (and other dependencies necessary for the software include in `robotology-superbuild`) using `apt-get`. This can be done by installing the packages listed in the `apt.txt` file using the following script:
~~~
cd robotology-superbuild
sudo bash ./scripts/install_apt_dependencies.sh
~~~

Besides the packages listed in `apt.txt` file, the script `install_apt_dependencies.sh` also installs some other packages depending on the distribution used, please inspect the script for more information.

For what regards CMake, the robotology-superbuild requires CMake 3.16 . If you are using a recent Debian-based system such as Ubuntu 20.04, the default CMake is recent enough and you do not need to do further steps.

If instead you use an older distro in which the default version of CMake is older, you can easily install a newer CMake version in several ways. For the following distributions, we recommend the following methods:  
* Ubuntu 18.04 : use the latest CMake release in the [Kitware APT repository](https://apt.kitware.com/). You can find the full instructions for the installation on the website.
* Debian 10 : use the CMake in the `buster-backports` repository, following the instructions to install from backports available in  [Debian documentation](https://backports.debian.org/Instructions/).
More details can be found at https://github.com/robotology/QA/issues/364 .

If you enabled any [profile](doc/cmake-options.md#profile-cmake-options) or [dependency](doc/cmake-options.md#dependencies-cmake-options) specific CMake option you may need to install additional system dependencies, following the dependency-specific documentation (in particular, the `ROBOTOLOGY_USES_GAZEBO` option is enabled by default, so you should install Gazebo unless you plan to disable this option):
* [`ROBOTOLOGY_USES_GAZEBO`](doc/cmake-options.md#gazebo)

### Compile the superbuild

Finally it is possible to install robotology software using the YCM superbuild:
```bash
cd robotology-superbuild
mkdir build
cd build
ccmake ../
make
```
You can configure the ccmake environment if you know you will use some particular set of software (put them in "ON").
See [Superbuild CMake options](doc/cmake-options.md#superbuild-cmake-options) for a list of available options.

### Configure your environment
The superbuild provides an automatically generated `setup.sh` sh script that will set all the necessary enviromental variables to use the software installed in the robotology-superbuild. To do so automatically for any new terminal that you open, append the following line to the `.bashrc` file:
```
source <directory-where-you-downloaded-robotology-superbuild>/build/install/share/robotology-superbuild/setup.sh
```

To use the updated `.bashrc` in your terminal you should run the following command:
```bash
user@host:~$ source ~/.bashrc
```
If may also be necessary to updates the cache of the dynamic linker:
```bash
user@host:~$ sudo ldconfig
```

If for any reason you do not want to use the provided `setup.sh` script and you want to manage your enviroment variables manually, please refer to the documentation available at [`doc/environment-variables-configuration.md `](doc/environment-variables-configuration.md).

## Linux, macOS or Windows from source with dependencies provided by conda-forge

Please refer to [`doc/conda-forge.md`](doc/conda-forge.md) document for instruction on how to compile the superbuild from source using the conda-forge provided dependencies, in particular the [`Source Installation`](doc/conda-forge.md#source-installation) section.

## Windows Subsystem for Linux from source
The [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl) (wsl)  lets developers run a GNU/Linux environment -- including most command-line tools, utilities, and applications -- directly on Windows, unmodified.

As all the software running on Linux distributions can run unmodified on Windows via WSL, to install the robotology-superbuild in WSL you can just install a Debian-based distribution for WSL, and then follow the instructions on how to install the robotology-superbuild on Linux, with dependencies provided either by apt or by conda. As the WSL enviroment is nevertheless different, there are a few things you need to care before using the robotology-superbuild on WSL, that are listed in the following, depending on whetever you are using WSL2 or WSL1.

### WSL2

#### Run graphical applications on WSL2
The Linux instance in WSL2 are running as part of a lightweight virtual machine, so effectively the IP address of the WSL2 instance will be different from the IP address
of the Windows host, and the Windows host can communicate with the WSL2 instance thanks to a virtual IP network. For this reason, to run graphical applications on WSL2, you
first need to install an X Server for Windows. Furthermore, you will need to configure your application to connect to the X Server that is running on the Windows host, you can do
so by adding the following lines in the `~/.bashrc` file of the WSL2 instance:
~~~
export WINDOWS_HOST=$(grep nameserver /etc/resolv.conf | awk '{print $2}')
export DISPLAY=${WINDOWS_HOST}:0.0
~~~
As unfortunately the IP addresses of the virtual IP network change at every reboot, it is also necessary to configure the X Server that you use to accept connection for arbitrary IP addresses. Check  [`doc/wsl2-xserver-configuration.md`](doc/wsl2-xserver-configuration.md) for instructions on how to do so on several X Servers.

#### Sanitize PATH enviroment variable for WSL2
By default, the `PATH` enviroment variable in WSL will contain the path of the host Windows system, see https://github.com/microsoft/WSL/issues/1640 and https://github.com/microsoft/WSL/issues/1493. This can create problems,
as the CMake in WSL may find (incompatible) Windows CMake packages and try to use them, creating errors due to the compilation.
To avoid that, you can create in your WSL2 instance the `/etc/wsl.conf` file, and then populate it with the following content:
~~~
[interop]
appendWindowsPath = false
~~~
Note that you will need to restart your machine to make sure that this setting is taked into account.

#### Connect to a YARP server on a Windows host on WSL2
If you want your YARP applications on WSL2 to connect to a `yarpserver` that you launched on the Windows host, you need to add the following line to your WSL's `~/.bashrc`:
~~~
yarp conf ${WINDOWS_HOST} 10000 > /dev/null 2>&1
~~~
where `WINDOWS_HOST` needs to be defined as in "Run graphical applications on WSL2" section.


### WSL1
With respect to WSL2, WSL1 uses the same IP address used by the Windows machine, so the amount of configuration and tweaks required are less.

#### Run graphical applications on WSL1
To run graphical applications on WSL, you need to install a X Server for Windows, that will be able to visualize the windows WSL-based applications, see https://www.howtogeek.com/261575/how-to-run-graphical-linux-desktop-applications-from-windows-10s-bash-shell/ for more info. For information of X Servers that can be installed on Windows, follow the docs in https://github.com/sirredbeard/Awesome-WSL#10-gui-apps .

#### Sanitize enviroment variables for WSL1
By default, the `PATH` enviroment variable in WSL will contain the path of the host Windows system, see https://github.com/microsoft/WSL/issues/1640 and https://github.com/microsoft/WSL/issues/1493. This can create problems,
as the CMake in WSL may find (incompatible) Windows CMake packages and try to use them, creating errors due to the compilation.
To avoid that, you can add the following line in the WSL `.bashrc` that filters all the Windows paths from the WSL's enviromental variables:
~~~
for var in $(env | awk {'FS="="} /\/mnt\//{print $1}'); do export ${var}=\"$(echo ${!var} | awk -v RS=: -v ORS=: '/\/mnt\// {next} {print $1}')\" ; done
~~~

## Update
If you are using the `robotology-superbuild` in its default branch and not from a release tag (i.e. in **rolling update** mode), to update the superbuild you need to first update the 
`robotology-superbuild` repository itself with the git command:
~~~
git pull
~~~

After that, you will need to also run the equivalent of `git pull` on all the repositories managed by
the robotology-superbuild, you have to run in your build system the appropriate target.

To do this, make sure to be in the `build` directory of the `robotology-superbuild` and run:
~~~
make update-all
make
~~~
using make on Linux or macOS or
~~~
cmake --build . --target ALL_UPDATE
cmake --build .
~~~
using Visual Studio on Windows or
~~~
cmake --build . --target ALL_UPDATE
cmake --build .
~~~
using Xcode on macOS.

Note that the update will try to update all the software in the `robotology-superbuild`, and it will complain if the repository is not in the expected branch.
For this reason, if you are activly developing on a repository managed by the `robotology-superbuild`, remember to switch the `YCM_EP_DEVEL_MODE_<package_name>`
option to `TRUE`. This option will ensure that the superbuild will not try to automatically update the `<package_name>` repository. See  https://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-superbuild.7.html#developer-mode
for more details on this options.

By default, the `robotology-superbuild` uses the latest "stable" branches of the robotology repositories, but in some cases it may be necessary to use the "unstable" active development branches, or use some fixed tags. For this advanced functionalities, please refer to the documentation on changing the default project tags, available at [`doc/change-project-tags.md`](doc/change-project-tags.md).

FAQs
====

See also YCM documentation for [YCM's FAQs](http://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-faq.7.html).
For questions related to how to modify the rootology-superbuild itself, such as how to add a new package, how to do a release, check
the Developers' FAQs document at [`doc/developers-faqs.md`](doc/developers-faqs.md).

### How do I pass CMake options to the projects built by the `robotology-superbuild` ?

When configuration the robotology-superbuild, you can pass the `YCM_EP_ADDITIONAL_CMAKE_ARGS` CMake option:
~~~
cmake -DYCM_EP_ADDITIONAL_CMAKE_ARGS:STRING="-DENABLE_yarpmod_SDLJoypad:BOOL=ON"
~~~
This option can be used to specify parameters that are passed to all CMake projects of the superbuild (as it is useful for some options, for example `-DBUILD_TESTING:BOOL=ON`).
This option can be used also for CMake options that are related to a single project, as all the other projects will ignore the option.

For more information on this option, see the [official YCM documentation](http://robotology.github.io/ycm/gh-pages/latest/manual/ycm-superbuild.7.html#specifying-additional-cmake-arguments-for-all-subprojects).

### How can I check the status of each subproject?

It is possible to run the bash script named ``robotologyGitStatus.sh`` in the ``scripts`` folder. For example, on linux, from the ``robotology-superbuild`` root run ``bash scripts/robotologyGitStatus.sh`` to print the status of each subproject.
This script can run from any directory, provided that the path to the ``robotologyGitStatus.sh`` script is given to ``bash``.

### I successfully used the `robotology-superbuild` for my project, how do I cite it in my publication?

The `robotology-superbuild` is based on [YCM](https://github.com/robotology/ycm), you can cite one of these papers:

* **A Build System for Software Development in Robotic Academic Collaborative Environments**,
  D.E. Domenichelli, S. Traversaro, L. Muratore, A. Rocchi, F. Nori, L. Natale,
  Second IEEE International Conference on Robotic Computing (IRC), 2018,
  https://doi.org/10.1109/IRC.2018.00014

* **A Build System for Software Development in Robotic Academic Collaborative Environments**,
  D.E. Domenichelli, S. Traversaro, L. Muratore, A. Rocchi, F. Nori, L. Natale,
  International Journal of Semantic Computing (IJSC), Vol. 13, No. 02, 2019


Mantainers
==========

| Profile  | Maintainer                     |
|:--------:|:-----------------------------:|
| Core, Dynamics, iCub Head, iCub Basic Demos | Silvio Traversaro [@traversaro](https://github.com/traversaro) |
| Teleoperation | Kourosh Darvish [@kouroshD](https://github.com/kouroshD) |
| Human Dynamics | Yeshasvi Tirupachuri [@Yeshasvitvs](https://github.com/Yeshasvitvs) |
| Event-driven | Arren Glover [@arrenglover](https://github.com/arrenglover) |
| Dynamics full deps | Giulio Romualdi [@GiulioRomualdi](https://github.com/GiulioRomualdi) |

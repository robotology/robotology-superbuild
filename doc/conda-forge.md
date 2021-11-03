# conda-forge based robotology-superbuild Installation

[`conda`](https://docs.conda.io/en/latest/) is a package manager (originally for Python, but effectively language agnostic) that works on Linux, macOS and Windows. 

[`conda-forge`](https://conda-forge.org/)  is a community-mantained channel for the `conda` package manager that provides many dependencies useful for scientific software, in particular all the one that are required by the robotology-superbuild .

## Table of Contents
* [conda-forge overview](#conda-forge-overview)
* [Binary installation](#binary-installation)
* [Source installation](#source-installation)

## conda-forge overview

The **advantages** of the use of conda and conda-forge are: 
* **Updated dependencies:** conda-forge tipically has relatively recent version of the dependencies, so if you want to use a recent version of some libraries quite used in robotics such as [VTK](https://vtk.org/) or [PCL](https://pointclouds.org/) (or event a recent compiler) on an old Linux distro such as Ubuntu 16.04, you can. This permits us to support older distributions even when the packages that install via apt are relatively old. 
* **No need for root permissions or to change the system state:** all the software installed by conda is installed and used in a user directory, so even if you are on a system in which you do not have root access (such as a shared workstation) you can still install all you required dependencies
* **Use of binaries:** conda distributes its packages as binaries, so even to download heavy dependencies such as OpenCV, PCL, Qt and Gazebo on Windows it just takes a few minutes, as opposed to hours necessary to compile them when using vcpkg. This is also useful when producing Docker images that require a recent version of PCL or VTK: installing them via conda takes a few seconds, and this would cut the time necessary to regenerate Docker images. 
* **Reproducible enviroments:** conda has built in support for installing exactly the same version of the packages you were using in the past, up to the patch version. This is quite important for reproducibility in scientific research. See https://www.nature.com/articles/d41586-020-02462-7 for a Nature article on the importance of reproducibility in scientific research. 
* **ROS easily available on Windows and macOS:** On macOS and Windows, conda is also the package manager for which it is more easily possible to obtain working binaries of ROS1 and ROS2, thanks to the work of the [RoboStack project](https://github.com/RoboStack)
* **Simple and fast creation of new conda-forge packages:** The entire process of mantainance of conda-forge packages is GitHub-based. If you want to add a new package to conda-forge, the [required steps are minimal](https://conda-forge.org/docs/maintainer/adding_pkgs.html), and as soon as the package 
  is approved the package is ready to be used, as opposed to the stable Linux distributions that are tipically used in robotics research (such as Ubuntu LTS) in which adding a new package may require months and users can be used them only when a new LTS is released and the users install them.

The **disadvantages**  of conda and conda-forge are:
* **Not compatible with dependencies installed by other package managers:** As conda-forge provides all the software it installs without using almost anything from the system, you cannot mix libraries installed by other package managers (such as `apt` or `homebrew`). If you have a dependency
  that is only provided by `apt` and is not available in `conda-forge`, then you should install all the dependencies that you want to use from `apt`. 
* **No Debug version of C++ libraries on Windows:** as other package managers such as `apt` or `homebrew`, a part from some small exceptions conda-forge only ships the version of the libraries compiled as shared library and in `Release` compilation mode. This is not a big problem on Linux or macOS, where executables compiled in `Debug` can link libraries compiled in `Release`, but is more problematic on Windows, where this is not possible. When you are using conda-forge libraries on Windows, you can't compile your executable in `Debug` mode, but only in `Release` or `RelWithDebInfo` mode. If you stricly need to also have the `Debug` version of the libraries, the [`vcpkg`](https://github.com/microsoft/vcpkg) package manager may be more useful for you.

## Binary installation

This section describes how to compile and install the binary packages built from the robotology-superbuild on conda on Windows, macOS and Linux. 
The binary packages are hosted in the [`robotology` conda channel](https://anaconda.org/robotology) . Only packages that are built as part of the profiles and options that are supported on Conda (see [documentation on CMake options](cmake-options.md)) are available as conda binary packages in the `robotology` channel. 

### Install a conda distribution

If you do not have a conda distribution on your system, we suggest to use the minimal 
[`mambaforge`](https://github.com/conda-forge/miniforge#mambaforge) distribution, that uses `conda-forge` packages by default and installs the [`mamba`](https://github.com/mamba-org/mamba) command by default.

To install `mambaforge`, please follow the instructions in our [`install-mambaforge`](install-mambaforge.md) documentation. 

Even if you are not using `mambaforge` and you are using instead a different `conda` distribution, to follow the instructions on this document you need to install the `mamba` package in your `base` environment. [`mamba`](https://github.com/mamba-org/mamba) is a re-implementation of some functionalities of the `conda` package manager, that is much faster.


### Create an environment 
Differently from `apt` and `homebrew`, the `conda` package manager is an `environment`-oriented package manager, meaning that packages are not 
installed in some global location, but rather you install packages in an `environment` (that is just a directory in your filesystem), so that you
can easily have multiple different environments with different packages installed on your system. To read more about this, check https://docs.conda.io/projects/conda/en/4.6.1/user-guide/tasks/manage-environments.html .

For this reason, to use the robotology conda packages it is suggested to first create a conda environment, and then install in it all the packages you want to use. To create a new environment called `robotologyenv`, execute the following command:
~~~
mamba create -n robotologyenv
~~~

Once you created the `robotologyenv` environment, you can "activate" it for the current terminal (i.e. make sure that the installed packages can be found) by the command:
~~~
mamba activate robotologyenv
~~~

**IMPORTANT: if you open a new terminal, you need to manually activate the environment also there.**

**IMPORTANT: To avoid strange conflicts in environment variables, it is a good idea to remove from  the environment any variable that refers to libraries or software not installed with conda. For example, if you have a robotology-superbuild installed with apt dependencies, it is a good idea to remove the source of the `setup.sh` from the `.bashrc` before using conda environments, or in Windows it can make sense to check with [Rapid Environment Editor](https://www.rapidee.com) that the environment is clean.**

**IMPORTANT: On Windows, it is recommended to use Command Prompt to manage conda environments, as some packages (see https://github.com/conda-forge/gazebo-feedstock/issues/42 and https://github.com/RoboStack/ros-noetic/issues/21) have problems in activating environments on Powershell.** 

### Install robotology packages

Once you are in an activated environment, you can install robotology packages by just running the command:
~~~
mamba install -c conda-forge -c robotology <packagename>
~~~

The list of available packages is available at https://anaconda.org/robotology/repo . 

For example, if you want to install yarp and icub-main, you simple need to install:
~~~
mamba install -c conda-forge -c robotology yarp icub-main
~~~

In addition, if you want to simulate the iCub in Gazebo, you should also install `icub-models` and `gazebo-yarp-plugins`:
~~~
mamba install -c conda-forge -c robotology gazebo-yarp-plugins icub-models
~~~

If you want to develop some C++ code on the top of these libraries, it is recommended to also install the necessary compiler and development tools directly in the same environment:
~~~
mamba install -c conda-forge compilers cmake pkg-config make ninja
~~~

## Source installation

This section describes how to compile and install the robotology-superbuild with conda-forge provided dependencies on Windows, macOS and Linux. 

### Install a conda distribution

If you do not have a conda distribution on your system, we suggest to use the minimal 
[`mambaforge`](https://github.com/conda-forge/miniforge#mambaforge) distribution, that uses `conda-forge` packages by default and installs the [`mamba`](https://github.com/mamba-org/mamba) command by default.

To install `mambaforge`, please follow the instructions in our [`install-mambaforge`](install-mambaforge.md) documentation. 

Even if you are not using `mambaforge` and you are using instead a different `conda` distribution, to follow the next documentation you need to install the `mamba` package in your `base` environment, and you just  need to manually specify to use the `conda-forge` packages by adding `-c conda-forge` 
to all `mamba install` commands.

[`mamba`](https://github.com/mamba-org/mamba) is a re-implementation of some functionalities of the `conda` package manager, that is much faster.

### Create an environment and install dependencies
Differently from `apt` and `homebrew`, the `conda` package manager is an `environment`-oriented package manager, meaning that packages are not 
installed in some global location, but rather you install packages in an `environment` (that is just a directory in your filesystem), so that you
can easily have multiple different environments with different packages installed on your system. To read more about this, check https://docs.conda.io/projects/conda/en/4.6.1/user-guide/tasks/manage-environments.html .

For this reason, to compile the superbuild it is suggested to first create a conda environment, and then install in it all the dependencies
required by the robotology-superbuild. To create a new environment called `robsub`, execute the following command:
~~~
mamba create -n robsub
~~~

Once you created the `robsub` environment, you can "activate" it for the current terminal (i.e. make sure that the installed packages can be found) by the command:
~~~
mamba activate robsub
~~~

**IMPORTANT: if you open a new terminal, you need to manually activate the environment also there. If you compiled a robotology-superbuild in a given conda environment, remember to activate it before trying to compile or run any package 
of the robotology-superbuild.**

**IMPORTANT: To avoid strange conflicts in environment variables, it is a good idea to remove from  the environment any variable that refers to libraries or software not installed with conda. For example, if you have a robotology-superbuild installed with apt dependencies, it is a good idea to remove the source of the `setup.sh` from the `.bashrc` before using conda environments, or in Windows it can make sense to check with [Rapid Environment Editor](https://www.rapidee.com) that the environment is clean.**

**IMPORTANT: On Windows, it is recommended to use Command Prompt to manage conda environments, as some packages (see https://github.com/conda-forge/gazebo-feedstock/issues/42 and https://github.com/RoboStack/ros-noetic/issues/21) have problems in activating environments on Powershell.** 

Once you activated it, you can install packages in it. In particular the dependencies for the robotology-superbuild can be installed as:
~~~
mamba install -c conda-forge cmake compilers make ninja pkg-config
mamba install -c conda-forge ace asio boost eigen gazebo glew glfw gsl ipopt irrlicht libjpeg-turbo libmatio libode libxml2 nlohmann_json opencv pkg-config portaudio qt sdl sdl2 sqlite tinyxml spdlog
~~~

If you are on **Linux**, you also need to install also the following packages:
~~~
mamba install -c conda-forge bash-completion expat-cos6-x86_64 freeglut libdc1394 libselinux-cos6-x86_64 libxau-cos6-x86_64 libxcb-cos6-x86_64 libxdamage-cos6-x86_64 libxext-cos6-x86_64 libxfixes-cos6-x86_64 libxxf86vm-cos6-x86_64 mesalib mesa-libgl-cos6-x86_64
~~~

If you are on **Windows**, you also need to install also the following packages:
~~~
mamba install -c conda-forge freeglut
~~~

### Clone the repo
To compile the `robotology-superbuild` code itself, you need to clone it, following the instructions in https://github.com/robotology/robotology-superbuild#clone-the-repo . 

### Compile the robotology-superbuild
In a terminal in which you activate the `robsub` environment, you can compile.

On **Linux** or **macOS**, run:
~~~
cd robotology-superbuild
mkdir build
cd build
cmake ..
cmake --build . --config Release 
~~~


On **Windows**, run:
~~~
cd robotology-superbuild
mkdir build
cd build
cmake -G"Visual Studio 16 2019" ..
cmake --build . --config Release 
~~~

**IMPORTANT: conda-forge does not provide Debug version of its libraries, so in Windows you can't compile in Debug mode if you are using conda-forge.**

### Run software installed

On **Linux**, **macOS** or **Windows with Git Bash**, you can at this point run the software compiled by source with the robotology-superbuild in any new terminal as:
~~~
mamba activate robsub
source ./robotology-superbuild/build/install/share/robotology-superbuild/setup.sh
~~~

On **Windows with cmd prompt**: 
~~~
mamba activate robsub
call ./robotology-superbuild/build/install/share/robotology-superbuild/setup.bat
~~~

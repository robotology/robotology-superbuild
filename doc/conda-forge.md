# conda-forge based robotology-superbuild Installation

[`conda`](https://docs.conda.io/en/latest/) is a package manager (originally for Python, but effectively language agnostic) that works on Linux, macOS and Windows. 

[`conda-forge`](https://conda-forge.org/)  is a community-mantained channel for the `conda` package manager that provides many dependencies useful for scientific software, in particular all the one that are required by the robotology-superbuild . 

For an overview of advantages and disadvantages of conda and conda-forge, check the [`conda-forge-overview.md`](conda-forge-overview.md) document. If you are just interested in installing the robotology-superbuild, please proceed to the next sections.

## Table of Contents
* [Binary installation](#binary-installation)
* [Source installation](#source-installation)

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
mamba install -c conda-forge ace asio assimp boost eigen freetype gazebo glew glfw glm graphviz gsl ipopt irrlicht libjpeg-turbo libmatio libode libxml2 nlohmann_json pcl opencv portaudio qt-main sdl sdl2 sqlite tinyxml spdlog lua soxr qhull conda-forge cmake compilers make ninja pkg-config
~~~

If you are on **Linux**, you also need to install also the following packages:
~~~
mamba install -c conda-forge bash-completion freeglut libdc1394 libi2c expat-cos7-x86_64 libselinux-cos7-x86_64 libxau-cos7-x86_64 libxcb-cos7-x86_64 libxdamage-cos7-x86_64 libxext-cos7-x86_64 libxfixes-cos7-x86_64 libxxf86vm-cos7-x86_64 mesa-libgl-cos7-x86_64 mesa-libgl-devel-cos7-x86_64 libxshmfence-cos7-x86_64 libxshmfence-devel-cos7-x86_64 
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

**IMPORTANT: If you use Visual Studio 2022, the fourth command needs to be changed in `cmake -G"Visual Studio 17 2022" ..`. Visual Studio 2017 or earlier are not supported.**


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

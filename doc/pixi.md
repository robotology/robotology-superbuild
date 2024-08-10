# pixi

Pixi is a package management tool for developers, tt allows the developer to install libraries and applications in a reproducible way. For more information about pixi a, check [pixi's website](https://pixi.sh/).

IF you have pixi installed, to compile the superbuild with all options enabled, just run the following commands:

~~~
git clone https://github.com/robotology/robotology-superbuild/
cd robotology-superbuild
pixi run build-all
~~~

This creates a CMake build of the superbuild in the `robotology-superbuild/.build` folder.

> [!IMPORTANT]
> All the dependencies of the superbuild are automatically downloaded and installed in the `robotology-superbuild/.pixi` directory by pixi itself. If you are on Windows, the only additional dependency that you need to install manually is the VS2019 C++ compiler installed in your system.

> [!WARNING]
> Due to the high number of threads created by robotology-superbuild's project for compilation, it can happen that the build stops as the system run out of memory. In that case, run again `pixi run build-all` and the build will resume from the point at which it halted.


After this process completly successfully, you can access all the software compiled by the superbuild by moving in the `robotology-superbuild` directory and run `pixi run <command>` (to launch a single command) or `pixi shell` (to open a terminal in which the superbuild software is available).

For example, to run the `idyntree-model-info` program, you can run:

~~~
pixi run idyntree-model-info
~~~

or:

~~~
pixi shell
idyntree-model-info
~~~

If you want to customize the CMake options of the superbuild, you can modify them by running `pixi run build` (that will not enable any specific option), and then modify the cmake options of the superbuild via the command:

~~~
pixi run ccmake -B.build
~~~

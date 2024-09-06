Frequently Asked Questions (FAQs)
=================================

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


### How do I solve the "Invalid MEX-file <...>" error message on Linux when using MATLAB or Simulink libraries?

If you are on Linux and you encounter errors similar to:
~~~
Invalid MEX-file '/home/username/Software/robotology-superbuild/build/install/mex/WBToolbox.mexa64':
 /home/username/Software/matlab/bin/glnxa64/../../sys/os/glnxa64/libstdc++.so.6:
version `GLIBCXX_3.4.21' not found (required by /home/username/Software/robotology-superbuild/build/install/mex/WBToolbox.mexa64)
~~~
when running MATLAB or Simulink libraries installed by the robotology-superbuild, to solve the problem it should be sufficient to run:
~~~
sudo apt install matlab-support
~~~
and specify your MATLAB installation directory and when there is the question "Rename MATLAB's GCC libraries?" answer "Yes".

If there are no configuration question when you run , probably that means that the package is already installed. In that case, you can just reconfigure it with the command:
~~~
sudo dpkg-reconfigure matlab-support
~~~
and again, specify your MATLAB installation directory and when there is the question "Rename MATLAB's GCC libraries?" answer "Yes".

If the problem persists even after following this steps, please [open a new issue in the robotology-superbuild issue tracker](https://github.com/robotology/robotology-superbuild/issues/new).


### How to I solved the "Initializing libomp.\*, but found libiomp5.\* already initialized." when using MATLAB libraries?

If you are on macOS and you encounter errors similar to:
~~~
OMP: Error #15: Initializing libomp.dylib, but found libiomp5.dylib already initialized.
OMP: Hint This means that multiple copies of the OpenMP runtime have been linked into the program. That is dangerous, since it can degrade performance or cause incorrect results. The best thing to do is to ensure that only a single OpenMP runtime is linked into the process, e.g. by avoiding static linking of the OpenMP runtime in any library. As an unsafe, unsupported, undocumented workaround you can set the environment variable KMP_DUPLICATE_LIB_OK=TRUE to allow the program to continue to execute, but that may cause crashes or silently produce incorrect results. For more information, please see http://openmp.llvm.org/
~~~

or you are on Windows if you encounter errors similar to:
~~~
OMP: Error https://github.com/ami-iit/element_aerodynamics-control/issues/15: Initializing libiomp5md.dll, but found libiomp5md.dll already initialized. 
OMP: Hint This means that multiple copies of the OpenMP runtime have been linked into the program. 
That is dangerous, since it can degrade performance or cause incorrect results. 
The best thing to do is to ensure that only a single OpenMP runtime is linked into the process, e.g. by avoiding static linking of the OpenMP runtime in any library. 
As an unsafe, unsupported, undocumented workaround you can set the environment variable KMP_DUPLICATE_LIB_OK=TRUE to allow the program to continue to execute, but that may cause crashes or silently produce incorrect results. 
For more information, please see http://www.intel.com/software/products/support/.
~~~

when running MATLAB libraries installed by the robotology-superbuild, a simple workaround is to install the netlib version of libblas via:
~~~
conda install libblas=*=*netlib
~~~

See https://github.com/robotology/idyntree/issues/1109 for more details. The [One-line Installation of Robotology MATLAB/Simulink Packages](./matlab-one-line-install.md) installs `libblas=*=*netlib` to mitigate this problem.

### I want to install packages from the `robotology` conda channel that were built in 2021 but I am not finding them, where I can find them?

In January 2024 the packages that were contained in the `robotology` channel and were built in 2021 have been moved to the `robotology-2021` channel, see https://github.com/robotology/robotology-superbuild/issues/1585 for more details.

### I am trying to load pytorch on Windows and obtain I can't load the fbgemm.dll, what can I do?

If you are on Windows and you obtain an error message like:

~~~
OSError: [WinError 182] The operating system cannot run %1. Error loading "D:\miniforge\envs\robsub\Lib\site-packages\torch\lib\fbgemm.dll" or one of its dependencies.
~~~

when trying to load `import torch`, then probably you have both `openmp` and `intel-openmp` installed in your conda environment. To fix your pytorch installation, just run:

~~~
conda uninstall openmp
conda install intel-openmp --forge-reinstall
~~~

Note that this procedure can create problem when installing ipopt-related software. This will be probably be solved once conda-forge migrates to a modern fortran compiler on Windows, see https://github.com/conda-forge/conda-forge-pinning-feedstock/pull/1359 for more infomation.

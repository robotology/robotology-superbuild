# Install mambaforge

This page provide detailed instructions on how to install the [mambaforge conda distribution](https://github.com/conda-forge/miniforge). 
For more information on conda, mamba and its use with the robotology-superbuild, please check the [related documentation](conda-forge.md).

## Table of Contents

* [Linux](#linux)
* [macOS](#macos)
* [Windows](#windows)

## Linux

### Install
First of all, download the installer and install it in its default location:
~~~
# Download
curl -LO https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh
# Install with default options
sh ./Mambaforge-$(uname)-$(uname -m).sh -b
~~~
This will install mambaforge in `~/mambaforge` .

To use the `conda` and `mamba` commands, you need to add the `~/mambaforge/condabin` directory to the [`PATH` environment variable](https://en.wikipedia.org/wiki/PATH_(variable)). 
You can do this persistently by modifying the `.bashrc` via the command: 
~~~
~/mambaforge/condabin/conda init
~~~

If you are using a non-bash shell such as `zsh`, you also need to run:
~~~
~/mambaforge/condabin/conda init zsh
~~~

By default, this command also automatically initialize the [`base` conda environment](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#activating-an-environment) whenever you start a terminal.
As this could interfere with other uses of your system (for example compilation against libraries installed via `apt`), it is recommended to disable this by setting:
~~~
conda config --set auto_activate_base false
~~~

After this configuration, whenever you open a new terminal, you should be able to access the `conda` command, but no environment should be enabled by default, i.e. if you execute `conda info` you should see:
~~~
$ conda info
     active environment : None
            shell level : 0
            [...]
~~~

To activate in any terminal the `base` environment, just run:
~~~
mamba activate base
~~~

### Uninstall
To remove `mambaforge`, first cleanup your `.bashrc` either manually or by running the command:
~~~
~/mambaforge/condabin/conda init --reverse
~~~

If you are using a non-bash shell such as `zsh` you need to modify the appropriate file, either manually or by running the command:
~~~
~/mambaforge/condabin/conda init zsh --reverse
~~~

Then, just remove the `~/mambaforge` directory and the setting files:
~~~
rm -rf ~/mambaforge
rm -rf ~/.conda
rm -rf ~/.condarc
~~~


## macOS

### Install
First of all, download the installer and install it in its default location:
~~~
# Download
curl -fsSLo Mambaforge.sh https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-$(uname -m).sh
# Install with default options
sh ./Mambaforge.sh -b
~~~
This will install mambaforge in `~/mambaforge` .

To use the `conda` command, you need to add the `~/mambaforge/condabin` directory to the [`PATH` environment variable](https://en.wikipedia.org/wiki/PATH_(variable)). 
You can do this persistently by modifying the appropriate file via the command: 
~~~
~/mambaforge/condabin/conda init
~~~

If you are using a non-bash shell such as `zsh`, you also need to run:
~~~
~/mambaforge/condabin/conda init zsh
~~~

By default, this command also automatically initialize the [`base` conda environment](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#activating-an-environment) whenever you start a terminal.
As this could interfere with other uses of your system (for example compilation against libraries installed via `brew`), it is recommended to disable this by setting:
~~~
conda config --set auto_activate_base false
~~~

After this configuration, whenever you open a new terminal, you should be able to access the `conda` command, but no environment should be enabled by default, i.e. if you execute `conda info` you should see:
~~~
$ conda info
     active environment : None
            shell level : 0
            [...]
~~~

To activate in any terminal the `base` environment, just run:
~~~
mamba activate base
~~~

### Uninstall
To remove `mambaforge`, first cleanup your `PATH` environment variable by running the command:
~~~
~/mambaforge/condabin/conda init --reverse
~~~

If you are using a non-bash shell such as `zsh` you need to modify the appropriate file, either manually or by running the command:
~~~
~/mambaforge/condabin/conda init zsh --reverse
~~~


Then, just remove the `~/mambaforge` directory and the setting files:
~~~
rm -rf ~/mambaforge
rm -rf ~/.conda
rm -rf ~/.condarc
~~~

## Windows

First of all, download the installer from https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Windows-x86_64.exe and install it by double clicking on it.

If you already have a Python that you use in your system, make sure that you deselect the "Register Mambaforge Python as my default Python" during the installation.

After the installation has been completed, Mambaforge should have been installed in `%HOME%\AppData\Local\mambaforge`. 

If you explicitly selected the for All Users install, Mambaforge will be installed in `%ProgramData%\mambaforge`, in that case substitute `%HOME%\AppData\Local\mambaforge` with `%ProgramData%\mambaforge` in the rest of the documentation.

To ensure that the `conda` binary can be used in your terminal, open a Command Prompt and run:
~~~
%HOME%\AppData\Local\mambaforge\condabin\conda init
~~~

By default, this command also automatically initialize the [`base` conda environment](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#activating-an-environment) whenever you start a terminal.
As this could interfere with other uses of your system (for example compilation against libraries installed not installed via `conda`), it is recommended to disable this by setting:
~~~
%HOME%\AppData\Local\mambaforge\condabin\conda config --set auto_activate_base false
~~~

After this configuration, whenever you open a new terminal, you should be able to access the `conda` command, but no environment should be enabled by default, i.e. if you execute `conda info` you should see:
~~~
> conda info
     active environment : None
            shell level : 0
            [...]
~~~

To activate in any terminal the `base` environment, just run:
~~~
mamba activate base
~~~

### Uninstall
First of all, open a command prompt and run:
~~~
%HOME%\AppData\Local\mambaforge\condabin\conda init --reverse
~~~

Then go to "Add or remove programs", search for Mambaforge and uninstall it.

After that, delete the `%HOME%/.conda` directory and the `%HOME%/.condarc` file.

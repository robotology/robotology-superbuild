# Install miniforge

This page provide detailed instructions on how to install the [miniforge conda distribution](https://github.com/conda-forge/miniforge). 
For more information on conda and its use with the robotology-superbuild, please check the [related documentation](conda-forge.md).

## Table of Contents

* [Linux](#linux)
* [macOS](#macos)
* [Windows](#windows)

## Linux

### Install
First of all, download the installer and install it in its default location:
~~~
# Download
curl -LO https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh
# Install with default options
sh ./Miniforge3-Linux-x86_64.sh -b
~~~
This will install miniforge in `~/miniforge3` .

To use the `conda` command, you need to add the `~/miniforge3/condabin` directory to the [`PATH` environment variable](https://en.wikipedia.org/wiki/PATH_(variable)). 

You can do this persistently by executing the following commands on the terminal: 
~~~
~/miniforge3/condabin/conda init
~~~

If you are using a non-bash shell such as `zsh`, you also need to run:
~~~
~/miniforge3/condabin/conda init zsh
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
conda activate base
~~~

### Uninstall
To remove `miniforge`, first cleanup your `.bashrc` either manually or by running the command:
~~~
~/miniforge3/condabin/conda init --reverse
~~~

If you are using a non-bash shell such as `zsh` you need to modify the appropriate file, either manually or by running the command:
~~~
~/miniforge3/condabin/conda init zsh --reverse
~~~

Then, just remove the `~/miniforge3` directory and the setting files:
~~~
rm -rf ~/miniforge3
rm -rf ~/.conda
rm -rf ~/.condarc
~~~


## macOS

### Install
First of all, download the installer and install it in its default location:
~~~
# Download
curl -fsSLo Miniforge3.sh https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-$(uname -m).sh
# Install with default options
sh ./Miniforge3.sh -b
~~~
This will install miniforge in `~/miniforge3` .

To use the `conda` command, you need to add the `~/miniforge3/condabin` directory to the [`PATH` environment variable](https://en.wikipedia.org/wiki/PATH_(variable)). 

You can do this persistently by writing the following commands on the terminal:
~~~
~/miniforge3/condabin/conda init
~~~

If you are using a non-bash shell such as `zsh`, you also need to run:
~~~
~/miniforge3/condabin/conda init zsh
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
conda activate base
~~~

### Uninstall
To remove `miniforge`, first cleanup your `PATH` environment variable by running the command:
~~~
~/miniforge3/condabin/conda init --reverse
~~~

If you are using a non-bash shell such as `zsh` you need to modify the appropriate file, either manually or by running the command:
~~~
~/miniforge3/condabin/conda init zsh --reverse
~~~


Then, just remove the `~/miniforge3` directory and the setting files:
~~~
rm -rf ~/miniforge3
rm -rf ~/.conda
rm -rf ~/.condarc
~~~

## Windows

**For all the following instructions, we strongly suggest to use Command Prompt as shell on Windows. If you want to use Powershell, not all the mentioned feature may work, see [conda-powershell-troubleshooting documentation page](conda-powershell-troubleshooting.md) for more info.**

First of all, download the installer from https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Windows-x86_64.exe and install it by double clicking on it.

If you already have a Python that you use in your system, make sure that you deselect the "Register Miniforge3 Python as my default Python" during the installation.

After the installation has been completed, Miniforge should have been installed in `%HOMEDRIVE%%HOMEPATH%\AppData\Local\miniforge3`. 

If you explicitly selected the for All Users install, Miniforge will be installed in `%ProgramData%\miniforge3`, in that case substitute `%HOMEDRIVE%%HOMEPATH%\AppData\Local\miniforge3` with `%ProgramData%\miniforge3` in the rest of the documentation. In this case you should also have admin rights (or run the console as administrator) otherwise you will get an error ("ERROR during elevated execution").

To ensure that the `conda` binary can be used in your terminal, open a Command Prompt and run:
~~~
%HOMEDRIVE%%HOMEPATH%\AppData\Local\miniforge3\condabin\conda init
~~~

By default, this command also automatically initialize the [`base` conda environment](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#activating-an-environment) whenever you start a terminal.
As this could interfere with other uses of your system (for example compilation against libraries installed not installed via `conda`), it is recommended to disable this by setting:
~~~
%HOMEDRIVE%%HOMEPATH%\AppData\Local\miniforge3\condabin\conda config --set auto_activate_base false
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
conda activate base
~~~

### Uninstall
First of all, open a command prompt and run:
~~~
%HOMEDRIVE%%HOMEPATH%\AppData\Local\miniforge3\condabin\conda init --reverse
~~~

Then go to "Add or remove programs", search for Miniforge3 and uninstall it.

After that, delete the `%HOMEDRIVE%%HOMEPATH%/.conda` directory and the `%HOMEDRIVE%%HOMEPATH%/.condarc` file.

⚠️ On Windows, in case you forgot to follow the previous steps and now your Command Prompt is broken, you can try the following script in PowerShell as described in https://github.com/conda-forge/miniforge/issues/164#issuecomment-1092812732:  
```
C:\Windows\System32\reg.exe DELETE "HKCU\Software\Microsoft\Command Processor" /v AutoRun /f`
```

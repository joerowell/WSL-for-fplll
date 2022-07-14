# Installing fplll and friends using WSL

This repository is designed to make it easy to install Sagemath, fplll, fpylll and G6K (along with some other dependencies) inside the  Windows Subsystem for Linux (WSL) system.  

The raison d'etre here is that Sagemath must be installed inside WSL if 
you want to use conda to maintain the dependencies [1].

Please note that whilst this script is tested weekly (via Github actions) it may be the case that the script _only_ works on Github actions. As a result, we offer this script without any guarantees.

## High-level:
The high-level flow behind these instructions are as follows:

- Enable the Windows Subsystem for Linux. (Step #1)
- Clone the script in this repository. (Step #2)
- Run the script. The script will pull in all necessary dependencies for [sagemath](https://www.sagemath.org/), [fplll](https://github.com/fplll/fplll), [fpylll](https://github.com/fplll/fpylll) and [g6k](https://github.com/fplll/g6k) 
  and ensure that everything is installed correctly. (Step #3)

## Caveats
By default, this script will delete any existing conda and mamba installations inside your WSL. 
This is a bad thing if you already have any conda environments in your WSL.
To circumvent this problem, comment out any lines in the script corresponding to the installation of conda and mamba. You may then run the script as usual.

## Note
You may already have the WSL enabled or installed. If you do, then feel free to skip Step 1.

## Step 1: Enabling WSL
Windows 10 has the "Windows Subsystem for Linux" (WSL), which essentially allows you to use Linux features in Windows without the need for a dual-boot system or a virtual machine. 
To activate this, first go to Settings -> Update and security -> For developers and enable developer mode. (This may take a while.) 

Afterwards, open Powershell as an administrator (by right clicking and selecting "Run as an Administrator") and run:
``
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
``

With this, you'll need to install a Linux distribution. There are a few different choices: for the sake of this tutorial, we'll choose Ubuntu.

- Open the Windows app store.
- Search for "Ubuntu"
- Install Ubuntu by clicking on the "Ubuntu" icon and clicking "Install"

Note that the Windows app store may prompt you to enter a username. This is not necessary.

Once installed, open Ubuntu via the start menu. This will then initialise a linux distribution. You will need to provide a username and a password. Make sure you remember this password, as the next step will prompt for this when the script starts.

# Step 2: Clone the repository
You can now download this repository. To do this, run the following command:

``
git clone https://github.com/joerowell/WSL-for-fplll.git
``

# Step 3: Install all the things

You can now get into this directory by running:

`` cd WSL-for-fplll``

Mark the script as executable by running:

``chmod +x install_g6k.sh``

Finally, run the program:

``./install_g6k``

The script may take a little while to run. This is because installation of ``sage`` etc can take a while. This script will update your ubuntu installation and install all pre-requisites for fplll, fpylll, g6k and Sage.

If all is successful you'll see this as the last line:
``
All finished!
Don't forget to run conda activate g6k when you log back in.
``

# Step 4: Testing
You can test this installation using G6K. To begin, activate the environment by running:

`` conda activate g6k``.

As a test run the following commands:

``
cd g6k
``

``
./full_sieve.py 60 --verbose
``

If this runs successfully, then congratulations: G6K is installed. You may run similar tests for the other applications, but as G6K is the last installation it should imply that the others were successful too.

# Step 5: Using WSL
Running your programs inside WSL can be tricky. This is because you need to move your programs or data between the WSL layer and Windows, which is deliberately made difficult.

A good tutorial for this is:

https://ridicurious.com/2018/10/18/2-ways-to-copy-files-from-windows-10-to-windows-sub-system-for-linux/

# References:
[1] https://groups.google.com/g/sage-devel/c/wyaV8x5qolI/m/jVS4DKBvCAAJ

#!/usr/bin/env bash

## Step #1: Check that we have git installed
if ! command -v git &> /dev/null
then
    echo "Git is not installed."
    echo "Please install git using your local package manager"
    exit
fi

<<<<<<< HEAD
## If you don't update here installing GCC can fail
sudo apt-get update
sudo apt-get upgrade -y

if ! command -v gcc &> /dev/null
then
	sudo apt-get install gcc -y
	sudo apt-get install g++ -y
fi

## For some reason python doesn't come automatically aliased on Ubuntu?
alias python=python3
## Warning: this will nuke your existing mamba installation.
## Some people won't have this, and that's OK, but make sure you actively read this before
## you run it!
rm -rf ./mambaforge
=======
## Warning: this will nuke your existing conda installation.
## Some people won't have this, and that's OK, but make sure you actively read this before
## you run it!
rm -rf ./anaconda3

## If we have git installed then we also need to wget conda
wget https://repo.continuum.io/archive/Anaconda3-5.3.1-Linux-x86_64.sh
chmod +x Anaconda3-5.3.1-Linux-x86_64.sh
./Anaconda3-5.3.1-Linux-x86_64.sh -b -p

## Before we do anything else we need to make sure we've activated conda without logging
## out. To do that, we make sure we know the current user
username=$(whoami)
## We need to escape the username here or this absolutely will not work. 
eval -e "$(/Users/\$$username/anaconda/bin/conda shell.bash hook)"
conda init
>>>>>>> 0b7330f... script

## Now we have a few different things we can do
## The best way to start is to install mamba, because it makes everything much faster
curl -L -O https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh
<<<<<<< HEAD
sh Mambaforge-$(uname)-$(uname -m).sh -b -p
source ~/mambaforge/bin/activate
mamba init

## We can now switch back to the regular env
source ~/.bashrc 

## Now we've installed mamba we can finally get started on the things we need
mamba install -y libtool autoconf automake gmp mpfr 

## And now we can follow the rest of the default instructions
mamba create -y -n g6k python=3.7
mamba activate g6k
mamba install -y sage
=======
sh Mambaforge-$(uname)-$(uname -m).sh 

## Now we've installed mamba we can finally get started on the things we need
mamba install libtool
mamba install autoconf
mamba install make

## And now we can follow the rest of the default instructions
mamba create -n g6k python=3.7
mamba activate g6k
mamba install -c mamba-forge sage
>>>>>>> 0b7330f... script

git clone https://github.com/fplll/fplll
cd fplll
autoreconf -i
./configure --prefix=$SAGE_LOCAL --disable-static
make install
cd ..

git clone https://github.com/fplll/fpylll
cd fpylll
pip install -r requirements.txt
pip install -r suggestions.txt
python setup.py build
python setup.py -q install
cd ..
    
git clone https://github.com/fplll/g6k
cd g6k
autoreconf -i
./configure --prefix=$SAGE_LOCAL --disable-static
make
pip install -r requirements.txt
./rebuild.sh
python setup.py build
python setup.py -q install 
cd ..

echo "All finished!"
<<<<<<< HEAD
echo "Don't forget to run conda activate g6k when you log back in."
=======
>>>>>>> 0b7330f... script

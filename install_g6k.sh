#!/usr/bin/env bash

# Change this to set the number of cores you're willing to use for make activities
jobs=4


## Step #1: Check that we have git installed
if ! command -v git &> /dev/null
then
    echo "Git is not installed."
    echo "Please install git using your local package manager"
    exit
fi

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

## Now we have a few different things we can do
## The best way to start is to install mamba, because it makes everything much faster
curl -L -O https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh
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

git clone https://github.com/fplll/fplll
cd fplll
autoreconf -i
./configure --prefix=$SAGE_LOCAL --disable-static
make install -j ${jobs}
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
make -j ${jobs}
pip install -r requirements.txt
python setup.py build_ext --inplace
python setup.py -q install 
cd ..

echo "All finished!"
echo "Don't forget to run conda activate g6k when you log back in."

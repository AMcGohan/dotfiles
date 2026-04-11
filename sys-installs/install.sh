#!/bin/bash
#
# check user EUID | if not root, prompt user and exit
user_uid=$(id -u)
if [[ user_uid -ne 0 ]]; then
	echo "Must be root to run script"
	exit
fi
# Check if `apt` is system package manger | if not, prompt user and exit
if [[ -z $(which apt) ]]; then
	echo "apt not found"
	exit
fi
# Prompt user of what will be installed, user can press 'y' to proceed or 'n' to exit
read -p $'This script will install the following packages:\n* Singularity\n* GO\n* build-essential\n* libssl-dev\n* uuid-dev\n* libgpgme11-dev\n* squashfs-tools\n* libseccomp-dev\n* pkg-config\n* libfuse-dev\n* libfude3-dev\n* libsubid-dev\* nautoconf\n* automake\n* libtool\nProceed? (y/n)\n' proceed

if [[ ${proceed,,} == 'n' ]]; then
	echo "aborting installation"
	exit
elif [[ ${proceed,,} != 'y' ]]; then
	echo "invalid input, exiting"
	exit
fi
# Check if software is already installed, if true prompt user a 'name conflict' occured and exit.
echo "checking if Singularity is installed..."
if [[ $(singularity --version) ]]; then
	echo "Name conflict has occured, exiting now"
	exit
fi

# install dependencies
sudo apt-get update && sudo apt-get install -y \
    build-essential \
    libssl-dev \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    pkg-config \
    libfuse-dev \
    libfuse3-dev \
    libsubid-dev \
    autoconf \
    automake \
    libtool
#
# --- GO INSTALLATION
#

# install go
export VERSION=1.25.8 OS=linux ARCH=amd64 && \
    wget https://go.dev/dl/go$VERSION.$OS-$ARCH.tar.gz && \
    sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
    rm go$VERSION.$OS-$ARCH.tar.gz

# setup environment for Go

export GOPATH=$HOME/go
export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin

#
# --- SINGULARITY INSTALL
#

# download singularity git repo
export VERSION=ce-4.4.1 && \
    mkdir -p $GOPATH/src/github.com/sylabs && \
    cd $GOPATH/src/github.com/sylabs && \
    wget https://github.com/sylabs/singularity/releases/download/v4.4.1/singularity-${VERSION}.tar.gz && \
    tar -xzf singularity-${VERSION}.tar.gz && \
    cd ./singularity-${VERSION} && \
    ./mconfig

# build singularity
cd /root/go/src/github.com/sylabs/singularity-ce-4.4.1/builddir && \
    make && \
    sudo make install

# testing singularity
echo "Install complete, running version command:"
singularity --version

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
read -p $'This script will install the following packages:\n* Singularity\n* build-essential\n* libssl-dev\n* uuid-dev\n* libgpgme11-dev\n* squashfs-tools\n* libseccomp-dev\n* pkg-config\nProceed? (y/n)\n' proceed

if [[ ${proceed,,} == 'n' ]]; then
	echo "aborting installation"
	exit
elif [[ ${proceed,,} != 'y' ]]; then
	echo "invalid input, exiting"
	exit
fi
# Check if software is already installed, if true prompt user a 'name conflict' occured and exit.
# TODO once singularity is installed fix this section
echo "checking if Singularity is installed..."

# install dependencies
sudo apt-get update && sudo apt-get install -y \
    build-essential \
    libssl-dev \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    pkg-config

#
# --- GO INSTALLATION
#

# install go
export VERSION=1.26.2 OS=linux ARCH=amd64 && \
    wget https://go.dev/dl/go$VERSION.$OS-$ARCH.tar.gz && \
    sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
    rm go$VERSION.$OS-$ARCH.tar.gz

# setup environment for Go

echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
    echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
    source ~/.bashrc

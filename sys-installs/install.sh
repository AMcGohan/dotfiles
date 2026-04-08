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
read -p $'This script will install the following packages:\n* Singularity\nProceed? (y/n)\n' proceed
# Check if software is already installed, if true prompt user a 'name conflict' occured and exit.

#!/bin/bash

sh_path=$(pwd)

# creates a symbolic link file in users home directory that points to `.bash_aliases` in this directory

ln -s $sh_path/.bash_aliases ~/.bash_aliases

echo "Reload your .bash_aliases file for changes to take effect e.g. source ~/.bash_aliases"

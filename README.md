# Dotfiles

## Contents

This repository contains installation for `vundle` and various plugins for `vim`, aliases, and `Singularity` and its dependencies.

### /homefiles
* Contains `.bash_aliases` of handy commands made simplier. For example:
    * `ga` - `git add`
    * `gca "commit message"` - `git commit -m "commit message"`
    * `gp` - `git push`
* Contains a script that makes a symbolic link named `.bash_aliases` in users home directory pointing to this repositories `.bash.aliases`

### /sys-installs
* Contains an installation script for `Singularity` CE, a containerization tool
* Installs many dependencies, will take time to install.

### /vim-config
* Contains an installation script for `vundle` and various plugins, including `YouCompleteMe`, `Complete-T`, and `gruvbox`.

# dotfiles

[![Build Status](https://travis-ci.org/JohnVonNeumann/dotfiles.svg?branch=master)](https://travis-ci.org/JohnVonNeumann/dotfiles)

Gaze upon thine dotfiles, a miraculous world of configuration, which can be
used to rapidly bring a host upto speed, making it feel like home, a home
filled with your favourite family members, good beer and a damned good time.

## Using the repository

1. Use the [larry-wall repository](https://github.com/JohnVonNeumann/larry-wall) to do the initial setup of your host, this will ensure the relevant packages/software that you wish to configure, are actually installed.
2. After cloning this repository, run the `./setup.sh` bash script, which will install neovim and configure it. I'm looking for a cleaner way to do this.
3. Run `./install` which will do the needful on the rest of your files.
4. ????
5. Profit

## Thoughts for times of implementation, not slightly-drunk planning

* Move all possible configurations into this repository, more than likely a slow process.
* Nerf the `setup.sh` script into something nicer, I haven't put my thought into this yet. Will get it eventually.

## Bits and pieces of thought as I've been writing recently

* I may not need `setup.sh` I could potentially just try and find modules within Ansible for much of the `macos/brew` based installs, along with `rhel/yum`. May want to look into this, as I shouldn't be writing script for everything just because `neovim` on `ubuntu` can be a pain to install.

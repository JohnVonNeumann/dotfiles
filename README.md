# dotfiles

[![Build Status](https://travis-ci.org/JohnVonNeumann/dotfiles.svg?branch=master)](https://travis-ci.org/JohnVonNeumann/dotfiles)

Gaze upon thine dotfiles, a miraculous world of configuration, which can be
used to rapidly bring a host upto speed, making it feel like home, a home
filled with your favourite family members, good beer and a damned good time.

## Using the repository

1.  Use the [larry-wall repository](https://github.com/JohnVonNeumann/larry-wall) to do the initial setup of your host, this will ensure the relevant packages/software that you wish to configure, are actually installed.
2.  After cloning this repository, run the `./setup.sh` bash script, which will install neovim and configure it. I'm looking for a cleaner way to do this.
3.  Run `./install` which will do the needful on the rest of your files.
4.  ????
5.  Profit

## Approaches to testing

From my noob-perspective of testing, there are 4 types of testing:

1.  Unit testing - making sure small units (functions) do their job.

> bats, bats-core

2.  Integration testing - making sure the units (functions) complete the process they were built to do as a team.

> bats, bats-core

3.  Smoke testing - making sure that the thing runs through to completion without setting fires.

> running the script in a controlled environment

4.  System testing - making sure that the thing actually did what you thought it did.  

> inspec

## Thoughts for times of implementation, not slightly-drunk planning

*   Move all possible configurations into this repository, more than likely a slow process.
*   Nerf the `setup.sh` script into something nicer, I haven't put my thought into this yet. Will get it eventually.
*   Assess whether it would be more sensible to simply pull all configuration code into one repository ( both larry-wall and dotfiles ) and simply perform some OS identification to work out which ansible playbooks to run, as this would provide a much simpler method of testing/ensuring idempotency and whatnot is reached.

> [ansible os detection and playbook runs](https://raymii.org/s/tutorials/Ansible_-_Only_if_on_specific_distribution_or_distribution_version.html)

## Bits and pieces of thought as I've been writing recently

*   I may not need `setup.sh` I could potentially just try and find modules within Ansible for much of the `macos/brew` based installs, along with `rhel/yum`. May want to look into this, as I shouldn't be writing script for everything just because `neovim` on `ubuntu` can be a pain to install.

# dotfiles

Gaze upon thine dotfiles, a miraculous world of configuration, which can be used to rapidly bring a host upto speed, making it feel like home, a home filled with your favourite family members, good beer and a damned good time. 

## Thoughts for times of implementation, not slightly-drunk planning
* Keep all dotfiles in the central repository, symlink back to the location required for the application to ingest the configs, even better, change the applications to pull the configurations directly from the central ldotifles directory!

* Generate a decent bash script that checks for the existence of applications/programs BEFORE running, this way, you handle errors safely. Throw warnings to user to indicate that they should run relevant ansible playbooks to install the required software, before clusterfucking your config.

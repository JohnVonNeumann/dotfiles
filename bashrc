# ~/.bashrc: executed by bash(1) for non-login shells.  # see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# added to enable colour term in mac:terminal/screen/vim combo, one of them had
# a bug which disabled colour
TERM=xterm-256color

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# commented out and got bash_profile source working, basically this was
# supplying a circular reference, recommend using `source ~/.envvars`
# or something of the like if this is needed, noticed only had this issue on
# macos, so i only source if machtype isnt darwin
# enable bash_profile envvars to be used
source ~/.bash_profile

#####################################################################################

#######################################
# PERSONALLY EDITED CHANGES TO BASHRC #
#######################################

### Useful file locations
export SSH_DIR=~/.ssh

### Grep for values with standard every-run conditions
# $1 = Search value
qgrep () {
  grep -nr $1 . --exclude-dir={.terraform,.git,modules,vendor} --exclude={*.log,*.log.?} --color=always --line-number
}

### ansible related shortcut/functions ###
# command -v syntax is preferred as it is internal shell functionality and doesn't
# require external procs to be forkandexec'd to check the existence of files/exe's
# in this case, the external proc we are talking about is `which "command"`
if [ -x "$(command -v ansible-vault)" ]; then
  avedit () {
    ansible-vault edit $1
  }
  avview () {
    ansible-vault view $1
  }
  apb () {
   ansible-playbook $1 --ask-vault-pass
  }
fi

# Simple func that takes in a parameter (a program) that we wish to background
# and pipes output to /dev/null to stop annoying term issues with output coming
# back over the top of the session
bground () {
  $1 > /dev/null 2>&1 &
}

### yamllinting function for non-annoying parsing of config
if [ -x "$(command -v yamllint)" ]; then
  yl () {
    yamllint -c $INFRA_REPO/.yamllint $1
  }
fi

### Random system functions, not all of which are written by me
if [ -x "$(command -v watch)" ]; then
  wifi_strength () {
    watch -n 1 "awk 'NR==3 {print \"WiFi Signal Strength = \" \$3 \"00 %\"}''' /proc/net/wireless"
  }
fi

### General code cleaning
alias whitespaceassassin="ex +'bufdo!%s/\s\+$//' -scxa *.*"
  # Regex:
  #  % | every line
  #  s | substitute
  # \s | whitespace char
  # \+ | one or more
  #  $ | to end of file
  # // | replace with nothing
  # Ex:
  # :help Ex is a mode of vim that provides extra cmd line processing
  #  + | command following will be executed after first file is read
  # -s | silent mode
  # -c | command, i think, docs are shaky, doesn't work without
  # -x | use encryption, doesn't seem to work without it, hangs

### git aliases ###
if [ -x "$(command -v git)" ]; then
  alias git-remove-all-merged-locals="git branch --merged | egrep -v '(^\*|master|dev)' | xargs git branch -d"

  # git-personal
  if [ -n $GIT_PERSONAL_NAME ] && [ -n $GIT_PERSONAL_EMAIL ]; then
    alias git-config-personal="git config user.name $GIT_PERSONAL_NAME && git config user.email $GIT_PERSONAL_EMAIL"
  else
    echo "Set \$GIT_PERSONAL_NAME & \$GIT_PERSONAL_EMAIL";
  fi

  alias git-fap="git fetch --all --prune"
  alias git-commit-fix-lint-errors="git commit -m \"FIX lint errors\""
  alias git-count="git log | grep -c commit"

  # git-config:
  # Sometimes when I'm working across multiple git hosts, I'll be dealing with
  # code that is not "mine", in that I'll be using different creds, much like the
  # git-personal alias, this helps config the LOCAL git repository, as opposed
  # to use git config global like all the shit guides online tell you to do.
  git-config () {
    git config user.name $1 && git config user.email $2
  }

  # git-squash-commit
  # Sometimes when I'm working with a codebase I will be playing with an idea
  # workflow trying to get it to work, maybe (probably) they're changes that are
  # similar to other temporally related commits, so in this case, they'll likely
  # all get squashed into a final fix commit at the end, in this case, I'll be
  # trying something, then pushing to CI, then trying again and pushing to CI.
  # This helps do that faster.
  git-squash-commit () {
    git status > /dev/null 2>&1
    if [[ $? != 0 ]]; then
      echo "Error: Not a git repository.";
    else
      # TODO: Spin out the `branch` declaration into a function, keep it DRY.
      local branch=$(git branch | grep "*" | awk '{ print $2 }')
      git commit -am "SQUASH commit - debugging/fixes"
      git push origin $branch
    fi
  }

  # git-push
  # The majority of my pushes exist on branches of active development, I know I
  # can set an upstream and then just use `git push` but I always forget, so this
  # will do.
  git-push () {
    local branch=$(git branch | grep "*" | awk '{ print $2 }')
    if [[ $? == 0 ]]; then
      git push origin $branch
    else
      echo "Error: Couldn't source branch name"
    fi
  }

  # git-push-with-lease
  # Just the git-push function with the --force-with-lease flag set to be able to
  # do pushes after rebasing.
  # TODO: Just allow for a flag to be set in the `git-push` function.
  git-push-with-lease () {
    local branch=$(git branch | grep "*" | awk '{ print $2 }')
    if [[ $? == 0 ]]; then
      git push origin $branch --force-with-lease
    else
      echo "Error: Couldn't source branch name"
    fi
  }

  # git-pr-patch-data
  # It's useful to get a nice output of all changes for a branch against master
  # sometimes. This can then be pasted into a pull request description and be
  # viewed by those reviewing the PR.
  git-pr-patch-data () {
    local branch=$(git branch | grep "*" | awk '{ print $2 }')
    if [[ $? == 0 ]]; then
      git request-pull -p origin/master origin $branch
    else
      echo "Error: Couldn't source branch name"
    fi
  }
fi


### Useful filesystem/project aliases ###
alias cdc="cd && clear"
alias cdcode="cd ~/code"
alias cdgo="cd ~/code/go/src"
alias cdopensource="cd $OPENSOURCE_REPO"
alias cdssh="cd $SSH_DIR"

if [ -x "$(command -v awskeyring)" ]; then
  awsenv () {
    eval "$(awskeyring env $@)";
  }
  awscp () {
    eval "$(awskeyring env $@ | pbcopy)";
  }
fi

### bash/terminal aliases ###
# xclip is apt installed, provides an easy access point to the x clipboard
# xclip requires x11, therefore it's not gonna work on MacOS because no x11
# so this should do a system/os id check before running, need a function to
# id this, possibly already written via setup.sh
# update 231118: just perform bash test to see if its installed, check later
# if this is appropriate
if [ -x "$( command -v xclip)" ]; then
  alias c="xclip"        # eg: $ pwd | c
  alias p="xclip -o"     # eg: cd `p`
fi

### python project aliases ###
alias deact="deactivate"

### aws ###
complete -C '/usr/bin/aws_completer' aws

### MIT Scheme Edwin ###
if [ -x "$( command -v mit-scheme)" ]; then
  alias edwin="mit-scheme --edit"
fi

### Venv Management ###
#export PYTHONPATH=.
#source /usr/local/bin/activate.sh

### Vim to Nvim ###
if [ -x "$( command -v nvim )" ]; then
  alias vim="nvim"
fi

### bash_completion is brew installed, if it is, source it
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

### Add /programs to PATH ###
export PATH="$PATH:$HOME/programs"
export PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin"
export GOPATH="$HOME/code/go"
export PATH="$PATH:/usr/local/bin"
### Enable superuser bin finding
PATH=$PATH:/usr/sbin:/sbin
PATH="$PATH:$HOME"

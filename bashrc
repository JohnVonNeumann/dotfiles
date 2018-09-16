# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

# enable bash_profile envvars to be used
source ~/.bash_profile

#####################################################################################

#######################################
# PERSONALLY EDITED CHANGES TO BASHRC #
#######################################

### Useful file locations
export OPENSOURCE_REPO=~/code/open_source
export BACKEND_REPO=~/code/work/travel_analytics
export FRONTEND_REPO=~/code/work/frontend
export INFRA_REPO=~/code/work/infrastructure
export SSH_DIR=~/.ssh

### ansible related shortcut/functions ###
avedit () {
  ansible-vault edit $1
}

avview () {
  ansible-vault view $1
}

apb () {
 ansible-playbook $1 --ask-vault-pass
} 

### yamllinting function for non-annoying parsing of config
yl () {
  yamllint -c $INFRA_REPO/.yamllint $1
}

### Random system functions, not all of which are written by me
wifi_strength () {
  watch -n 1 "awk 'NR==3 {print \"WiFi Signal Strength = \" \$3 \"00 %\"}''' /proc/net/wireless"
}

### lazy js dist packaging, i could learn a tool lol
packagemelikeoneofyourfrenchgirls () {
  cd $FRONTEND_REPO
  npm install
  npm run build
  cp -r dist/ $BACKEND_REPO/backend 
}

### development environment
localdevenv () {
  $(packagemelikeoneofyourfrenchgirls)
  cd $BACKEND_REPO/backend
  uwsgi --ini uwsgi.ini
}

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
  #  + | command following will be exec'd after first file is read
  # -s | silent mode
  # -c | command, i think, docs are shaky, doesnt work without 
  # -x | use encryption, doesnt seem to work without it, hangs

### accessing hosted services ###
alias database="psql --host=$DB_HOST --port=$DB_PORT --username=$DB_USERNAME --dbname=$DB_NAME"
alias webserver="ssh -i $SSH_DIR/$WEBSERVER_SSH_KEY $WEBSERVER_SSH_USER@$WEBSERVER_IP" 

### git aliases ###
alias gitremoveallmergedlocals="git branch --merged | egrep -v '(^\*|master|dev)' | xargs git branch -d"
alias gitpersonal="git config user.name $GIT_PERSONAL_NAME && git config user.email $GIT_PERSONAL_EMAIL"

### Useful filesystem/project aliases ###
alias lsprocessroles="ls $INFRA_REPO/ansible/roles/process/aws/"
alias lsgenericroles="ls $INFRA_REPO/ansible/roles/generic/aws/"
alias cdopensource="cd $OPENSOURCE_REPO"
alias cdbackend="cd $BACKEND_REPO"
alias cdfrontend="cd $FRONTEND_REPO"
alias cdansible="cd $INFRA_REPO/ansible"
alias cdinfra="cd $INFRA_REPO"
alias cdssh="cd $SSH_DIR"
alias cdprocessroles="cd $INFRA_REPO/ansible/roles/process && ls"
alias cdgenericroles="cd $INFRA_REPO/ansible/roles/generic && ls" 

### bash/terminal aliases ###
# xclip is apt installed, provides an easy access point to the x clipboard
alias c="xclip"        # eg: $ pwd | c
alias p="xclip -o"     # eg: cd `p`

### python project aliases ###
alias lintmelikeoneofyourfrenchgirls="pylint --rcfile=conf/pylint.conf backend"
alias deact="deactivate" 

### aws ###
complete -C '/usr/bin/aws_completer' aws

### MIT Scheme Edwin ###
alias edwin="mit-scheme --edit"

### Venv Management ###
export PYTHONPATH=.
source /usr/local/bin/activate.sh

### Vim to Nvim ###
alias vim="nvim"

### Add /programs to PATH ###
export PATH="$PATH:$HOME/programs"
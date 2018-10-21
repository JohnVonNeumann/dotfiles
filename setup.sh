#!/bin/bash
# I don't think I've written these `elifs` correctly, I suspect the entire point of an `elif` is
# to not contain a second else 

# A possible fix for the sudo issue presented by the CI pipeline:
# Utilise vars within the pipeline and inside the script that identify whether
# the script is running in a non sudo environment or not, for example, run with
# sudo on hosts, and without sudo inside build pipelines `if x is defined then`
# This doesn't even need to be self defined, travis sets its own envvars, use
# one of those

set -e

mkdir ~/.config/nvim
touch ~/.config/nvim/init.vim
cat <<EOF > ~/.config/nvim/init.vim
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc
EOF
# Amazon Linux are ridiculously non-standard, they don't keep any of the usual
# `/etc/*-release` files and even the call to `lsb_release -a` only contains
# one useful piece of information. I was hoping to have the `yum` based stuff
# all follow the same install/identification path, but I'll have to make things
# a bit more custom.
if [[ "$( lsb_release -a )" =~ "Amazon" ]]; then
	echo "/etc/os-release found!"
    cat /etc/os-release
	echo "Most likely based on Yum package manager."
	if [ "$(which yum)" ]; then
		echo "Yum is installed."
		echo "blah"
		# install heaps of neovim stuff
		yum -y install epel-release
		curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo
		yum -y install neovim
	else
		echo "Yum is not installed."
	fi
elif [[ "$( lsb_release -a )" =~ "Ubuntu" ]]; then
	echo "Ubuntu/Debian is most likely installed."
	echo "Most likely uses apt. Checking for apt."
	if [ "$( which apt )" ]; then
		echo "Apt is installed."
        if [[ $test_environment ]]; then
             apt-get install python-dev python-pip python3-dev python3-pip -y
             apt-add-repository ppa:neovim-ppa/stable -y
             apt-get update -y
             apt-get install neovim -y
             curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
                 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        else
		     # This is untested
		     # do the same process for ubuntu/debian based stuff"
		     sudo apt-get install python-dev python-pip python3-dev python3-pip -y
		     sudo apt-add-repository ppa:neovim-ppa/stable -y
		     sudo apt-get update -y
		     sudo apt-get install neovim -y
		     curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        fi
	else
		echo "Apt is not installed. Perhaps the original ID was incorrect."
	fi
# echo $MACHTYPE seems like a good solution for all operating systems as it is
# a BASH set var so it will always be found by a bash script
elif [[ $MACHTYPE =~ "darwin" ]]; then
	echo "Is MacOS"
    if [ "$(which brew)" == 0 ]; then
		echo "Brew is installed, installing other dependencies."
		# Install Neovim stuff
        # what basically needs to happen here is that you do a brew install of
        # vim with --with-python3 which will install with python3 support and
        # enable support for vim plugins that require it ( a lot of them)
        brew install vim --with-python3
        # then youll need to move the new brew installed version of vim to the
        # default location of `which vim` which also requires (i think) knowing
        # the version of the newly installed package, this can probably be
        # parsed out of the brew install operation
        cp /usr/local/Cellar/vim/*/bin/vim /usr/local/bin/vim
        # then you'll be required to install vimplug
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
             https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        # then finally, run a PlugInstall to install the contents of vimrcs 
        # plugin entry list
        # https://stackoverflow.com/questions/13522599/how-to-run-vim-commands-from-terminal
        # in order to get support for deoplete you much also run
        # `pip3 install neovim` for some reason i don't know why however this
        # can most likely be bundled in with the command set above and run from
        # inside vim
        # https://github.com/Shougo/deoplete.nvim/issues/727
	else
		echo "Brew is not installed. Installing."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
fi


# somewhere in all of this, identification of either vim or neovim requires
# the installation of vimplug, and this is different for both vim and neovim,
# with different install paths for each.
# follow https://github.com/junegunn/vim-plug#installtion for each
# script it in

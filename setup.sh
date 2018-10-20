#!/bin/bash
# I don't think I've written these `elifs` correctly, I suspect the entire point of an `elif` is
# to not contain a second else 
mkdir ~/.config/nvim
touch ~/.config/nvim/init.vim
cat <<EOF > ~/.config/nvim/init.vim
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc
EOF
if [ -f /etc/os-release ]; then
	techo "/etc/os-release found!"
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
elif type lsb_release >/dev/null 2>&1; then
	echo "Ubuntu/Debian is most likely installed."
	echo "Most likely uses apt. Checking for apt."
	if [ "$(which apt)" ]; then
		echo "Apt is installed."
		# This is untested
		# do the same process for ubuntu/debian based stuff"
		sudo apt-get install python-dev python-pip python3-dev python3-pip -y
		sudo apt-add-repository ppa:neovim-ppa/stable -y
		sudo apt-get update -y
		sudo apt-get install neovim -y
		curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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

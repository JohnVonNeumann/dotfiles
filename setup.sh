#!/bin/bash

mkdir ~/.config/nvim
touch ~/.config/nvim/init.vim
cat <<EOF > ~/.config/nvim/init.vim
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc
EOF
if [ -f /etc/os-release ]; then
	echo "/etc/os-release found!"
	echo "Most likely based on Yum package manager."
	if [ `which yum` ]; then
		echo "Yum is installed."
		echo "blah"
		# install heaps of neovim stuff
	else
		echo "Yum is not installed."
	fi
elif [ -f /etc/
# do the same process for ubuntu/debian based stuff"
sudo apt-get install python-dev python-pip python3-dev python3-pip -y
sudo apt-add-repository ppa:neovim-ppa/stable -y
sudo apt-get update -y 
sudo apt-get install neovim -y
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
elif [ 
# pseudo-code 
# if echo $OSTYPE has darwin in the string, then the os is mac, do stuff

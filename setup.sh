#!/bin/bash

mkdir ~/.config/nvim
touch ~/.config/nvim/init.vim
cat <<EOF > ~/.config/nvim/init.vim
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc
EOF
sudo apt-get install python-dev python-pip python3-dev python3-pip -y
sudo apt-add-repository ppa:neovim-ppa/stable -y
sudo apt-get update -y 
sudo apt-get install neovim -y
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

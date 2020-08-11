#!/bin/bash

vimDir=/opt/vim
vimProf=/opt/vim/profile
vimInst=/opt/vim/vim
vimSrc=$vimInst/src

# set the umask
umask 077 $vimDir

# clone the project
cd $vimInst
git clone https://github.com/vim/vim.git $vimInst
# checking ou to the right tag
git checkout tags/v8.0.1428

cd $vimSrc 

sudo apt install -y build-essential
sudo apt-get install libncurses5-dev libncursesw5-dev 
# configure before make
#./configure --with-features=huge --enable-gui=auto 
#./configure --with-features=huge --enable-gui=auto --enable-pythoninterp
./configure --with-features=huge --enable-gui=auto --enable-python3interp

# install necessary lib

# make it
make

# check the make result
make check

# configure ~/.vimrc file
sh -c 'printf "set runtimepath^='$vimProf'\nruntime .vimrc" > /home/'$USER'/.vimrc'

# install 
sudo make install

# clean files created by make
make clean
make distclean

# get back to autoload folder
mkdir $vimProf/autoload

# ensuring cURL installation
sudo apt install curl

# dowload pathogeni
curl -LSso $vimProf/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# get back to bundle folder
mkdir $vimProf/bundle
cd $vimProf/bundle/

# ensure globally installation of jshint
npm install -g jshint

# install plugins
git clone https://github.com/fatih/vim-go.git vim-go
git clone https://github.com/scrooloose/nerdtree.git nerdtree
# php
git clone https://github.com/vim-php/vim-composer.git vim-composer
git clone https://github.com/vim-php/vim-phpunit.git vim-phpunit
# snipmate
git clone https://github.com/tomtom/tlib_vim.git tlib_vim
git clone https://github.com/MarcWeber/vim-addon-mw-utils.git vim-addon-mw-utils
git clone https://github.com/garbas/vim-snipmate.git vim-snipmate
# node plugins
git clone https://github.com/moll/vim-node.git vim-node
git clone https://github.com/jelera/vim-javascript-syntax.git vim-javascript-syntax
git clone https://github.com/jamescarr/snipmate-nodejs.git snipmate-nodejs
git clone https://github.com/walm/jshint.vim jshint

# install compiled vim as a possible default system text editor
echo "Do you want to install the compiled vim as a possible system default text editor?"
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1000

# ask for set compiled vim as the system default text editor
echo "Select the system default text editor:"
sudo update-alternatives --config editor


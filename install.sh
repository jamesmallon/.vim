#!/bin/bash

vimProf="~/vim/profile"
vimBndl=~/vim/profile/bundle
vimAuto=~/vim/profile/autoload

# configure ~/.vimrc file
sh -c 'printf "set runtimepath^='$vimProf'\nruntime .vimrc" > ~/.vimrc'

# ensuring cURL installation
sudo apt install curl

# get back to autoload folder
mkdir $vimAuto

# dowload pathogeni
curl -LSso $vimAuto/pathogen.vim https://tpo.pe/pathogen.vim

# get back to bundle folder
mkdir $vimBndl 
cd $vimBndl

# ensure globally installation of jshint
npm install -g jshint

# install plugins
git clone https://github.com/fatih/vim-go.git 
git clone https://github.com/scrooloose/nerdtree.git
# php
git clone https://github.com/vim-php/vim-composer.git
git clone https://github.com/vim-php/vim-phpunit.git 
# symfony
git clone https://github.com/beyondwords/vim-twig.git 
# snipmate
git clone https://github.com/tomtom/tlib_vim.git 
git clone https://github.com/MarcWeber/vim-addon-mw-utils.git 
git clone https://github.com/garbas/vim-snipmate.git 
# node plugins
git clone https://github.com/moll/vim-node.git 
git clone https://github.com/jelera/vim-javascript-syntax.git 
git clone https://github.com/jamescarr/snipmate-nodejs.git 
git clone https://github.com/walm/jshint.vim 

# install compiled vim as a possible default system text editor
echo "Do you want to install the compiled vim as a possible system default text editor?"
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1000

# ask for set compiled vim as the system default text editor
echo "Select the system default text editor:"
sudo update-alternatives --config editor

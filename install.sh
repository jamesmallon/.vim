#!/bin/bash

vimProf="~/vim/profile"
vimBndl=~/vim/profile/bundle
vimAuto=~/vim/profile/autoload

# ensuring vim installation
if [ -z "$(which vim)" ]; then
    printf "\n"'\e[36m'"Oops "'\e[33m'"vim "'\e[36m'" is not installed.\nIt is necessary to have it installed first.\n - We will just add some plugins and add some configs and functions to your .vimrc\n\n"'\e[1;38;5;27;48;5;15m'"Do you want me to install it now? [Y/n]"'\e[0m'"\n"

    read resp

    if [ -z "$resp" ]; then
        sudo apt install vim
    else
        printf '\e[36m'"Ok, install vim and run this script again."'\e[0m'"\n"
        exit 1
    fi
fi

# configure ~/.vimrc file
sh -c 'printf "set runtimepath^='$vimProf'\nruntime .vimrc" > ~/.vimrc'

# ensuring cURL installation
if [ -z "$(which curl)" ]; then
    printf "\n"'\e[36m'"Hey! You don't have "'\e[33m'"curl "'\e[36m'" installed.\n\n"'\e[1;38;5;27;48;5;15m'"Do you want me to install it now? [Y/n]"'\e[0m'"\n"

    read resp

    if [ -z "$resp" ]; then
        sudo apt install curl
    else
        printf '\e[36m'"Ok, install curl and run this script again."'\e[0m'"\n"
        exit 1
    fi
fi

# get back to autoload folder
mkdir $vimAuto

# dowload pathogeni
curl -LSso $vimAuto/pathogen.vim https://tpo.pe/pathogen.vim

# get back to bundle folder
mkdir $vimBndl 
cd $vimBndl

# ensure globally installation of jshint
if [ -z "$(which npm)" ]; then
    printf "\n"'\e[36m'"Hmm I've checked that you don't have "'\e[33m'"npm "'\e[36m'" installed.\n\n"'\e[1;38;5;27;48;5;15m'"Do you want to install it now? [Y/n]"'\e[0m'"\n"

    read resp

    if [ -z "$resp" ]; then
        sudo apt install npm
        npm install -g jshint
    else
        printf '\e[36m'"Ok, install npm and run this script again."'\e[0m'"\n"
        exit 1
    fi
fi

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

# ask for set compiled vim as the system default text editor
printf '\e[36m'"Select the system default text editor:\n"'\e[0m'
sudo update-alternatives --config editor

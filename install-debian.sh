#!/bin/bash
# Author Thiago Mallon <thiagomallon@gmail.com>

vimProf=~/.vim/profile
vimBndl=~/.vim/profile/bundle
vimAuto=~/.vim/profile/autoload

# adding some interactive text color
printCyan() {   
    printf '\e[36m'"$1"'\e[0m';
}

printYellow() { 
    printf '\e[33m'"$1"'\e[0m';
}

printRedSpecial() {
    printf '\e[1;38;5;198;48;5;15m'"$1"'\e[0m';
}

# ensuring vim installation
if [ -z "$(which vim)" ]; then
    printCyan "\nIt seems that you don't have "; printYellow "vim "; printCyan " is not installed.\nIt is necessary to have it installed first.\n - We will just add some plugins and add some configs and functions to your .vimrc\n\n"; printRedSpecial "Do you want me to install it now? [Y/n]"; printf "\n";

    read resp

    if [ -z $resp ] || [ $resp == "Y" ] || [ $resp == "y" ]
    then
        sudo apt install vim
    else
        printCyan "Ok, install vim and run this script again.\n";
        exit 1
    fi
fi

# configure ~/.vimrc file
sh -c 'printf "set runtimepath^='$vimProf'\nruntime .vimrc" > ~/.vimrc'

# ensuring cURL installation
if [ -z "$(which curl)" ]; then
    printCyan "\nIt seems that you don't have "; printYellow "curl "; printCyan " installed.\n\n"; printRedSpecial "Do you want me to install it now? [Y/n]"; printf "\n";

    read resp

    if [ -z $resp ] || [ $resp == "Y" ] || [ $resp == "y" ]
    then
        sudo apt install curl
    else
        printCyan "Ok, install curl and run this script again.\n";
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

# ensuring git installation
if [ -z "$(which git)" ]; then
    printCyan "\nIt seems that you don't have "; printYellow "git"; printCyan " installed.\n\n"; printRedSpecial "Do you want me to install it now? [Y/n]"; printf "\n";

    read resp

    if [ -z $resp ] || [ $resp == "Y" ] || [ $resp == "y" ]
    then
        sudo apt install git
    else
        printCyan "Ok, install git and run this script again.\n";
        exit 1
    fi
fi

# ensuring go installation
if [ -z "$(which go)" ]; then
    GOVERSION="1.14.4"
    printCyan "\nIt seems that you don't have "; printYellow "go"; printCyan " installed.\n\n"; printRedSpecial "Do you want me to download and install it now? [Y/n]"; printf "\n";

    read resp

    if [ -z $resp ] || [ $resp == "Y" ] || [ $resp == "y" ]
    then
        printCyan "Going to install "; printYellow "GO $GOVERSION\n"
        wget https://dl.google.com/go/go$GOVERSION.linux-amd64.tar.gz
        sudo tar -C /usr/local -xzf go$GOVERSION.linux-amd64.tar.gz
        rm go$GOVERSION.linux-amd64.tar.gz
        sh -c 'printf "export GOROOT=/usr/local/go\nexport GOPATH=\$HOME/go\nexport PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH" >> ~/.profile'
    else
        printCyan "Ok, install go and run this script again.\n";
        exit 1
    fi
fi

# environment plugins
git clone https://github.com/fatih/vim-go.git 
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/sheerun/vim-polyglot

# snipmate
git clone https://github.com/tomtom/tlib_vim.git 
git clone https://github.com/MarcWeber/vim-addon-mw-utils.git 
git clone https://github.com/garbas/vim-snipmate.git 

# javascript
git clone https://github.com/maksimr/vim-jsbeautify

# set up jsbeautify submodule
cd vim-jsbeautify && git submodule update --init --recursive

# ask for set compiled vim as the system default text editor
printCyan "Select the system default text editor:\n"
sudo update-alternatives --config editor

#!/bin/bash
# Author Thiago Mallon <thiagomallon@gmail.com>

vimProf=~/.vim/profile
vimBndl=~/.vim/profile/bundle
vimAuto=~/.vim/profile/autoload

# adding some interactive text color
printOrange() {
    printf "\33[40;33m$1\33[0m";
}

printBlue() {
    printf "\33[40;34m$1\33[0m";
}

printRed() {
    printf "\33[40;31m$1\33[0m";
}

install_go() {
        GOIVER="$(curl -s https://golang.org/VERSION?m=text)"
        printOrange "Preparing to install "; printBlue "GO $GOIVER\n"
        wget https://dl.google.com/go/$GOIVER.linux-amd64.tar.gz
        sudo tar -C /usr/local -xzf $GOIVER.linux-amd64.tar.gz
        rm $GOIVER.linux-amd64.tar.gz
        sh -c 'printf "export GOROOT=/usr/local/go\nexport GOPATH=\$HOME/go\nexport PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH" >> ~/.profile'

PROGRAMS=("vim" "curl" "git" "go")

for i in "${!PROGRAMS[@]}" 
do
    # ensuring vim installation
    if ! command -v ${PROGRAMS[$i]} &> /dev/null
        printOrange "\nIt seems that you don't have "; printBlue "${PROGRAMS[$i]} "; 
        printOrange "Would you like to install it now? [Y/n]\n";

        read resp

        if [ -z $resp ] || [ $resp == "Y" ] || [ $resp == "y" ]
        then
            if [ "${PROGRAMS[$i]}" = "go" ]; 
            then
                install_go
                continue
            fi
            sudo apt install ${PROGRAMS[$i]}
        else
            printRed "Ok, install vim and run this script again.\n";
            exit 1
        fi
    fi
done

# get back to autoload folder
mkdir $vimAuto

# dowload pathogeni
curl -LSso $vimAuto/pathogen.vim https://tpo.pe/pathogen.vim

# get back to bundle folder
mkdir $vimBndl 
cd $vimBndl

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
printOrange "Select the system default text editor:\n"
sudo update-alternatives --config editor

#!/bin/bash
# Author: Thiago Mallon <thiagomallon@gmail.com>

LOG="./errors.log"

exec 2>> >(tee -a "$LOG")

vimProf=~/.vim/profile
vimBndl=~/.vim/profile/bundle
vimAuto=~/.vim/profile/autoload
AV_PKG=("dnf" "yum" "apt-get" "apt" "pacman")
PKGMNG=""
PROGRAMS=("vim" "curl" "git" "go")

# adding some interactive text color
printOrange() {
    printf "\e[40;33m$1\e[0m\n";
}

printBlue() {
    printf "\e[40;34m$1\e[0m\n";
}

printRed() {
    printf "\e[40;31m$1\e[0m\n";
}

grab_pkgmng(){
    for i in "${!AV_PKG[@]}"
    do
        if command -v ${AV_PKG[$i]} &> /dev/null
        then
            PKGMNG=${AV_PKG[$i]}
            break
        fi
    done
    if [ -z "$PKGMNG" ];
    then
        printRed "Package manager not supported" 
        exit 1;
    fi
}

ensure_depend(){
    for i in "${!PROGRAMS[@]}" 
    do
        # ensuring vim installation of required programs
        if ! command -v ${PROGRAMS[$i]} &> /dev/null
        then
            printOrange "\nIt seems that you don't have "; printBlue "${PROGRAMS[$i]} "; 
            printOrange "Would you like to install it now? [y/n]\n";
            read resp
            case $resp in
                [yY]) install_req ${PROGRAMS[$i]} ;;
                [Nn]) printRed "Ok, install ${PROGRAMS[$i]} and run this script again.\n"; exit 0;;
                * ) echo "Invalid answer.";;
            esac
        fi
    done
}

install_go() {
    GOIVER="$(curl -s https://golang.org/VERSION?m=text)"
    printOrange "Preparing to install "; printBlue "GO $GOIVER\n"
    wget https://dl.google.com/go/$GOIVER.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf $GOIVER.linux-amd64.tar.gz
    rm $GOIVER.linux-amd64.tar.gz
    sh -c 'printf "export GOROOT=/usr/local/go\nexport GOPATH=\$HOME/go\nexport PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH" >> ~/.profile'
}

install_req() {
    if [ "$1" = "go" ]; 
    then
        install_go
    else
        if [ "$PKGMNG" = "pacman" ]
        then
            eval sudo $PKGMNG -Syu ${1}
        else
            eval sudo $PKGMNG install ${1}
        fi
    fi
}

setup_env() {
	# configure ~/.vimrc file
	sh -c 'printf "set runtimepath^='$vimProf'\nruntime .vimrc" > ~/.vimrc'

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
}

set_as_default() {
    case "$XDG_CURRENT_DESKTOP" in
        "XFCE")
            sed -i 's/export EDITOR=\/usr\/bin\/nano/export EDITOR=\/usr\/bin\/vim/g' ~/.profile 
            ;;
        "GNOME")
            sudo update-alternatives --config editor
            ;;
    esac
}

install() {
    grab_pkgmng
    ensure_depend
    setup_env

    printOrange "Would you like to set Vim as the default text editor: [y/n]\n"
    read resp
    case $resp in
        [yY]) set_as_default
        ;;
        [Nn]) exit 0;;
        * ) echo "Invalid answer.";;
    esac
}
install

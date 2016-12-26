#!/bin/bash

# creates the directory
sudo mkdir /opt/vim

# set the permissions
sudo chown $USER:$USER -R /opt/vim
chmod go= -R /opt/vim

# set the umask
umask 077 /opt/vim

# clone the project
git clone https://github.com/vim/vim.git /opt/vim
# checking ou to the right tag
cd /opt/vim
git checkout tags/v8.0.1365

cd /opt/vim/src

sudo yum groupinstall "Development tools" -y
sudo yum install ncurses ncurses-devel wget git -y
# configure before make
#./configure --with-features=huge --enable-gui=auto 
./configure --with-features=huge --enable-gui=auto --enable-pythoninterp
#./configure --with-features=huge --enable-gui=auto --enable-python3interp

# install necessary lib

# make it
make

# check the make result
make check

# configure ~/.vimrc file
sh -c 'printf "set runtimepath^=/opt/vim/profile\nruntime .vimrc" > /home/'$USER'/.vimrc'

# install 
sudo make install

# clean files created by make
make clean
make distclean

# create profile folder
mkdir /opt/vim/profile

# get the .vimrc file
cd /opt/vim/profile/
wget https://raw.githubusercontent.com/johnthegreenobrien/Vim-8-OMine/Yum/profile/.vimrc

# get the colortheme files
mkdir /opt/vim/profile/colors
cd /opt/vim/profile/colors
wget https://raw.githubusercontent.com/johnthegreenobrien/Vim-8-OMine/Yum/profile/colors/nordic.vim
wget https://raw.githubusercontent.com/johnthegreenobrien/Vim-8-OMine/Yum/profile/colors/mallon.vim
wget https://raw.githubusercontent.com/johnthegreenobrien/Vim-8-OMine/Yum/profile/colors/tundra.vim
wget https://raw.githubusercontent.com/johnthegreenobrien/Vim-8-OMine/Yum/profile/colors/kai.vim

# get back to autoload folder
mkdir /opt/vim/profile/autoload
cd /opt/vim/profile/autoload/

# dowload pathogeni
curl -LSso /opt/vim/profile/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# get back to bundle folder
mkdir /opt/vim/profile/bundle
cd /opt/vim/profile/bundle/

# install plugins
git clone https://github.com/fatih/vim-go.git vim-go
git clone https://github.com/scrooloose/nerdtree.git nerdtree
git clone https://github.com/vim-php/vim-composer.git vim-composer
git clone https://github.com/vim-php/vim-phpunit.git vim-phpunit

# install compiled vim as a possible default system text editor
echo "Do you want to install the compiled vim as a possible system default text editor?"
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim

# ask for set compiled vim as the system default text editor
echo "Select the system default text editor:"
sudo update-alternatives --config editor

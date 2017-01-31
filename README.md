# Customized compiled Vim for Debian distros
It has customized color themes, snippets and .vimrc file. The goal is get a development based Vim version esiear and faster by using a compiled version and a bash file to make it ready in minutes. 

The customizations will be found in color themes, snippets and .vimrc file - all for development in PHP, Golang and Javascriptl

# Installation

- create the folder /opt/vim 
- apply the right permissions - sudo chown $USER:$USER /opt/vim/; sudo chmod 700 /opt/vim; cd /opt/vim; umask 077;
- clone the project to /opt/vim - git clone https://github.com/jamesmallon/Vim.git /opt/vim/
- run the install.sh file - ./install.sh

# installed plugins
- pathogen
- nerdtree
- vim-go
- vim-composer
- vim-phpunit
- tlib_vim
- vim-addon-mw-utils
- vim-snipmate
- vim-node
- vim-javascript-syntax
- snipmate-nodejs
- jshint

Have fun!

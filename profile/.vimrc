" Author: Thiago Mallon <thiagomallon@gmail.com>

" set nocompatible

"colorscheme kai
colorscheme mallon 
"colorscheme tundra 
"colorscheme nordic
set incsearch " vim highlights you string search as you're typing it
set autoindent " vim keeps the spaces and tabs of above lines while you're adding new lines (great for coding)
set smartindent " vim automatically indent lines inside of curly braces
set ruler " displays the cursor position all the time
set showcmd " displays incomplete commands
set wildmenu " displays vim complete suggestions for system functions
set scrolloff=5 " sets the lines remaining on top when using z command
set hlsearch " highlights your searching matches
"set ignorecase " disables case sensitive string searches (good to use with smartcase)
"set smartcase " vim use case sensitive string searches if it detects any uppercase character
"set nobackup " disables backup files - vim will not create a copy of the file you're editing before you save it
"set backupdir=./.backups
set backupdir=~/.vim/.backups
"set noswapfile "no swap files
set dir=~/.vim/.swap "directory for the swap files
"set dir=./.swap "directory for the swap files
set autowrite
set smarttab
set linebreak
set et
set title
"set spell
set autoread "enable file auto refresh
au CursorHold * checktime

set colorcolumn=85 " set a right border to serv as a sign to the line max length"
"%left 2 "padding between line number and text
set nuw=4 "padding between nerdtree border and line number 
"set mouse=a "enable mouse wheel scrolling
set mouse=c "enable mouse selectin
set history=5 " keep the last 5 commands in memory
set matchtime=2
set matchpairs+=<:>

" allow multiple edition in vim's buffer
set hidden

" vim-jsbeautify
map <c-f> :call JsBeautify()<cr>

"syntax enable
syntax on
filetype on
filetype plugin indent on
filetype indent on
set sw=4 " sets the tab size of normal mode equals 4 spaces
set ts=4 " sets the tab size equals 4 spaces
set sts=4 " tabs are removed as tabs not as 4 spaces

set fdm=manual "folding method to manual
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L" " displays the filename and other specifications

set fileencodings=utf-8 " sets the file charset
set encoding=utf8
set guifont=DroidSansMono\ Nerd\ Font\ 11

" snipmate configurations
"set ft=yml " snippets can be used in yml files

execute pathogen#infect()

autocmd vimenter * NERDTree
set backspace=indent,eol,start

let NERDTreeShowHidden=1 " Config to show hidden file and folders

"let NERDTreeChDirMode=2 " Config to refresh directories
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" maps nerdtree toggle function to F6 key
:nmap <F6> :NERDTreeToggle<CR> 
:imap <F6> :NERDTreeToggle<CR> 
:vmap <F6> :NERDTreeToggle<CR> 

" toggle line number
map <F2> :set nu! <CR>
nmap <F2> :set nu! <CR>
imap <F2> <Esc>:set nu! <CR>i
vmap <F2> <Esc>:set nu! <CR>v

" toggle the relative line number
map <F3> :set rnu! <CR>
nmap <F3> :set rnu! <CR>
imap <F3> <Esc>:set rnu! <CR>i
vmap <F3> <Esc>:set rnu! <CR>v

"fixing brain bugs
abbr inlcude include
abbr fucntion function
abbr ruetnr return
abbr return return
abbr Author Author: Thiago Mallon <thiagomallon@gmail.com>

" Function to delete all unchanged buffers
function! DeleteHiddenBuffers()
    let tpbl=[]
    let closed = 0
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        if getbufvar(buf, '&mod') == 0
            silent execute 'bwipeout' buf
            let closed += 1
        endif
    endfor
    echo "Closed ".closed." hidden buffers"
endfunction

" workaround for vim-go bug
function! ReleaseTmpFolder(tempFolder, user)
    execute '!mkdir /tmp/'.a:tempFolder
    execute '!chown '.a:user.':'.a:user.' /tmp/'.a:tempFolder
endfunction
function! PHPFix()
    write
    execute '!clear; phpcbf %; phpcs %'
    write
endfunction

" Change the default snipmate trigger key to <tab>
:imap <tab> <Plug>snipMateNextOrTrigger

"
function! UpsertIndenting()
    let extension = expand('%:e')
    if extension == 'php'
        :call PHPFix()
    endif
endfunction

:map <F3> :call UpsertIndenting()<CR>
:nmap <F3> :call UpsertIndenting()<CR>
:imap <F3> <Esc> :call UpsertIndenting()<CR>
:vmap <F3> <Esc> :call UpsertIndenting()<CR>

" Build and run c script 
function! CBuild()
    let extension = expand('%:e')
    if extension == 'c'
        write
        execute '!clear;  mkdir debug 2> /dev/null;  mkdir release 2> /dev/null;  gcc -g %:p -o debug/%:r;  gcc %:p -o release/%:r; printf "\33[1;32mDebug and Release successfully built for %:r.c\33[0m\n";'
    endif
endfunction

" Build and run gdb 
function! CBuildRunDebug()
    let extension = expand('%:e')
    if extension == 'c'
        write
        call CBuild()
        execute '!clear; gdb -q debug/%:r;'
    endif
endfunction
map <F4> <Esc> :call CBuildRunDebug()<CR>
imap <F4> <Esc> :call CBuildRunDebug()<CR>
vmap <F4> <Esc> :call CBuildRunDebug()<CR>
noremap <F4> <Esc>:w<CR>:call CBuildRunDebug()<CR>

" Build/run project with make
function! CMake()
    let extension = expand('%:e')
    if extension == 'c'
        write
        execute '!clear; make; make clean;'
    endif
endfunction
map <F6> <Esc> :call CMake()<CR>
imap <F6> <Esc> :call CMake()<CR>
vmap <F6> <Esc> :call CMake()<CR>
noremap <F6> <Esc>:w<CR>:call CMake()<CR>

" Run script 
function! RunScript()
    let extension = expand('%:e')
    if extension == 'py' || extension == 'sh'
        write
        execute '!clear;%:p'
    elseif extension == 'c'
        call CBuild()
        execute '!clear; release/%:r;'
    endif
endfunction
map <F5> <Esc>:call RunScript()<CR>
imap <F5> <Esc>:call RunScript()<CR>
vmap <F5> <Esc>:call RunScript()<CR>
noremap <F5> <Esc>:w<CR>:call RunScript()<CR>

" suppressing errors related to vim-go
let g:go_version_warning = 0

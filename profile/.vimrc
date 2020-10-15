" Author: Thiago Mallon <thiagomallon@gmail.com>

" set nocompatible
" snipmate configurations
"set ft=yml " snippets can be used in yml files

execute pathogen#infect()

autocmd vimenter * NERDTree
set backspace=indent,eol,start
set guifont=DroidSansMono\ Nerd\ Font\ 11

set nuw=4 "padding between nerdtree border and line number 
let NERDTreeShowHidden=1 " Config to show hidden file and folders

"let NERDTreeChDirMode=2 " Config to refresh directories
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" maps nerdtree toggle function to F6 key
:nmap <F6> :NERDTreeToggle<CR> 
:imap <F6> :NERDTreeToggle<CR> 
:vmap <F6> :NERDTreeToggle<CR> 

"colorscheme kai
colorscheme mallon 
"colorscheme tundra 
"colorscheme nordic

"syntax enable
syntax on
filetype on
filetype plugin indent on
filetype indent on
"autocmd Filetype c setlocal noexpandtab ts=4 sw=4 sts=4 "individual indentation rules 
set sw=4 " sets the tab size of normal mode equals 4 spaces
set ts=4 " sets the tab size equals 4 spaces
set sts=4 " tabs are removed as tabs not as 4 spaces
set autoindent " keeps the spaces and tabs from above lines 
set smartindent " automatically indent lines inside of curly braces

"folding 
set fdm=manual "folding method to manual
"set fdm=syntax "automatic folding based on the programming language syntax
"set fdm=indent "automatic folding based in the indentation 
autocmd BufWinLeave *.* mkview " make the view automatically
autocmd BufWinEnter *.* silent loadview " load the views automatically

"set shiftwidth=4 " sets the tab size of normal mode equals 4 spaces 
"set tabstop=4 " sets the tab size equals 4 spaces
set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L" " displays the filename and other specifications
set fileencodings=utf-8 " sets the file charset
set encoding=utf8
"set guifont=DroidSansMono\ Nerd\ Font\ 11
set incsearch " vim highlights you string search as you're typing it
"set list " show invisible characters
set ruler " displays the cursor position all the time
set showcmd " displays normal mode incomplete commands while you type
set wildmenu " displays vim complete suggestions for system functions
set scrolloff=5 " sets the remaining lines on bottom, bellow the cursor
"set scrolloff=999 " makes the cursor always in the middle of the screen
set hlsearch " highlights your searching matches
"set ignorecase " disables case sensitive string searches (good to use with smartcase)
"set smartcase " vim use case sensitive string searches if it detects any uppercase character
set autowrite
set smarttab
set linebreak
"set listchars=tab:→\ ,eol:↲ "setting tab char to u2192 and eol char to u21b2 (Ctrl+v)
set et
set title
"set nobackup " disables backup files - vim will not create a copy of the file you're editing before you save it
"set backupdir=./.backups
set backupdir=~/.vim/.backups
"set noswapfile "no swap files
set dir=~/.vim/.swap "directory for the swap files
"set dir=./.swap "directory for the swap files
"set spell
set autoread "enable file auto refresh
set colorcolumn=86 " set a right border to serv as a sign to the line max length"
"%left 2 "padding between line number and text
"set mouse=a "enable mouse wheel scrolling
set mouse=c "enable mouse selectin
set history=5 " keep the last 5 commands in memory
set matchtime=2
set matchpairs+=<:>
set hidden "allow multiple edition in vim's buffer
set backspace=indent,eol,start

"fixing brain bugs
abbr inlcude include
abbr fucntion function
abbr ruetnr return
abbr return return
abbr exapnd expand
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

set nu " displays line number
" toggle line number
map <F2> :set nu! <CR>
nmap <F2> :set nu! <CR>
imap <F2> <Esc>:set nu! <CR>i
vmap <F2> <Esc>:set nu! <CR>v

" toggle the relative line number
map  <leader><F2> :set rnu! <CR>
nmap <leader><F2> :set rnu! <CR>
imap <leader><F2> <Esc>:set rnu! <CR>i
vmap <leader><F2> <Esc>:set rnu! <CR>v

" function to compile and run assembly (local script-only)
function! s:AsmBuild()
    write
    let l:comm = "!clear;"
    let l:comm .= "nasm -felf64 %:p -o %:r.o;"
    let l:comm .= "ld %:r.o -o %:r;"
    let l:comm .= "./%:r"
    execute l:comm
endfunction

" Run script 
function! RunScript()
    let l:ext = expand("%:e")
    if l:ext == 'py' || l:ext == "sh"
        write
        execute "!clear;%:p"
    elseif l:ext == 'c'
        call CBuild("rls")
    elseif l:ext == 'asm' || l:ext == 's'
        call AsmBuild()
    endif
endfunction
map <F5> :call RunScript() <CR>
imap <F5> <Esc> :call RunScript() <CR>
vmap <F5> <Esc> :call RunScript() <CR>
map <leader><F5> :call CBuild("dbg") <CR>
imap <leader><F5> <Esc> :call CBuild("dbg") <CR>
vmap <leader><F5> <Esc> :call CBuild("dbg") <CR>
"noremap <F5> <Esc>:w<CR>:call RunScript()<CR>
" suppressing errors related to vim-go
let g:go_version_warning = 0

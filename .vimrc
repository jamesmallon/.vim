" Author: Thiago Mallon <thiagomallon@gmail.com>

"netrw configurations (nerdtree style)
"let g:netrw_banner = 0 "disable banner ('s' still works for sorting content
"let g:netrw_liststyle = 3 
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 16
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END
"let g:netrw_winsize = 50 "restore default window split size

"colorscheme elflord 
colorscheme peachpuff

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
abbr func function
abbr ruetnr return
abbr ret return
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

" Run make
let mk = "!clear; make;"
map <F3> :execute mk<CR>
imap <F3> <Esc> :execute mk<CR>
vmap <F3> <Esc> :execute mk<CR>
"noremap <F3> <Esc>:w<CR> :execute mk<CR>
" Run make clean
let mkc = "!clear; make clean;"
map  <leader><F3> :execute mkc<CR>
imap <leader><F3> <Esc> :execute mkc<CR>
vmap <leader><F3> <Esc> :execute mkc<CR>
"noremap <F3> <Esc>:w<CR> :execute mkc<CR>

" function aux. to CBuild (local script-only)
function! s:CheckCMode(mode) 
    let l:opts = "-Wall" " if no mode, then only warnings
    if a:mode ==? "hd" " insensitive
        let l:opts .= " -Werror" " warnings as errors
    elseif a:mode ==? "sft"
        let l:opts = "" " not even warnings
    endif
    return l:opts
endfunction

" Build and run c scripts
" first arg. action: 'rls'(release) or 'dbg'(debug)
" second arg. mode: 'hd', 'sft' or '' 
" third arg. libs: the lib(s) you want to use
" :call CBuild("","","-l pthread") 
" :call CBuild("rls","","`pkg-config --cflags --libs gtk+-2.0`") 
" or you can use a Makefile...
function! CBuild(action,...)
    if expand("%:e") == 'c'
        write
        let l:opts = s:CheckCMode(get(a:, 1, ""))
        let l:libs = get(a:, 2, "")
        let l:clr = "!clear;"
        let l:cmd = "mkdir %:p:h/debug %:p:h/release 2> /dev/null;"
        let l:cmd .= "gcc -g ".l:libs." ".l:opts." %:p -o %:p:h/debug/%:t:r;"
        let l:cmd .= "gcc -O3 ".l:libs." ".l:opts." %:p -o %:p:h/release/%:t:r;"
        if a:action == "dbg"
            let l:cmd .= "gdb -q %:p:h/debug/%:t:r;"
        elseif a:action == "rls"
            let l:cmd .= "%:p:h/release/%:t:r;"
        endif
        "execute l:clr."echo '".l:cmd."'"
        execute l:clr.l:cmd
    endif
endfunction
map  <F4> :call CBuild("rls","hd")<CR>
imap <F4> <Esc> :call CBuild("rls","hd")<CR>
vmap <F4> <Esc> :call CBuild("rls","hd")<CR>
map  <leader><F4> :call CBuild("dbg","hd")<CR>
imap <leader><F4> <Esc> :call CBuild("dbg","hd")<CR>
vmap <leader><F4> <Esc> :call CBuild("dbg","hd")<CR>
"noremap <F4> <Esc>:w<CR>:call CBuild()<CR>

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

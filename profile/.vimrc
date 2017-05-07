" set nocompatible

"colorscheme kai
colorscheme mallon 
"colorscheme tundra 
"colorscheme nordic
set number " displays line number
set incsearch " vim highlights you string search as you're typing it
set autoindent " vim keeps the spaces and tabs of above lines while you're adding new lines (great for coding)
set smartindent " vim automatically indent lines inside of a curly braces
set ruler " displays the cursor position all the time
set showcmd " displays incomplete commands
set wildmenu " displays vim complete suggestions for system functions
set scrolloff=5 " sets the lines remaining on top when using z command
set hlsearch " highlights your searching matches
"set ignorecase " disables case sensitive string searches (good to use with smartcase)
"set smartcase " vim use case sensitive string searches if it detects any uppercase character
set nobackup " disables backup files - vim will not create a copy of the file you're editing before you save it
set autowrite
set smarttab
set linebreak
set et
set title
set noswapfile
"set backupdir=backups/
"set spell
set autoread " enable file auto refresh
au CursorHold * checktime
"autocmd BufWrite *.php :! phpcbf % 

set colorcolumn=85 " set a right border to serv as a sign to the line max length"
"%left 2 "padding between line number and text
set nuw=4 "padding between nerdtree border and line number 
"set mouse=a "enable mouse wheel scrolling
set mouse=c "enable mouse selectin
set history=5 " keep the last 5 commands in memory
set tabstop=4
set matchtime=2
set matchpairs+=<:>

" allow multiple edition in vim's buffer
set hidden

syntax enable
filetype plugin indent on
filetype indent on
set sw=4

map <f2> :w\|!python %

set shiftwidth=4 " sets the tab size equals 4 spaces
set tabstop=4 " sets the tab size equals 4 spaces

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
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" maps nerdtree toggle function to F6 key
nmap <F6> :NERDTreeToggle<CR> 

" <F2> calls ToggleLineNumber
function! ToggleLineNumber()
    set number!
endfunction
:map <F2> :call ToggleLineNumber()<CR>

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
    execute '!chown '.a:user..':'.a:user.' /tmp/'.a:tempFolder
endfunction

" workaround for Fedora's bug
"function! PHPFix()
"    execute '!clear'
"    execute '!phpcbf %'
"    execute '!phpcs %'
"endfunction
function! PHPFix()
    execute '!clear; phpcbf %; phpcs %'
endfunction

" Change the default snipmate trigger key to <tab>
" :imap <C-l> <Plug>snipMateTrigger 
:imap <tab> <Plug>snipMateNextOrTrigger

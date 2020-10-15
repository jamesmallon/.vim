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

" Show the preprocessed or the disassembled code for the file being edited
function! CheckCTemps(action,...)
    write
    let l:libs = get(a:, 1, "")
    call CBuild("","",l:libs)
    if a:action == 'i'
        :e debug/%:r.i
    elseif a:action == 's'
        :e debug/%:r.s
    endif
    echom "Makefile?"
endfunction
map <F6> :call CheckCTemps('i')<CR>
imap <F6> <Esc> :call CheckCTemps('i')<CR>
vmap <F6> <Esc> :call CheckCTemps('i')<CR>
map <leader><F6> :call CheckCTemps('s')<CR>
imap <leader><F6> <Esc> :call CheckCTemps('s') <CR>
vmap <leader><F6> <Esc> :call CheckCTemps('s') <CR>

"
" Name: mallon 
" Version: 1.0.0
" Maintainer: Thiago Mallon <thiaomallon@gmail.com
" Licence: The MIT Licence (MIT)
" 
" Description:
"   Vim colorscheme by Thiago Mallon.
"
:set background=dark
:highlight clear
if version > 580
hi clear
if exists("syntax_on")
syntax reset
endif
endif
let colors_name = "mallon"

"%left 2 "padding between line number and text
set nuw=4 "padding between nerdtree border and line number      

:hi ColorColumn ctermbg=235
:hi Normal guifg=White guibg=grey15
:hi Cursor guibg=khaki guifg=slategrey
:hi VertSplit ctermfg=241 ctermbg=241 cterm=NONE guifg=#64645e guibg=#64645e gui=NONE
:hi Folded guibg=black guifg=grey40 ctermfg=grey ctermbg=darkgrey
:hi FoldColumn guibg=black guifg=grey20 ctermfg=4 ctermbg=7
:hi IncSearch guifg=green guibg=black cterm=none ctermfg=yellow ctermbg=green
":hi ModeMsg guifg=goldenrod cterm=none ctermfg=brown
:hi MoreMsg guifg=SeaGreen ctermfg=darkgreen
"color to fill non written area
:hi NonText cterm=NONE ctermbg=NONE ctermfg=black gui=NONE guibg=black guifg=black
:hi EndOfBuffer ctermfg=black ctermbg=none
:hi Question guifg=springgreen ctermfg=green
:hi Search guibg=peru guifg=wheat cterm=none ctermfg=black ctermbg=blue
:hi SpecialKey guifg=yellowgreen ctermfg=darkgreen
:hi StatusLine ctermfg=231 ctermbg=241 cterm=bold guifg=#f8f8f2 guibg=#64645e gui=bold
:hi StatusLineNC ctermfg=231 ctermbg=241 cterm=NONE guifg=#f8f8f2 guibg=#64645e gui=NONE
:hi Title guifg=gold gui=bold cterm=bold ctermfg=yellow
:hi Statement guifg=CornflowerBlue ctermfg=lightblue
":hi Statement guifg=CornflowerBlue ctermfg=blue
:hi Visual gui=none guifg=khaki guibg=olivedrab cterm=reverse
:hi WarningMsg guifg=salmon ctermfg=1
:hi String guifg=SkyBlue ctermfg=cyan
:hi Comment ctermfg=242 ctermbg=NONE cterm=NONE guifg=#75715e guibg=NONE gui=NONE
:hi Constant guifg=#ffa0a0 ctermfg=brown
:hi Special guifg=darkkhaki ctermfg=brown
:hi Identifier guifg=salmon ctermfg=red
:hi Include guifg=red ctermfg=red
:hi PreProc guifg=red guibg=white ctermfg=red
:hi Operator guifg=Red ctermfg=Red
:hi Define guifg=gold gui=bold ctermfg=yellow
:hi Type guifg=CornflowerBlue ctermfg=2
:hi Function guifg=navajowhite ctermfg=brown
:hi Structure guifg=green ctermfg=green
":hi LineNr guifg=grey50 ctermfg=3
:hi LineNr ctermfg=102 ctermbg=237 cterm=NONE guifg=#90908a guibg=#3c3d37 gui=NONE 
":hi LineNr ctermfg=102 ctermbg=237 cterm=NONE guifg=NONE guibg=NONE gui=NONE 
:hi Ignore guifg=grey40 cterm=bold ctermfg=7
:hi Todo guifg=orangered guibg=yellow2
:hi Directory ctermfg=cyan
:hi ErrorMsg cterm=bold guifg=White guibg=Red cterm=bold ctermfg=7 ctermbg=1
:hi VisualNOS cterm=bold,underline
:hi WildMenu ctermfg=0 ctermbg=3
:hi DiffAdd ctermbg=4
:hi DiffChange ctermbg=5
:hi DiffDelete cterm=bold ctermfg=4 ctermbg=6
:hi DiffText cterm=bold ctermbg=1
:hi Underlined cterm=underline ctermfg=5
:hi Error guifg=White guibg=Red cterm=bold ctermfg=7 ctermbg=1
:hi SpellErrors guifg=White guibg=Red cterm=bold ctermfg=7 ctermbg=1

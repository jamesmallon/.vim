  " local syntax file - set colors on a per-machine basis:
  " vim: tw=0 ts=4 sw=4
  " Vim color file
  " Maintainer:	Thiago Mallon <thiagomallon@gmail.com>
  " Last Change:	2017 Dez 02
  
  set background=dark
  hi clear
  if exists("syntax_on")
  syntax reset
  endif
  let g:colors_name = "nordic"
  hi Normal  guibg=#424242 guifg=#F3F3F3 ctermbg=black ctermfg=255
  hi NonText cterm=NONE ctermbg=black ctermfg=238 gui=NONE guibg=black guifg=#F3F3F3 
  hi EndOfBuffer ctermfg=black ctermbg=none
  hi Comment	term=bold		ctermfg=DarkCyan		guifg=#80a0ff
  hi Constant	term=underline	ctermfg=Magenta		guifg=Magenta
  hi Special	term=bold		ctermfg=DarkMagenta	guifg=Red
  hi Identifier term=underline	cterm=bold			ctermfg=Cyan guifg=#40ffff
  hi Statement term=bold		ctermfg=Yellow gui=bold	guifg=#aa4444
  hi PreProc	term=underline	ctermfg=LightBlue	guifg=#ff80ff
  hi Type	term=underline		ctermfg=LightGreen	guifg=#60ff60 gui=bold
  hi Function	term=bold		ctermfg=White guifg=White
  hi Repeat	term=underline	ctermfg=White		guifg=white
  hi Operator				ctermfg=Red			guifg=Red
  hi Ignore				ctermfg=black		guifg=bg
  hi Error	term=reverse ctermbg=Red ctermfg=White guibg=Red guifg=White
  hi Todo	term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow
  
  hi StatusLine guibg=#207050 guifg=#D8D8D8 ctermbg=29 ctermfg=188 gui=italic cterm=italic
  hi TabLineSel guibg=#207050 guifg=#D8D8D8 ctermbg=29 ctermfg=188 
  
  hi VertSplit ctermfg=241 ctermbg=241 cterm=NONE guifg=#64645e guibg=#64645e gui=NONE
  hi StatusLineNC guibg=#191919 guifg=#6F6F6F ctermbg=234 ctermfg=59
  hi LineNr ctermfg=102 ctermbg=237 cterm=NONE guifg=#90908a guibg=#3c3d37 gui=NONE
  
  " Common groups that link to default highlighting.
  " You can specify other highlighting easily.
  hi link String	Constant
  hi link Character	Constant
  hi link Number	Constant
  hi link Boolean	Constant
  hi link Float		Number
  hi link Conditional	Repeat
  hi link Label		Statement
  hi link Keyword	Statement
  hi link Exception	Statement
  hi link Include	PreProc
  hi link Define	PreProc
  hi link Macro		PreProc
  hi link PreCondit	PreProc
  hi link StorageClass	Type
  hi link Structure	Type
  hi link Typedef	Type
  hi link Tag		Special
  hi link SpecialChar	Special
  hi link Delimiter	Special
  hi link SpecialComment Special
  hi link Debug		Special

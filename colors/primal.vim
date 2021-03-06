" primal color scheme
" Based on tir_black color scheme, which is
" Based on ir_black from: http://blog.infinitered.com/entries/show/8

set background=dark
hi clear

if exists("syntax_on")
 syntax reset
endif

let colors_name = "primal"

" General colors
hi Normal       guifg=#D9D9D9   guibg=black     ctermfg=253     ctermbg=0
hi NonText      guifg=#070707   guibg=black     ctermfg=232     ctermbg=0

hi Cursor       guifg=black     guibg=white     ctermfg=0       ctermbg=15
hi LineNr       guifg=#3D3D3D   guibg=black     ctermfg=239     ctermbg=0

hi VertSplit    guifg=#202020   guibg=#202020   ctermfg=235     ctermbg=235
hi StatusLine   guifg=#CCCCCC   guibg=#202020   ctermfg=235     ctermbg=254     gui=italic
hi StatusLineNC guifg=black     guibg=#202020   ctermfg=0       ctermbg=235

hi Title        guifg=#f6f3e8   ctermfg=187     cterm=bold      gui=italic
hi WildMenu     guifg=black     guibg=#cae682   ctermfg=0       ctermbg=195
hi ModeMsg      guifg=black     guibg=#C6C5FE   ctermfg=0       ctermbg=189 cterm=bold   gui=bold 
hi MatchParen   guifg=#a70400   guibg=#000000   gui=bold        ctermfg=Red ctermbg=black cterm=Bold

" folding highlights
hi Folded guifg=#380C02 guibg=#000000 gui=bold,italic ctermfg=52 ctermbg=black cterm=bold 
hi Folded guifg=#680400 guibg=#0a0a0a gui=bold,italic ctermfg=52 ctermbg=232 cterm=bold 
hi FoldColumn guibg=#262626 ctermbg=234

" Visual highlighting
hi Visual guibg=#181c33 ctermfg=254 ctermbg=24

" Special keys
hi SpecialKey guifg=black guibg=red ctermfg=232 ctermbg=196 cterm=None

" Errors
hi Error gui=undercurl ctermfg=203 ctermbg=none cterm=underline guisp=#FF6C60
hi ErrorMsg guifg=white guibg=#FF6C60 gui=bold ctermfg=white ctermbg=203 cterm=bold
hi WarningMsg guifg=white guibg=#FF6C60 gui=bold ctermfg=white ctermbg=203 cterm=bold

" Cursorline highlighting if supported
if version >= 700 " Vim 7.x specific colors
    set cursorline
    " Default color
        hi Cursorline guibg=#0d0f00 gui=none ctermbg=233 cterm=none
        hi CursorColumn guibg=#0d0f00 gui=none ctermbg=233 cterm=none
    " Change to blues in Instert Mode
        autocmd InsertEnter * hi CursorColumn guibg=#000321 gui=none ctermbg=17 cterm=none
        autocmd InsertEnter * hi Cursorline guibg=#000321 gui=none ctermbg=17 cterm=none
    " Revert Color to default when leaving Insert Mode
        autocmd InsertLeave * hi Cursorline guibg=#0d0f00 gui=none ctermbg=233 cterm=none
        autocmd InsertLeave * hi CursorColumn guibg=#0d0f00 gui=none ctermbg=233 cterm=none
endif

" Menus
hi Pmenu guifg=cyan guibg=#121212 gui=None ctermfg=blue ctermbg=234 cterm=None 
hi PmenuSel guifg=black guibg=#cc7000 gui=Bold ctermfg=232 ctermbg=094 cterm=Bold 
hi PmenuSbar guifg=black guibg=white ctermfg=0 ctermbg=15
hi Pmenu guifg=#f6f3e8 guibg=#444444 ctermfg=white ctermbg=242
hi PmenuSel guifg=#000000 guibg=#cae682 ctermfg=0 ctermbg=195

" Search highlighting
hi Search guifg=black guibg=#cc7000 ctermfg=232 ctermbg=094 cterm=None

" this needs to be put into it's own function. if colorcolumn is set
" in the color scheme, then do the logic.
" highlight the 80th column
    set colorcolumn=80
    " In Vim >= 7.3, also highlight columns 120+
    if exists('+colorcolumn')
        " (I picked 120-320 because you have to provide an upper bound and 320 just covers a
        " 1080p GVim window in Ubuntu Mono 11 font.)
        let &colorcolumn="80,".join(range(120,320),",")
        highlight ColorColumn ctermbg=232 guibg=#0a0a0a
        set cursorcolumn
    else
        "fallback for Vim < v7.3
        autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
    endif

" Spelling
hi clear SpellBad
hi SpellBad gui=undercurl guisp=red cterm=standout ctermfg=red

" Diff Highlighting
hi DiffAdd guibg=#054000 ctermbg=22
hi DiffChange guibg=#002e4d ctermbg=17
hi DiffText guibg=#cccccc guifg=#000000 ctermbg=247 ctermfg=16
hi DiffDelete guibg=#990000 guifg=#000000 ctermbg=88  ctermfg=black



" ======    Syntax Highlighting     ======
hi Comment guifg=#333333 ctermfg=8

" Primitives
hi Constant guifg=#875f5f ctermfg=95
hi String guifg=#A8FF60 ctermfg=155
hi Number guifg=#FF73FD ctermfg=207
hi Boolean guifg=#afd7af ctermfg=151
hi Character guifg=#af5f00 ctermfg=130
hi link Float Number

" Statements
hi Statement guifg=#44678A ctermfg=67
hi Conditional guifg=#6699CC ctermfg=110
hi link Repeat Statement
hi Operator guifg=white ctermfg=white
hi Keyword guifg=#96CBFE ctermfg=117
hi link Exception Statement
hi link Label Statement

" Preprocessing 
hi PreProc guifg=#96CBFE ctermfg=117
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc

" Type
hi Type guifg=#c4c46c ctermfg=228
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type

" Functions
hi Identifier guifg=#5E73B1 ctermfg=68
hi Function guifg=#ba997a ctermfg=216

" Special
hi Special guifg=#E18964 ctermfg=173
hi Todo guifg=#000000 guibg=#cae682 ctermfg=0 ctermbg=195
hi link Tag Special
hi link SpecialChar Special
hi link SpecialComment Special
hi link Debug Special
hi Delimiter guifg=#AF5F00 ctermfg=brown
hi proper guifg=#ffffff gui=Bold ctermfg=255 cterm=Bold
hi global guifg=#af87d7 ctermfg=140

" ======    Language Exceptions     ======
" Java
hi javaDocSeeTag guifg=#dbca90 ctermfg=darkgray
hi link javaCommentTitle javaDocSeeTag
hi link javaDocTags javaDocSeeTag
hi link javaDocParam javaDocSeeTag
hi link javaDocSeeTagParam javaDocSeeTag
hi link javaScopeDecl Identifier
hi link javaFuncDef Function
hi link javaAnnotation Character
hi link javaTypedef Type
hi link javaClassDecl Type
hi link javaOperator Type
hi link javaStorageClass PreProc
hi link javaType Keyword
hi javaC_Java ctermfg=245
hi javaE_Java ctermfg=245
hi javaX_Java ctermfg=245
hi link javaParenT Function
hi link javaParenT1 javaParenT
hi link javaParenT2 javaParenT

" XML
hi link xmlTag Keyword
hi link xmlTagName Conditional
hi link xmlEndTag Identifier

" HTML
hi link htmlTag Keyword
hi link htmlTagName Conditional
hi link htmlEndTag Identifier

" Javascript
hi link javaScriptNumber Number
hi link javaScriptNull Constant
hi link javaScriptOperator Type
hi link javaScriptIdentifier Identifier

" Python
hi link pythonBuiltinType Keyword
hi link pythonBuiltinObj Boolean
hi link pythonOperator Conditional

" Ruby
hi rubyRegexp guifg=#B18A3D ctermfg=brown
hi rubyRegexpDelimiter guifg=#FF8000 ctermfg=brown
hi rubyEscape guifg=white ctermfg=cyan
hi rubyInterpolationDelimiter guifg=#00A0A0 ctermfg=blue
hi rubyControl guifg=#6699CC ctermfg=blue "and break, etc
hi rubyStringDelimiter guifg=#336633 ctermfg=lightgreen
hi link rubyClass Keyword
hi link rubyModule Keyword
hi link rubyKeyword Keyword
hi link rubyOperator Operator
hi link rubyIdentifier Identifier
hi link rubyInstanceVariable Identifier
hi link rubyGlobalVariable Identifier
hi link rubyClassVariable Identifier
hi link rubyConstant Type

" CSharp
hi link csXmlTag Keyword

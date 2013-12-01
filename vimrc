" VIM Configuration for Brian Clements
" Version:  1.0.6
" Date:     2013.12.01-01:56 
" Changes:  - git commands (submodules, status)
"           - rooter (submodules fix)
" ------------------

" ------------------
" Do First Settings
" ------------------
    " when started as "evim", evim.vim will a lready have done these settings.
        if v:progname =~? "evim"
            finish
        endif
    " this must be first, because it changes other options as a side effect.
        set nocompatible
    " Vundle
        filetype off
        set rtp+=~/.vim/bundle/vundle
        call vundle#rc()
        " let vundle manage vundle, required
            Bundle 'gmarik/vundle'
        " additional Bundles
            Bundle 'scrooloose/nerdcommenter'
            Bundle 'scrooloose/nerdtree'
            Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
            Bundle 'tpope/vim-fugitive'
            Bundle 'klen/python-mode'
            Bundle 'vimoutliner/vimoutliner'
            Bundle 'vim-scripts/Tagbar'
            Bundle 'wincent/Command-T'
            Bundle 'Lokaltog/powerline-fonts'
            Bundle 'chrisbra/csv.vim'
            Bundle 'mattboehm/vim-accordion'
            Bundle 'ervandew/supertab'
            Bundle 'plasticboy/vim-markdown'
            Bundle 'waylan/vim-markdown-extra-preview'
            Bundle 'airblade/vim-rooter'
            Bundle 'bling/vim-bufferline'
            Bundle 'vim-scripts/ScrollColors'
            Bundle 'brianclements/vim-popwindow'
            Bundle 'tomasr/molokai'
            Bundle 'ap/vim-css-color'
            Bundle 'tpope/vim-repeat'
            Bundle 'tpope/vim-surround'
        syntax on
        filetype plugin indent on
    " Default directory
        cd $HOME/dev

" ------------------
" General Vim Settings
" ------------------
    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        " au!
        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
    augroup END
    " Indentation
        set autoindent
        set copyindent
    " In many terminal emulators the mouse works just fine, thus enable it.
        set mouse=a
    " Search Options
        set ignorecase
        set smartcase
        set incsearch       " do incremental searching
        set hlsearch
    " allow backspacing over everything in insert mode
        set backspace=indent,eol,start
    " Temporary files
        set backup      " keep a backup file
        " set undofile    " remember undo commands
        set backupdir=$HOME/.vim/tmp/backup
        " set undodir=$HOME/.vim/tmp/undo
        set directory=$HOME/.vim/tmp/swap//
        set viewdir=$HOME/.vim/tmp/view
    " Color Support
        " Switch colors depending on GUI or in regular xterm. And if supported for
        " each, syntax is turned on.
        if has('gui_running')
            colors tir_black-custom
        else
            if &t_Co > 16
                set t_Co=256
                colors tir_black-custom
            else
                colors asu1dark
            endif
        endif
    " Wordwrap
        set nowrap
        set textwidth=0
        set sidescroll=15
        set listchars+=precedes:<,extends:>
    " Folding
        " Sets folding to occur automatically from indent but allows manual creation
            " augroup folding
                " au BufReadPre * setlocal foldmethod=indent
                " au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
            " augroup END
        set foldmethod=indent
        " Saves manual folds
            au BufWinLeave ?* mkview 1
            au BufWinEnter ?* silent loadview 1
    " highlighting
        set cursorline
        " Default color
            highlight CursorColumn ctermbg=233 guibg=#0d0f00
            highlight Cursorline ctermbg=233 guibg=#0d0f00
        " Change to blues in Instert Mode
            autocmd InsertEnter * highlight CursorColumn ctermbg=17 guibg=#000321
            autocmd InsertEnter * highlight Cursorline ctermbg=17 guibg=#000321
        " Revert Color to default when leaving Insert Mode
            autocmd InsertLeave * highlight CursorColumn ctermbg=233 guibg=#0d0f00
            autocmd InsertLeave * highlight Cursorline ctermbg=233 guibg=#0d0f00
        " highlight the 80th column
            " In Vim >= 7.3, also highlight columns 120+
            set colorcolumn=80
            set nowrap
            if exists('+colorcolumn')
                " (I picked 120-320 because you have to provide an upper bound and 320 just covers a
                " 1080p GVim window in Ubuntu Mono 11 font.)
                let &colorcolumn="80,".join(range(120,320),",")
                highlight ColorColumn ctermbg=232 guibg=#0d0d0d
                set cursorcolumn
            else
                "fallback for Vim < v7.3
                autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
            endif
        " folding highlights 94
            highlight Folded ctermbg=black ctermfg=52 cterm=bold guibg=#000000 guifg=#380C02 gui=bold,italic
            highlight FoldColumn ctermbg=234 guibg=#262626
        " for Command-T
            hi Pmenu ctermfg=blue ctermbg=234 cterm=None guifg=cyan guibg=#121212 gui=None
            hi PmenuSel ctermfg=232 ctermbg=094 cterm=Bold guifg=black guibg=#cc7000 gui=Bold
        " Search highlighting
            hi Search ctermfg=232 ctermbg=094 cterm=None guifg=black guibg=#cc7000 
        " Visual highlighting
            hi Visual ctermfg=251 ctermbg=23 guibg=#181c33
        " Special keys
            hi SpecialKey ctermfg=232 ctermbg=196 cterm=None guifg=black guibg=red
    " Omnicompletion
        set omnifunc=syntaxcomplete#Complete
    " Misc Options
        set history=1000          " lines of command line history
        set undolevels=1000       " levels of undo history
        set ruler       " show the cursor position all the time
        set showcmd     " display incomplete commands
        set termencoding=utf-8
        set tabstop=4
        set shiftwidth=4        " number of spaces to use for autoindenting
        set expandtab
        set softtabstop=4
        set shiftround
        set helplang=en
        set nomodeline
        set printoptions=paper:letter
        set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
        set scrolloff=0
        set wildmode=longest,list
        set visualbell
        set noerrorbells
        set hidden
        set title
        set showmatch
        set smarttab
        set autochdir
        " set shortmess=atI " Shorten command-line text and other info tokens
        set number
        set foldcolumn=2
        " statusline via fugitive plugin
            "the default statusline:
            "set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
            " format markers:
            "   %< truncation point
            "   %n buffer number
            "   %f relative path to file
            "   %m modified flag [+] (modified), [-] (unmodifiable) or nothing
            "   %r readonly flag [RO]
            "   %y filetype [ruby]
            "   %= split point for left and right justification
            "   %-35. width specification
            "   %l current line number
            "   %L number of lines in buffer
            "   %c current column number
            "   %V current virtual column number (-n), if different from %c
            "   %P percentage through buffer
            "   %) end of width specification
            "set statusline=%<%F%h%m%r%h%w%y\ %=\ %{fugitive#statusline()}\ lin:%l\,%L\ col:%c%V\ pos:%o\ ascii:%b\ %P
        set lazyredraw
        " automatically leave insert mode after 'updatetime' milliseconds of inaction
            " au CursorHoldI * stopinsert
            " au InsertEnter * let updaterestore=&updatetime | set updatetime=2000
            " au InsertLeave * let &updatetime=updaterestore

" ------------------
" Gvim Settings
" ------------------
    if has("gui_running")
        if &cp | set nocp | endif
        " disabled this until I know I need it
            " let s:cpo_save=&cpo
            " set cpo&vim
                " map! <S-Insert> <MiddleMouse>
                " nmap gx <Plug>NetrwBrowseX
                " nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
            " let &cpo=s:cpo_save
            " unlet s:cpo_save
        set fileencodings=ucs-bom,utf-8,default,latin1
        set guifont=Ubuntu\ Mono\ for\ Powerline\ 12
        " Other font options include:
        "   Default: Ubuntu\ Mono\ for\ Powerline\ 12
        "   Anonymous Pro for Powerline
        "   DejaVu Sans Mono for Powerline
        "   Droid Sans Mono for Powerline
        "   Inconsolata-dz for Powerline
        "   Inconsolata for Powerline
        "   Liberation Mono for Powerline-fixed
        "   Menlo Regular for Powerline
        "   Meslo LG M Regular for Powerline
        "   Source Code Pro Regular for Powerline
        " set lines=56 columns=207
        " Sessions
            " set sessionoptions+=resize,winpos
            " au VIMEnter * :source $HOME/.vim/tmp/session.vim | :source $MYVIMRC
            " au VIMLeave * :mksession! $HOME/.vim/tmp/session.vim
        set go=     " need to unset before we can add options
        set go+=acigrRp
        " Mouse Bindings
            set mouse=a
            nnoremap <2-LeftMouse> i
            inoremap <RightMouse> <ESC>
            vnoremap <RightMouse> "+y
            nnoremap <MiddleMouse> "+p
            " Force mousehide to behave. It sometimes stays hidden.
            set nomousehide " default
            autocmd InsertEnter * set mousehide
            autocmd InsertLeave * set nomousehide
    endif

" ------------------
" Custom Key Mappings
" ------------------
    " Change the mapleader from \ to ;
        let mapleader=";"
    " Quick edit and reload of .vimrc
        nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
        nnoremap <silent> <leader>evg :e $HOME/.vim/README.md<CR>
        nnoremap <silent> <leader>Sv :so $MYVIMRC<CR>
        nnoremap <silent> <leader>Sf :so %<CR>:echo 'loaded file: ' . @%<CR>
        nnoremap <silent> <leader>wSv :w<CR><bar>:so $MYVIMRC<CR>
        nnoremap <silent> <leader>eg :e ~/.gitconfig<CR>
    " Basic functions made easier
        nnoremap <silent> <leader>x :x<CR>
        nnoremap <silent> <leader>X :xa<CR>
        nnoremap <leader>q :q!
        nnoremap <leader>Q :qa!
        nnoremap <silent> <leader>w :w<CR>
        nnoremap <silent> <leader>W :wa<CR>
        nnoremap <leader>wa :saveas<space>
        nnoremap <leader>e :e<space>
        nnoremap <C-w>o :only
        nnoremap <C-w>O :only
        nnoremap <C-w><C-o> :only
        nnoremap <CR> o<Esc>
        nnoremap H I<ESC>
        vnoremap H ^
        nnoremap L A<ESC>
        vnoremap L $
    " File management
        " Delete current file
            nnoremap <silent> <leader>Sdd :!rm %<CR>:bd<CR>
        " Rename/mv current file (need to manually close buffer after)
            nnoremap <silent> <leader>Sm :!mv %:p<space>
    " clears search buffer highlighting
        nnoremap <silent> <leader>/ :ClearSearchHighlight<CR> 
    " Insert Mode Escape Made Easier
        inoremap <silent> <leader>j; <ESC>
    " Carriage Return + demote tab (only in gui)
        inoremap <C-CR> <CR><BS>
    " Cut/paste shortcuts for x-clipboard
        vnoremap <silent> <leader>sy "+y
        nnoremap <silent> <leader>sp "+p
        nnoremap <silent> <leader>sP "+P
    " Timestamp
        :nnoremap <F4> "=strftime(" %Y.%m.%d-%R")<CR>P
        :inoremap <F4> <C-R>=strftime("%Y.%m.%d-%R")<CR>
    " Cursor Nagivation
        " Enable insert mode navigation to mimic Xterm functions
            inoremap <C-j> <Down>
            inoremap <C-k> <Up>
            inoremap <C-b> <Left>
            inoremap <C-f> <Right>
            inoremap <C-d> <Del>
            inoremap <C-h> <BS>
            inoremap <C-a> <C-o>I
            inoremap <C-e> <C-o>A
            inoremap <S-Space> <c-o><C-e>
            inoremap <S-C-Space> <c-o><C-y>
        " Scroll lines quicker and better
            nnoremap <s-j> 7j
            nnoremap <s-k> 7k
            nnoremap <c-e> 10<c-e>
            nnoremap <c-y> 10<c-y>
            vnoremap <C-j> 7j
            vnoremap <C-k> 7k
    " Tabs
        nnoremap <silent> <leader>tc :tabnew<CR>
        nnoremap <silent> <leader>tq :tabclose<CR>
        nnoremap <silent> <leader>tn :tabnext<CR>
        nnoremap <silent> <leader>tp :tabprev<CR>
    " Window Commands
        " Splits; virtical and horizontal
            nnoremap <silent> <C-w>sh :belowright split<CR>
            nnoremap <silent> <C-w>sv :belowright vsplit<CR>
            nnoremap <silent> <C-w>i :belowright new<CR>
            nnoremap <silent> <C-w>s :belowright vnew<CR>
        " Easy window navigation
            nnoremap <C-w>n <C-w>w
            nnoremap <C-w>p <C-w>W
            nnoremap <C-w><CR> :JumpWindow<CR>
            nnoremap <C-j> <C-w><Down>
            nnoremap <C-k> <C-w><Up>
            nnoremap <C-h> <C-w><Left>
            nnoremap <C-l> <C-w><Right>
        " Scroll binding
            nnoremap <C-w>b :set scrollbind<CR>
            nnoremap <C-w>B :windo set scrollbind<CR>
            nnoremap <C-w>u :set noscrollbind<CR>
            nnoremap <C-w>U :windo set noscrollbind<CR>
        " Quick close last opened window
            nnoremap <silent><C-w><BS> :PopWindow<CR>
    " Disable auto-formatting for pasting large chucks of text
        set pastetoggle=<F2>
    " Folding
        nnoremap <silent><Space> za
        nnoremap <silent><S-Space> zA
        " old code 
            " nnoremap <silent><space> @=(foldlevel('.')?'za':'l')"<CR>
        nnoremap <silent><leader><S-Space> :ToggleBigFold<CR>
        nnoremap <leader><Space> zx 
        vnoremap <silent><Space> zf
    " View commands
        " Highlight special characters
            set listchars=tab:>-,trail:·,eol:$,extends:>,precedes:<
            nnoremap <silent> <leader>vs :set nolist!<CR>
            nnoremap <leader>vsc :g/^$/d<CR>
        " Line numbers toggle
            nnoremap <silent> <leader>vl :set nonumber!<CR>
        " Resize windows
            nnoremap <silent> <A-down> 7<c-w>-
            nnoremap <silent> <A-up> 7<c-w>+
            nnoremap <silent> <A-right> :vertical resize +7<cr>
            nnoremap <silent> <A-left> :vertical resize -7<cr>
            nnoremap <c-w>+ 7<c-w>+
            nnoremap <c-w>- 7<c-w>-
        " Shortcut to quickly shrink gvim to quarter size
            nnoremap <silent> <leader>vm :set columns=80 <bar> set lines=20<CR>
            nnoremap <silent> <leader>vM :set columns=190 <bar> set lines=45<CR>
        " Quick resize window
            nnoremap <silent> <C-w>r :exe "resize " . (winheight(1) * 1/4)<CR>
        " Scroll through colorschemes
            nnoremap <silent> <leader>vc :SCROLL<CR>
    " sudo-and-write command
        cmap w!! w !sudo tee % >/dev/null
    " Diff commands
        nnoremap <silent> <leader>du :diffupdate<CR>
        nnoremap <silent> <leader>dw :diffthis<CR>
        nnoremap <silent> <leader>D :diffoff<CR>
    " Buffer Navigation
        nnoremap <leader>bl :buffers<CR>:buffer<Space>
        nnoremap <leader>bg <C-^>
        nnoremap <silent> <leader>bn :bnext<CR>
        nnoremap <silent> <a-=> :bnext<CR>
        nnoremap <silent> <leader>bp :bprev<CR>
        nnoremap <silent> <a--> :bprev<CR>
        nnoremap <silent> <leader>bd :bnext<CR>:bd #<CR>
        nnoremap <silent> <leader>bq :bd<CR>
        nnoremap <silent> <leader>bQ :bd!<CR>
    " System commands
        nnoremap <leader>s? :pwd<CR>
        " Clear various caches,registers, and backup files
            nnoremap <leader>sCv :!rm ~/.vim/tmp/view/*<CR>
            nnoremap <leader>sCb :!rm ~/.vim/tmp/backup/*<CR>
            nnoremap <leader>sCs :!rm ~/.vim/tmp/swap/*<CR>
            nnoremap <leader>sCu :!rm ~/.vim/tmp/undo/*<CR>
            nnoremap <leader>sCr :ClearRegisters<CR>
            nnoremap <silent><leader>scd :cd %:p:h<CR>:pwd<CR>
        " Manually Set filetype for arbitrary buffers
            nnoremap <silent><leader>sfn :setlocal filetype=<CR>
            nnoremap <silent><leader>sfp :setlocal filetype=python<CR>
            nnoremap <silent><leader>sfm :setlocal filetype=markdown<CR>
            nnoremap <silent><leader>sfb :setlocal filetype=bash<CR>
            nnoremap <silent><leader>sfh :setlocal filetype=htmldjango<CR>
            nnoremap <silent><leader>sfl :setlocal filetype=lilypond<CR>
        " Various ways to run external commands
            " Using Shell function, displays in vim
                nnoremap <leader>sr :Shell<space>
                " Note, this visual mode version will show up with a range as an arg
                vnoremap <leader>sr :Shell<CR>
            " Launch Terminator
                nnoremap <leader>st :!terminator -f &<CR>
            " Starts up bash in vim (careful: only for simple things)
                nnoremap <leader>sS :!bash<CR>
        " Messages
            nnoremap <leader>sm :mess<CR>
    " Better Spelling and composition support
        nnoremap \s 1z=
        nnoremap \S a<C-x><C-s>
        inoremap <C-\> <Esc>[s1z=`]a
        nnoremap \a zg
        nnoremap \r zuw
        nnoremap \c b~
        nnoremap \\ :setlocal spell!<CR>
        vnoremap \q gq
        nnoremap \q gqap
        nnoremap \ww :ToggleTextWidth<CR>
    " Python
        " Unit testing
            nnoremap <leader>pti :!pythoscope --init<CR>
            nnoremap <leader>ptm :!pythoscope %:p:.
            nnoremap <leader>ptr :Shell python setup.py test<CR>
        " Run selection
            vnoremap <leader>pr :w !python<CR>
        " Run current file
            nnoremap <leader>prf :Shell python %:p<CR>
        " Run selection to new window
            " vnoremap <leader>pR :Python

" ------------------
" Functions & Tools
" ------------------
    " Bash
        " Read output of bash command to new window in vim
        function! s:ExecuteInShell(command) range
            let curwin = winnr()
            let lines = []
            if (!len(a:command))
                let lines=getline(a:firstline, a:lastline)
            endif
            let command = join(map(split(a:command), 'expand(v:val)'))
            let winnr = bufwinnr('^' . command . '$')
            silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
            setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
            echo 'Execute ' . command . '...'
            if (len(lines))
                for line in lines
                    silent! execute 'silent r! '. line
                endfor
                silent! 1d
            else
                silent! execute 'silent %!'. command
            endif
            silent! execute 'MakeSmallWindow'
            silent! redraw
            silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
            silent! execute 'nnoremap <silent> <buffer> <LocalLeader>srR :call <SID>ExecuteInShell(''' . command . ''')<CR>'
            silent! execute curwin . 'wincmd w'
            echo 'Shell command ' . command . ' executed.'
        endfunction
        command! -range -complete=shellcmd -nargs=* Shell <line1>,<line2>call s:ExecuteInShell(<q-args>)
    " Easy Global Folding
        function! ToggleBigFold()
            if !exists ("b:folded")
                exec "normal! zR"
                let b:folded = 0
            else
                if ( b:folded == 0 )
                    exec "normal! zM"
                    let b:folded = 1
                else
                    exec "normal! zR"
                    let b:folded = 0
                endif
            endif
        endfunction
        command! ToggleBigFold call ToggleBigFold()
    " Delete Empty Buffers
        function! s:CleanEmptyBuffers()
            let buffers = filter(range(0, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0')
            if !empty(buffers)
                exe 'bw '.join(buffers, ' ')
            endif
            echo 'Empty buffers deleted'
        endfunction
        command! CleanEmptyBuffers call s:CleanEmptyBuffers()
        nnoremap <silent> <leader>bc :CleanEmptyBuffers<CR>
    " Clear all registers
        function! ClearRegisters()
            let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
            let i=0
            while (i<strlen(regs))
                exec 'let @'.regs[i].'=""'
                let i=i+1
            endwhile
            echo 'All registers cleared'
        endfunction
        command! ClearRegisters call ClearRegisters()
    " Properly clear search highlighting by also emptying search buffer
        " Highlighting sometimes came back after reloading vim or other windows,
        " so this should turn if off for good.
        function! ClearSearchHighlight()
            exec 'let @/=""'
            exec 'nohl'
        endfunction
        command! ClearSearchHighlight call ClearSearchHighlight()
    " Toggle TextWidth
        function! ToggleTextWidth()
            if !exists('b:textwrap')
                exec 'setlocal textwidth=80'
                let b:textwrap = 1
                echo 'Textwidth enabled'
            else
                if( b:textwrap == 0 )
                    exec 'setlocal textwidth=80'
                    let b:textwrap = 1
                    echo 'Textwidth enabled'
                else
                    exec 'setlocal textwidth=0'
                    let b:textwrap = 0
                    echo 'Textwidth disabled'
                endif
            endif
        endfunction
        command! ToggleTextWidth call ToggleTextWidth()
    " Compose mode
        " Make textwidth wide enough to fit a wide screen. word wrap, format, 
        " turn spelling on. 
        "
        " then toggle to go back to normal code width 80-wide
    " code mode?
        " two separate modes? toggle in one?
    " Make small window
        function! MakeSmallWindow()
            let curwinsize = line('$')
            let maxsize = 15
            if curwinsize > maxsize
                exe "resize " . maxsize
            else
                exe "resize " . (line('$') + 1)
            endif
        endfunction
        command! MakeSmallWindow call MakeSmallWindow()
    " Jump between current/newest window
        function! JumpWindow()
            let curwin = winnr()
            let last_win = winnr('$')
            if !exists ("t:winstart")
                exec last_win . 'wincmd w'
                let t:winstart = curwin
            else
                if ( t:winstart == curwin )
                    let t:winstart = curwin
                    exec last_win . 'wincmd w'
                else
                    exec t:winstart . 'wincmd w'
                    unlet t:winstart
                endif
            endif
        endfunction
        command! JumpWindow call JumpWindow()
" ------------------
" Plugin Options
" ------------------
    " latex suite
        " IMPORTANT: grep will sometimes skip displaying the file name if you
        " search in a singe file. This will confuse Latex-Suite. Set your grep
        " program to always generate a file-name.
        set grepprg=grep\ -nH\ $*
        " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
        " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
        " The following changes the default filetype back to 'tex':
        let g:tex_flavor='latex'
    " lilypond
        set runtimepath+=/usr/share/lilypond/2.14.2/vim/
    " vimoutliner
        " defaults:
            let otl_install_menu=1
            let no_otl_maps=0
            let no_otl_insert_maps=0
        " overrides:
            let otl_bold_headers=0
            let otl_use_thlnk=0
            let use_space_colon=1
        " au BufWinLeave *.otl mkview
        " au BufWinEnter *.otl silent loadview
    " fugitive and git commands
        " Normal rotation
        nnoremap <leader>g :Git<space>
        nnoremap <leader>gI :!git init<CR>
        nnoremap <Leader>gi :!git init<CR> :!git add .<CR> :!git commit -S -m
            \ "Initial commit"<CR> :e %<CR>
        nnoremap <Leader>gwc :w<CR>:Gcommit -S<CR>
        nnoremap <Leader>gc :Gcommit -S<CR>
        nnoremap <Leader>gg :Gwrite<CR>:Gstatus<CR><c-w>w
        nnoremap <Leader>gt :Git tag -s v
        nnoremap <Leader>gd :Gdiff<CR>
        nnoremap <leader>gs :Git stash<CR>
        nnoremap <leader>gsp :Git stash pop<CR>
        " Structure Editing
        nnoremap <Leader>gfm :Gmove<space>
        nnoremap <Leader>gfd :Gremove<CR>
        nnoremap <Leader>gfr :Gread<CR>
        " Branching
        nnoremap <leader>gb :Git branch<space>
        nnoremap <leader>gb? :Shell git branch -a<CR>
        nnoremap <leader>gbb :Git checkout<space>
        nnoremap <leader>gbf :Git checkout -b<space>
        nnoremap <leader>gbm :Git branch -m<space>
        nnoremap <leader>gbd :Shell git branch -d<space>
        nnoremap <leader>gbD :Shell git branch -D<space>
        " Viewing status
        nnoremap <Leader>g? :Gstatus<CR>
        nnoremap <Leader>gt? :Shell git tags<CR>
        " Logs
        nnoremap <Leader>gl :Shell git hist-blk<CR>
        nnoremap <Leader>gL :Shell git hist2-blk<CR>
        nnoremap <Leader>glb :Gblame<CR>
        nnoremap <Leader>gll :!terminator -f --command="git hist" &<CR>
        nnoremap <Leader>glL :!terminator -f --command="git hist2" &<CR>
        " Remotes
        nnoremap <leader>gr? :Shell git remote -v<CR>
        nnoremap <leader>gr :Shell git remote<space>
        nnoremap <leader>gra :Git remote add github https://github.com/brianclements/
        nnoremap <leader>grc :Git remote prune<space>
        nnoremap <leader>gru :Git pull<space>
        nnoremap <leader>grP :Git push -u --tags<space>
        nnoremap <leader>grp :Git push<space>
        " Merges
        nnoremap <leader>gm :Git merge<space>
        " Submodules
        nnoremap <leader>gs? :Shell git submodule status<CR>
        nnoremap <leader>gs :Git submodule<space>
        nnoremap <leader>gsa :Git submodule add<space>
        nnoremap <leader>gss :Git submodule sync<CR>
        nnoremap <leader>gsu :Git submodule update --init --recursive<CR>
        " Other
        nnoremap <Leader>gwq :Gwq<CR>
        nnoremap <leader>gV :!gitg<CR>
    " NERDTree
        nnoremap <silent> <leader>t :NERDTreeToggle<cr>
        "autocmd vimenter * if !argc() | :NERDTreeToggle | endif
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && 
            \ b:NERDTreeType == "primary") | q | endif
        let NERDTreeIgnore=['\.pyc$', '\~$']
    " NERDCommenter
        let NERDSpaceDelims=1
        let NERDCompactSexyComs=1
    " Powerline
        "set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
        let g:Powerline_symbols = 'fancy'
        set laststatus=2
    " Python-mode
        " Activate rope
        " Keys
        " K             Show python docs
        " <Ctrl-Space>  Rope autocomplete
        " <Ctrl-c>g     Rope goto definition
        " <Ctrl-c>d     Rope show documentation
        " <Ctrl-c>f     Rope find occurrences
        " <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
        " [[            Jump on previous class or function (normal, visual, operator modes)
        " ]]            Jump on next class or function (normal, visual, operator modes)
        " [M            Jump on previous class or method (normal, visual, operator modes)
        " ]M            Jump on next class or method (normal, visual, operator modes)
        " Python Rope
            let g:pymode_rope = 1
            " Autocompletion
                let g:pymode_rope_autocomplete_map = '<C-Tab>'
            " backup plan for terminal
                inoremap <C-Space> <C-Tab>
        " Run file
            let g:pymode_run_key = '<leader>pR'
        " Documentation
            let g:pymode_doc = 1
            let g:pymode_doc_key = 'pd'
        "Linting
            let g:pymode_lint = 1
            let g:pymode_lint_checker = "pyflakes,pep8"
            " Ignore errors and warnings
                " let g:pymode_lint_ignore = 'E501,W002'
            " Auto check on save
                let g:pymode_lint_write = 1
            " Auto open cwindow if errors found
                let g:pymode_lint_cwindow = 1
        " Support virtualenv
            let g:pymode_virtualenv = 1
        " Enable breakpoints plugin
            let g:pymode_breakpoint = 1
            let g:pymode_breakpoint_key = '<leader>pb'
        " syntax highlighting
            let g:pymode_syntax = 1
            let g:pymode_syntax_all = 1
            let g:pymode_syntax_indent_errors = g:pymode_syntax_all
            let g:pymode_syntax_space_errors = g:pymode_syntax_all
        " Don't autofold code (built-in VIM folding does it better)
            let g:pymode_folding = 0
        " Change add some rope mapping
            " Rope go to definition
                nnoremap <leader>pg :call RopeGotoDefinition()<CR>
            " Rope Documentation
                nnoremap <leader>pd :call RopeShowDoc()<CR>
            " Rope find occurences
                nnoremap <leader>pf :call RopeFindOccurrences()<CR>
            " Rope rename function
                nnoremap <leader>prr :call RopeRename()<CR>
        " Auto check on save
            let g:pymode_lint_write = 1
    " CTags
        let Tlist_Ctags_Cmd = "/usr/bin/ctags"
        let Tlist_WinWidth = 50
        map <F3> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
    " Tagbar
        nnoremap <leader>tt :TagbarToggle<CR>
    " Bufferline
        let g:bufferline_active_buffer_left = '('
        let g:bufferline_active_buffer_right = ')'
        let g:bufferline_rotate = 2
        let g:bufferline_fname_mod = ':t'
    " Command-T
        nnoremap <leader>f :CommandT<CR>
        nnoremap <silent> <leader>ff :CommandTFlush<CR>
        let g:CommandTCancelMap='<ESC>'
        let g:CommandTHighlightColor='PmenuSel'
        :set wildignore+=*.*~,*~,*.git,*.pyc,*.pdf,*.PDF
    " Accordion Windows
        nnoremap <silent> <C-w>a :Accordion 3<CR>
        nnoremap <silent> <C-w>A :AccordionStop<CR>
        nnoremap <silent> <C-w>ad :AccordionDiff<CR>
        nnoremap <silent> <C-w>ai :AccordionZoomIn<CR>
        nnoremap <silent> <C-w>ao :AccordionZoomOut<CR>
    " Supertab
        let g:SuperTabDefaultCompletionType = "context"
    " vim-rooter
        let g:rooter_manual_only = 0
        let g:rooter_use_lcd = 1
        let g:rooter_change_directory_for_non_project_files = 1
        let g:rooter_patterns = ['.git', '.git/', '.gitignore', 'README.md',
            \ 'README.rst', 'LICENSE', 'VERSION', 'doc/', 'docs/', 'AUTHORS.MD',
            \ 'Rakefile', 'python', '.gitignore', ]
        " not working
        " nnoremap <silent> <leader>scd <Plug>RooterChangeToRootDirectory

" ------------------
" Filetype Specific Options
" ------------------
    " All files
        autocmd BufEnter *.*
            \ exec 'Rooter'
    " Markdown (default for all text files)
        autocmd BufRead,BufNewFile *.txt,*.text,*.md,*.markdown
            \ setlocal spell |
            \ setlocal textwidth=80 |
            \ setlocal filetype=markdown |
            \ setlocal foldlevel=1 |
            \ set foldcolumn=2 |
            \ nnoremap <leader>mp :Me<CR>|
            \ nnoremap <leader>mr :Mer<CR>
    " Vimrc
        autocmd Filetype vimrc
            \ setlocal nospell
    " Vim Outliner
        autocmd BufRead,BufNewFile *.otl
            \ setlocal nonumber |
            \ setlocal textwidth=80 |
            \ setlocal spell |
            \ inoremap <S-CR> <CR><C-t> |
            \ inoremap <C-S-CR> <CR><C-d><BS>
    " Lilypond Files
        autocmd BufRead,BufNewFile *.ly,*.ily
            \ setfiletype lilypond |
            \ setlocal noai nocin nosi inde= |
            \ setlocal autoindent |
            \ setlocal foldlevel=0 |
            \ nnoremap <leader>lwm :wa<CR> <bar> :!lilypond "%:p"<CR> |
            \ nnoremap <leader>lm :!lilypond "%:p"<CR> |
            \ nnoremap <leader>lms :wa<CR> <bar> :cd ../score<CR> <bar>
                \ :!lilypond "%:p:h:h/score/score.ly"<CR> <bar> :cd ../music<CR> |
            \ nnoremap <leader>lps :!timidity "%:p:h:h/score/score.midi" &<CR> |
            \ nnoremap <leader>lpS :!killall timidity &<CR> |
            \ nnoremap <leader>lv :!evince "%:p:r.pdf" &<CR> |
            \ nnoremap <leader>lvs :!evince "%:p:h:h/score/score.pdf" &<CR> |
            \ set tabstop=4 |
            \ set shiftwidth=4
            " add support for compile time errors use new :Shell command
    " Lilypond-book Files
        autocmd BufRead,BufNewFile *.lytex
            \ setfiletype lilypond |
            \ setfiletype latex |
            \ setlocal textwidth=80 |
            \ nnoremap <leader>wm :w<CR> <bar> :! lilypond-book --output=output
                \ --pdf "%:p"<CR> <bar> :cd output<CR> <bar> :! pdflatex
                \ "%:p:h/output/%:t:r.tex"<CR> :cd ..<CR> |
            \ nnoremap <leader>lbm :! lilypond-book --output=output --pdf "%:p"<CR>
                \ <bar> :cd output<CR> <bar> :! pdflatex "%:p:h/output/%:t:r.tex"
                \ <CR> :cd ..<CR> |
            \ nnoremap <leader>lbv :! acroread "%:p:h/output/%:t:r.pdf" &<CR>
    " CSV
        if exists("did_load_csvfiletype")
            finish
        endif
        let did_load_csvfiletype=1
        augroup filetypedetect
        au! BufRead,BufNewFile *.csv,*.dat
            \ setfiletype csv
        augroup END
    " HTML
        autocmd BufRead,BufNewFile *.html
            \ nnoremap <leader>hf :%s/<[^>]*>/\r&\r/g<CR> |
            \ nnoremap <leader>hc :g/^$/d<CR> |
            \ setfiletype htmldjango |
            \ nnoremap <leader>hp :!chromium-browser --incognito "%:p" &<CR> |
            \ set omnifunc=htmlcomplete#CompleteTags
    " JavaScript
        autocmd FileType javascript
            \ set omnifunc=javascriptcomplete#CompleteJS
    " CSS
        autocmd BufRead,BufNewFile *.css
            \ nnoremap <leader>hf :%s/<[^>]*>/\r&\r/g<CR> |
            \ nnoremap <leader>hc :g/^$/d<CR> |
            \ setfiletype css |
            \ set omnifunc=csscomplete#CompleteCSS
    " Python
        autocmd BufRead,BufNewFile *.py
            \ set omnifunc=pythoncomplete#Complete |
            \ set foldnestmax=2 |
            \ set foldlevel=0 |
            \ set foldlevelstart=2

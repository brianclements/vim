" VIM Configuration for Brian Clements
" URL:      github.com/brianclements/vim
" Version:  1.3.1-4
" Date:     2014.07.06-18:39 
" Changes:  
" - NERDTreeToggleCWD() => NERDTreeRefreshFind() with minor fixes
" - updated virtualenv commands for python3
" - pylint ignore list reset command: built it into program, never keybinded it.
" - converted unittesting tools to python3
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
            Bundle 'lfairy/lilyvim'
            Bundle 'jmcantrell/vim-virtualenv'
            Bundle 'christoomey/vim-tmux-navigator'
            Bundle 'stephpy/vim-yaml'
            Bundle 'gilsondev/searchtasks.vim'
        syntax on
        filetype plugin indent on
    " Default directory
        cd $PWD

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
    " Color Scheme
        let colorscheme = 'primal'
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
        " Enter/Exit insert mode delay
        set ttimeoutlen=10
        augroup FastEscape
            autocmd!
            au InsertEnter * set timeoutlen=400
            au InsertLeave * set timeoutlen=1000
        augroup END

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
        " Set gui colors
        exec "colors " . colorscheme
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
    else " some things for terminal only
        " Spelling highlight Compatibility
        hi clear SpellBad
        hi SpellBad cterm=bold,italic ctermfg=red
        " Set xterm and last resort tty colors
        if &t_Co > 16
            set t_Co=256
            exec "colors " . colorscheme
        else
            colors miro8
        endif
    endif

" ------------------
" Custom Key Mappings
" ------------------
    " Change the mapleader from \ to ;
        let mapleader=";"
    " Quick edit and reload of .vimrc
        nnoremap <silent> <leader>ev :e $HOME/.vim/vimrc <bar> NERDTreeFind<CR>
        nnoremap <silent> <leader>ed :e $DOTFILES/README.md <bar> NERDTreeFind<CR>
        nnoremap <silent> <leader>Sv :so $MYVIMRC<CR>
        nnoremap <silent> <leader>Sf :so %<CR>:echo 'loaded file: ' . @%<CR>
        nnoremap <silent> <leader>wSv :w<CR>:so $MYVIMRC<CR>
        nnoremap <silent> <leader>eg :e ~/.gitconfig<CR>
    " Basic functions made easier
        nnoremap <silent> <leader>x :x<CR>
        nnoremap <silent> <leader>X :xa<CR>
        nnoremap <leader>q :q!
        nnoremap <leader>Q :qa!
        nnoremap <silent> <leader>w :w<CR>
        nnoremap <silent> <leader>W :w!<CR>
        nnoremap <silent> <leader>ww :wa<CR>
        nnoremap <silent> <leader>WW :wa!<CR>
        nnoremap <leader>wa :saveas<space>
        nnoremap <leader>e :e<space>
        nnoremap <C-w>o :only
        nnoremap <C-w>O :only
        nnoremap <C-w><C-o> :only
        nnoremap <CR> o<Esc>
        nnoremap H ^
        vnoremap H ^
        nnoremap L $
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
        " nnoremap <silent><Space> za
        " old code works better in terminals, can't capture shift-space
            nnoremap <silent><space> @=(foldlevel('.')?'za':'l')"<CR>
        nnoremap <silent><S-Space> zA
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
            nnoremap <silent> <C-w>r :SmartResizeWindow 20<CR>
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
            nnoremap <leader>sCv :!rm -f ~/.vim/tmp/view/*<CR>
            nnoremap <leader>sCb :!rm -f ~/.vim/tmp/backup/*<CR>
            nnoremap <leader>sCs :!rm -f ~/.vim/tmp/swap/*<CR>
            nnoremap <leader>sCu :!rm -f ~/.vim/tmp/undo/*<CR>
            nnoremap <leader>sCr :ClearRegisters<CR>
            nnoremap <silent><leader>scd :cd %:p:h<CR>:pwd<CR>
        " Manually Set filetype for arbitrary buffers
            nnoremap <silent><leader>sfn :setlocal filetype=<CR>
            nnoremap <silent><leader>sfp :setlocal filetype=python<CR>
            nnoremap <silent><leader>sfm :setlocal filetype=markdown<CR>
            nnoremap <silent><leader>sfb :setlocal filetype=sh<CR>
            nnoremap <silent><leader>sfh :setlocal filetype=htmldjango<CR>
            nnoremap <silent><leader>sfl :setlocal filetype=lilypond<CR>
            nnoremap <silent><leader>sfg :setlocal filetype=gitcommit<CR>
            nnoremap <silent><leader>sfi :setlocal filetype=dosini<CR>
            nnoremap <silent><leader>sfv :setlocal filetype=help<CR>
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
        nnoremap <C-\> [s1z=`]``e
        nnoremap \a zg
        nnoremap \r zuw
        nnoremap \C b~
        nnoremap \\ :setlocal spell!<CR>
        vnoremap \q gq
        nnoremap \q gqap
        nnoremap \ww :ToggleTextWidth<CR>
    " Python
        " Unit testing
            nnoremap <leader>pti :!pythoscope --init<CR>
            nnoremap <leader>ptm :!pythoscope %:p:.
            nnoremap <leader>ptr :Shell python3 setup.py test<CR>
        " Run selection
            vnoremap <leader>pR :w !python3<CR>
        " Run current file
            nnoremap <leader>pRf :Shell python3 %:p<CR>
        " Run arbitrary command
            nnoremap <leader>pr :!python3
        " Run selection to new window
            " vnoremap <leader>pR :Python3
        " Add lint error codes to ignore list on the fly
            nnoremap <silent><leader>pli :exec 'AddPyLintIgnore ' . expand('<cword>')<CR>
        " Run lint
            nnoremap <leader>pls :PyLint<CR>
        " Clear ignore list
            nnoremap <silent><leader>plc :AddPyLintIgnore<CR>
    " tmux support: disable these keys in vim
        map <C-f>p <Nop>
        map <C-f>n <Nop>
    " Universal fold level
      " because many times, it just doesn't get activated
      nnoremap <silent> <leader>vf :set foldmethod=indent<CR>

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
            silent! execute 'SmartResizeWindow 20'
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
    " Resize a window somewhat intelligently
        function! SmartResizeWindow(...)
            let curwinsize = line('$')
            if a:0 > 0
                let maxsize = a:1
                if maxsize > curwinsize
                    exec 'resize ' . (curwinsize + 1)
                else
                    exec 'resize ' . maxsize
                endif
            else
                exec 'resize ' . (curwinsize + 1)
            endif
        endfunction
        command! -nargs=* SmartResizeWindow call SmartResizeWindow(<f-args>)
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
    " Follow symlinks when opening a file
        " Sources:
        "  - https://github.com/tpope/vim-fugitive/issues/147#issuecomment-27607563
        "  - https://github.com/tpope/vim-fugitive/issues/147#issuecomment-7572351
        "  - http://www.reddit.com/r/vim/comments/yhsn6/is_it_possible_to_work_around_the_symlink_bug/c5w91qw
        " Echoing a warning does not appear to work:
        "   echohl WarningMsg | echo "Resolving symlink." | echohl None |
        function! MyFollowSymlink(...)
        let fname = a:0 ? a:1 : expand('%')
        if getftype(fname) != 'link'
            return
        endif
        let resolvedfile = fnameescape(resolve(fname))
        exec 'file ' . resolvedfile
        endfunction
        command! FollowSymlink call MyFollowSymlink()
        autocmd BufReadPost * call MyFollowSymlink(expand('<afile>'))
    " Add to pylint ignore list on the go
        function! AddPyLintIgnore(...)
            if g:pymode == 1
                let old = g:pymode_lint_ignore
                if a:0 == 0
                    let g:pymode_lint_ignore = ""
                    echo "PyLint ignore list reset"
                elseif a:0 > 0
                    let new = a:1
                    if strlen(old) == 0
                        let g:pymode_lint_ignore = new
                    else
                        let g:pymode_lint_ignore = old . ',' . new
                    endif
                    echo "Added " . new . " to PyLint Ignore list."
                endif
            endif
        endfunction
        command! -nargs=* AddPyLintIgnore call AddPyLintIgnore(<f-args>)
    " Better NERDTree toggle
        " inspiration from: http://superuser.com/questions/195022/vim-how-to-synchronize-nerdtree-with-current-opened-tab-file-path
        " If closed -> NerdTree
        " If cursor in newfile -> NerdTree
        " If cursor in samefile -> NerdTreeToggle
        function! NERDTreeRefreshFind()
            " Check if NERDTree is open
            let ntree_buf = winbufnr(1)
            let ntree_status = 0
            if getbufvar(ntree_buf, 'NERDTreeType') ==# 'primary'
                let ntree_status = 1
            endif

            " set defaults
            let g:ntree_curwin = winnr()
            let g:ntree_this_buf = expand('%:p:h')
            if !exists ('g:ntree_prev_buf')
                let g:ntree_prev_buf = g:ntree_this_buf
            endif

            " Move cursor to prev window if in NERDTree window
            if g:ntree_this_buf =~# 'NERD_tree' 
                exec g:ntree_curwin . ' wincmd w'
                let g:ntree_this_buf = expand('%:p:h')
                let g:ntree_curwin = winnr()
                let g:ntree_prev_buf = g:ntree_this_buf
            endif

            exec 'cd %:p:h'

            " Closed, open NERDTree
            if ntree_status == 0
                let g:ntree_curwin = winnr()
                " Remember the file that's open
                let g:ntree_prev_buf = g:ntree_this_buf
                " Window numbers are changing!
                let g:ntree_curwin = g:ntree_curwin + 1
                NERDTree
            else
                " New window, refresh NERDTree
                if g:ntree_this_buf != g:ntree_prev_buf
                    NERDTreeFind
                    wincmd p
                    let g:ntree_prev_buf = g:ntree_this_buf
                else
                    " Same window, close NERDTree
                    let g:ntree_curwin = g:ntree_curwin - 1
                    NERDTreeClose
                    exec g:ntree_curwin . ' wincmd w'
                    let g:ntree_prev_buf = expand('%:p:h')
                endif
            endif
        endfunction
        command! NERDTreeRefreshFind call NERDTreeRefreshFind()

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
        nnoremap <Leader>gi :cd %:p:h<CR>:!git init<CR> :!git add .<CR> :!git commit -S -m
            \ "Initial commit"<CR> :e %<CR>
        nnoremap <Leader>gwc :w<CR>:Gcommit -S<CR>
        nnoremap <Leader>gc :Gcommit -S<CR>
        nnoremap <Leader>gg :Gwrite<CR>:Gstatus<CR><c-w>w
        nnoremap <Leader>gd :Gdiff<CR>
        nnoremap <leader>gS :Shell git stash<CR>
        nnoremap <leader>gSp :Shell git stash pop<CR>
        " Tags
        nnoremap <Leader>gt? :Shell git tags<CR>
        nnoremap <Leader>gt :Git tag -s v
        nnoremap <Leader>gtd :Git tag -d<space>
        nnoremap <Leader>gtD :Git push github :refs/tags/
        " Structure Editing
        nnoremap <Leader>gfm :Gmove<space>
        nnoremap <Leader>gfd :Gremove<CR>
        nnoremap <Leader>gfr :Gread<CR>
        nnoremap <Leader>gfc :Git clean -xdf
        nnoremap <Leader>gRH :Shell git reset --hard
        " Branching
        nnoremap <leader>gb :Git branch<space>
        nnoremap <leader>gb? :Shell git branch -a<CR>
        nnoremap <leader>gbb :Git checkout<space>
        nnoremap <leader>gbB :Git checkout <cword><CR>
        nnoremap <leader>gbf :Git checkout -b<space>
        nnoremap <leader>gbm :Git branch -m<space>
        nnoremap <leader>gbd :Shell git branch -d<space>
        nnoremap <leader>gbD :Shell git branch -D<space>
        " Viewing status
        nnoremap <Leader>g? :Gstatus<CR>:SmartResizeWindow 30<CR>:go<CR>:wincmd p<CR>
        " Logs
        nnoremap <Leader>gl :Shell git hist-blk<CR>
        nnoremap <Leader>gL :Shell git hist2-blk<CR>
        nnoremap <Leader>gls :Shell git show <cword><CR>
        nnoremap <Leader>glb :Gblame<CR>
        nnoremap <Leader>gll :!terminator -f --command="git hist" &<CR>
        nnoremap <Leader>glL :!terminator -f --command="git hist2" &<CR>
        " Remotes
        nnoremap <leader>gr? :Shell git remote -v<CR>
        nnoremap <leader>gr :Shell git remote<space>
        nnoremap <leader>gra :Git remote add github git@github.com:brianclements/
        nnoremap <leader>grc :Git remote prune<space>
        nnoremap <leader>grR :Git remote set-url github git@github.com:
        nnoremap <leader>gru :Shell git pull<space>
        nnoremap <leader>grP :Git push -u --tags<space>
        nnoremap <leader>grp :Git push<space>
        nnoremap <leader>grD :Git push github --delete<space>
        " Merges
        nnoremap <leader>gm :Git merge<space>
        nnoremap <leader>gmc :Git cherry-pick <cword><CR>
        " Rebase
        nnoremap <leader>gRs :Git rebase -i HEAD~
        nnoremap <leader>gR :Shell git rebase<space>
        " Submodules
        nnoremap <leader>gs? :Shell git submodule status<CR>
        nnoremap <leader>gs :Git submodule<space>
        nnoremap <leader>gsa :Git submodule add git@github.com:brianclements/
        nnoremap <leader>gsi :Shell git submodule init<space>
        nnoremap <leader>gsU :Shell git submodule update --init --recursive<CR>
        nnoremap <leader>gsr :Shell git submodule update --recursive<CR>
        nnoremap <leader>gsu :Shell git submodule foreach --recursive "(
            \ git pull)&"<CR>
        nnoremap <leader>gss :Shell git submodule sync<CR>
        nnoremap <leader>gsc :Shell git submodule foreach --recursive
            \ git checkout master<CR>
        nnoremap <leader>gsD :Shell git submodule deinit<space>
        " Other
        nnoremap <Leader>gwq :Gwq<CR>
        nnoremap <leader>gV :!gitg<CR>
    " NERDTree
        nnoremap <silent> <leader>t :NERDTreeRefreshFind<cr>
        " autocmd vimenter * if !argc() | :NERDTreeToggle | endif
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && 
            \ b:NERDTreeType == "primary") | q | endif
        let NERDTreeIgnore=['\.pyc$', '\~$']
    " NERDCommenter
        let NERDSpaceDelims=1
        let NERDCompactSexyComs=1
    " Powerline
        "set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
        let g:powerline_config_path = $HOME . '/.powerline'
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
        " Enable breakpoints plugin
            let g:pymode_breakpoint = 1
            let g:pymode_breakpoint_key = '<leader>pb'
        " syntax highlighting
            let g:pymode_syntax = 1
            let g:pymode_syntax_all = 1
            let g:pymode_syntax_indent_errors = g:pymode_syntax_all
            let g:pymode_syntax_space_errors = g:pymode_syntax_all
        " Disable virtualenv-support for pymode
            let g:pymode_virtualenv = 0
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
        let g:bufferline_fname_mod = ':~:.:gs?/mnt/local/vhome/brian/?~/?'
    " Command-T
        nnoremap <leader>f :CommandT<CR>
        nnoremap <silent> <leader>ff :CommandTFlush<CR>
        let g:CommandTCancelMap='<ESC>'
        let g:CommandTHighlightColor='PmenuSel'
        :set wildignore+=*.*~,*~,*.git,*.pyc,*.pdf,*.PDF
    " Accordion Windows
        nnoremap <silent> <C-w>a :Accordion 3<CR>:echo 'Accordian windows enabled'<CR>
        nnoremap <silent> <C-w>A :AccordionStop<CR>:echo 'Accordian windows disabled'<CR>
        nnoremap <silent> <C-w>ad :AccordionDiff<CR>:echo 'Accordian diff mode enabled'<CR>
        nnoremap <silent> <C-w>ai :AccordionZoomIn<CR>
        nnoremap <silent> <C-w>ao :AccordionZoomOut<CR>
    " Supertab
        let g:SuperTabDefaultCompletionType = "context"
    " vim-rooter
        let g:rooter_manual_only = 0
        let g:rooter_use_lcd = 1
        let g:rooter_change_directory_for_non_project_files = 1
        let g:rooter_patterns = ['.git', '.git/', '.gitignore', '.gitmodules',
            \ 'README.md', 'README.rst', 'LICENSE', 'VERSION', 'doc/', 'docs/',
            \ 'AUTHORS.MD', 'Rakefile', 'python', ]
        " not working
        " nnoremap <silent> <leader>scd <Plug>RooterChangeToRootDirectory
    " vim-virtualenv 
        " My main set of virtualenvs
        let $WORKON_HOME = '~/.virtualenvs'
        " Project specific virtualenvs
        let g:virtualenv_directory = '../venv'
        nnoremap <leader>pv? :VirtualEnvList<CR>
        nnoremap <leader>pva :VirtualEnvActivate<space>
        nnoremap <leader>pvd :VirtualEnvDeactivate<CR>
        nnoremap <leader>pvi :Shell virtualenv --python=/usr/bin/python3 $WORKON_HOME/
    " SearchTasks
      let g:searchtasks_list=["TODO", "FIXME", "XXX", "HACK", "BUG"]
      nnoremap <leader>us :SearchTasks . 

" ------------------
" Filetype Specific Options
" ------------------
    " All files
        autocmd BufEnter *.*
            \ exec 'Rooter' |
            \ set foldmethod=indent
    " Markdown (default for all text files)
        autocmd BufRead,BufNewFile *.text,*.md,*.markdown,*.mkd
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
    " Dockerfiles
        autocmd BufEnter *
           \ if @% == 'Dockerfile' | set ft=sh | endif

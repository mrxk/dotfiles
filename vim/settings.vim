syntax on
filetype plugin indent on

set autoindent                       " copy indent from current line when starting a new line.
set bg=dark                          " dark background
set bs=indent,eol,start              " allow bacspace over indents, end of lines, and start of lines
set ch=1                             " the number of lines taken by the command area.
set complete=.,w,b,u,t,i             " all buffers, windows, tags, and includes
set completeopt=longest,menu,preview " completion options
set diffopt=filler,vertical,context:99999 " Turn off folds in diff mode
set encoding=utf-8                   " required for YouCompleteMe
set expandtab                        " replace tabs with spaces
set hidden                           " allow buffer moves with unsaved changes
set hlsearch                         " highlight all search matches
set ignorecase                       " ignore case when searching
set incsearch                        " incremental search
set laststatus=2                     " show status line with filename
set modelines=0                      " don't honor modelines
set nobackup                         " don't create backups
set noexrc                           " don't use current directory .rc files
set noswapfile                       " don't create swap files
set nowb                             " don't create an ephemeral backup while writing
set nowrap                           " don't wrap text
set ruler                            " show the cursor position
set scrolloff=4                      " keep this many lines at the top and bottom when scrolling
set shiftwidth=4                     " indent by 4 characters
set showcmd                          " show the cumulative command at the bottom
set showmode                         " show the current mode
set sidescroll=1                     " move this many columns when scrolling right and left
set sidescrolloff=4                  " keep this many columns at the right and left when scrolling
set softtabstop=4                    " don't do soft tabs
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%{StatusLineSpaceWarning()}%-14.(%l,%c%V%)\ %P
set switchbuf=useopen,usetab         " reuse displays when switching buffers
set tabstop=4
set textwidth=78                     " 78 characters in a line by default
set wildmenu                         " turn on autocomplete menu for commands
set wildmode=list:longest,full       " show all matches and then autocomplete

"""""""""""""""""""""""""""
" Format options
" c: wrap comments at textwidth
" 1: don't break after a single character word
" 2: use second line of paragraph for indent
" j: remove comment leader when joining lines (not supported everywhere)
" l: don't break already long lines in insert mode
" n: recognize numbered lists
" o: insert comment leader after o or O in normal mode
" q: allow formatting with gq
" r: insert comment leader after <cr> in insert mode
" a: automatically reformat comments (not used here)
" t: automatically reformat text (not used here)
set formatoptions=c12lnoqr

"""""""""""""""""""""""""""
" cioptions (all others default)
" l1: align closing braces with case labels
" g0: indent scope declarations by a shiftwidth
" t0: don't indent function return types when on their own line
" (0: extra indent for continuation after unclosed parentheses
" u0: extra indent for continuation after inner unclosed parentheses
" j1: indent anonymous classes correctly
" J1: indent javascript correctly
set cinoptions=l1,g0,t0,(0,u0,j1,J1


" Block cursor for cygwin
let &t_ti="\e[1 q"
let &t_SI="\e[5 q"
let &t_EI="\e[1 q"
let &t_te="\e[0 q"

if has("folding")
    set foldlevelstart=20        " start unfolded
    set foldmethod=syntax
endif

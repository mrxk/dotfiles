" Ctrl- P     - https://github.com/kien/ctrlp.vim.git
" NerdTree    - https://github.com/scrooloose/nerdtree.git
" Fugitive    - https://github.com/tpope/vim-fugitive.git
" Tabularize  - https://github.com/godlygeek/tabular.git
" TagBar      - https://github.com/majutsushi/tagbar
" OrgMode     - https://github.com/jceb/vim-orgmode.git
" SpeedDating - https://github.com/tpope/vim-speeddating.git

" Make ctrl-o open for ctrl-p plugin
let g:ctrlp_map = '<c-o>'
let g:ctrlp_custom_ignore = '\.class$'

" Couldn't get cygwin tmux to behave with DirArrows
let g:NERDTreeDirArrows=0

" Custom Tagbar settings
let tlist_groovy_settings = 'groovy;p:package;c:class;i:interface;f:function;v:variables'
let g:tagbar_type_groovy = {
    \ 'ctagstype' : 'groovy',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'c:class',
        \ 'i:interface',
        \ 'f:function',
        \ 'v:variables',
    \ ]
\ }

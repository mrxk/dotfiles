" Ctrl- P     - https://github.com/kien/ctrlp.vim.git
" NerdTree    - https://github.com/scrooloose/nerdtree.git
" Fugitive    - https://github.com/tpope/vim-fugitive.git
" Tabularize  - https://github.com/godlygeek/tabular.git
" TagBar      - https://github.com/majutsushi/tagbar
" OrgMode     - https://github.com/jceb/vim-orgmode.git
" Calendar    - https://github.com/mattn/calendar-vim.git
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
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" Org Mode settings
" let g:org_heading_shade_leading_stars = 0
let g:org_todo_keywords = [['TODO', 'WAITING', 'INRPROGRESS', '|', 'DONE'], ['|', 'CANCELED']]
let g:org_todo_keyword_faces = [
            \['CANCELED', [':foreground red', ':background black', ':weight bold', ':slant italic', ':decoration underline']]
            \]


let g:ConqueTerm_Color = 2
let g:ConqueTerm_CloseOnEnd = 1
let g:ConqueTerm_StartMessages = 0

function DebugSession()
    make -o vimgdb -gcflags "-N -l"
    redraw!
    if (filereadable("vimgdb"))
        ConqueGdb vimgdb
    else
        echom "Couldn't find debug file"
    endif
endfunction
function DebugSessionCleanup(term)
    if (filereadable("vimgdb"))
        let ds=delete("vimgdb")
    endif
endfunction
call conque_term#register_function("after_close", "DebugSessionCleanup")
nmap <leader>d :call DebugSession()<CR>


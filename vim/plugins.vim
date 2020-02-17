" Ctrl- P     - https://github.com/kien/ctrlp.vim.git
" NerdTree    - https://github.com/scrooloose/nerdtree.git
" Fugitive    - https://github.com/tpope/vim-fugitive.git
" Tabularize  - https://github.com/godlygeek/tabular.git
" TagBar      - https://github.com/majutsushi/tagbar
" OrgMode     - https://github.com/jceb/vim-orgmode.git
" Calendar    - https://github.com/mattn/calendar-vim.git
" SpeedDating - https://github.com/tpope/vim-speeddating.git

" CtrlP settings
let g:ctrlp_map = '<c-o>'
let g:ctrlp_custom_ignore = '\.class$'

" Org Mode settings
" let g:org_heading_shade_leading_stars = 0
let g:org_todo_keywords = [['TODO', 'WAITING', 'INRPROGRESS', '|', 'DONE'], ['|', 'CANCELED']]
let g:org_todo_keyword_faces = [
            \['CANCELED', [':foreground red', ':background black', ':weight bold', ':slant italic', ':decoration underline']]
            \]

" Netrw settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Vim-go settings
let g:go_list_type = "quickfix"

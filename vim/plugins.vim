" Org Mode settings
" let g:org_heading_shade_leading_stars = 0
let g:org_todo_keywords = [['TODO', 'WAITING', 'INRPROGRESS', '|', 'DONE'], ['|', 'CANCELED']]
let g:org_todo_keyword_faces = [
            \['CANCELED', [':foreground red', ':background black', ':weight bold', ':slant italic', ':decoration underline']]
            \]


" Vim-go settings
let g:go_list_type = "quickfix"

" NERDTree settings
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1
let NERDTreeDirArrowExpandable = '+'
let NERDTreeDirArrowCollapsible = '-'

" FZF settings
let $FZF_DEFAULT_COMMAND='fdfind --type f'

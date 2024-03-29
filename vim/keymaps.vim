
" Quit
nnoremap        Q                       :confirm qa<cr>
vnoremap        Q                       <esc>:confirm qa<cr>

" Easily clear highlighting
noremap         <silent><leader><space> :noh<cr>

" Open new tabs or splits
nnoremap        <leader>t               :tabedit<cr>
nnoremap        <leader>v               <C-w>v<C-w>l
nnoremap        <leader>h               <C-w>s<C-w>j

" Buffers
nnoremap        <leader>b               :buffers<cr>:buffer<space>

" Move to the next visible line
nnoremap        j                       gj
nnoremap        k                       gk

" Move in the quickfix window
nnoremap        <S-h>                   :cp<cr>
nnoremap        <S-l>                   :cn<cr>

" Move in vimdiff
if &diff
nnoremap        <S-h>                   [c
nnoremap        <S-l>                   ]c
endif

" Move in tabs
nnoremap        <tab>                   :tabnext<cr>
nnoremap        <S-tab>                 :tabprev<cr>
nnoremap        <left>                  gT
nnoremap        <right>                 gt

" I can't stop hitting f1
inoremap        <F1>                    <ESC>
nnoremap        <F1>                    <ESC>
vnoremap        <F1>                    <ESC>

" Deal with pastemode
nnoremap        <leader>p               :set invpaste paste?<cr>

" Quickfix and location list toggles
nnoremap            <silent>^               :QFToggle<cr>
nnoremap            <silent><leader>^       :LocationToggle<cr>

" Grep local file
nnoremap        <silent><leader>g       :execute ":vimgrep " . expand("<cword>") . " %"<cr>:QFSort<cr>

" Grep all files from cwd
nnoremap        <silent><leader>G       :let word = expand("<cword>")<cr>:tabnew<cr>:execute ":vimgrep " . word . " **"<cr>:QFSort<cr>:cc1<cr>

" Tagbar
nnoremap        <S-t>                   :TagbarToggle<cr>

" NERDTree
nnoremap        <S-e>                   :NERDTreeToggle<cr>
nnoremap        <S-f>                   :NERDTreeFind<cr>

" Highlight long lines 
nnoremap        <leader>l               :LongLineHLToggle<cr>

" Format
nnoremap        <silent><leader>fj      :FormatJSON<cr>
nnoremap        <silent><leader>fx      :FormatXML<cr>
vnoremap        <silent><leader>fj      :FormatJSONRange<cr>
vnoremap        <silent><leader>fx      :FormatXMLRange<cr>

" Mapping to re-highlight an indented visual block
vnoremap        <tab>                   >gv
vnoremap        <S-tab>                 <gv

" Mapping to bubble lines of visual selection text
vnoremap         <C-J>                  xp`[V`]
vnoremap         <C-K>                  xkP`[V`]


" Mappings to try to save my pinky
nnoremap        <bs>                    :
vnoremap        <bs>                    :

" Folding
if has("folding")
    nnoremap    <silent>-               zi
endif

nnoremap <silent> <leader>ji :JiraIssue<cr>
nnoremap <silent> <leader>js :JiraSearch<cr>
nnoremap <silent> <leader>jms :JiraMySprint<cr>
nnoremap <silent> <leader>jmi :JiraMyIssues<cr>
nnoremap <silent> <leader>jh :JiraHistory<cr>
nnoremap <silent> <leader>jg :JiraGitBranch<cr>

" Search FZF on C-o and C-p.  There is a weird delay with C-p.
nnoremap <C-p> :FZF<cr>
nnoremap <C-o> :FZF<cr>

" Automatically select first match when completing words
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Sort the paragraph (for java import statements)
nnoremap <silent> <leader>sp vip:sort<cr>

" Make tab complete popups
inoremap <silent><tab> <C-R>=PopupTab()<CR>
inoremap <silent><cr> <C-R>=PopupCR()<CR>

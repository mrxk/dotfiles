
" Quit
nnoremap        Q                       :confirm qa<cr>

" Easily clear highlighting
noremap         <silent><leader><space> :noh<cr>

" Open new tabs or splits
nnoremap        <leader>t               :tabedit<cr>
nnoremap        <leader>v               <C-w>v<C-w>l
nnoremap        <leader>h               <C-w>s<C-w>j

" Buffers
nnoremap        <leader>b               :buffers<cr>:buffer<space>

" Move to the next visible line
nmap            j                       gj
nmap            k                       gk

" Move in the quickfix window
nmap            <S-n>                   :cn<cr>
nmap            <S-m>                   :cp<cr>

" Move in vimdiff
nmap            <c-n>                   ]c
nmap            <c-m>                   [c

" Move in tabs
nnoremap        <tab>                   :tabnext<cr>
nnoremap        <S-tab>                 :tabprev<cr>

" Move in windows
nnoremap        <C-h>                   <C-w>h
nnoremap        <C-j>                   <C-w>j
nnoremap        <C-k>                   <C-w>k
nnoremap        <C-l>                   <C-w>l
nnoremap        <cr>                    gj

" I can't stop hitting f1
inoremap        <F1>                    <ESC>
nnoremap        <F1>                    <ESC>
vnoremap        <F1>                    <ESC>

" Deal with pastemode
nnoremap        <c-p>                   :set invpaste paste?<cr>

" Quickfix and location list toggles
nmap            <silent>^               :QFToggle<cr>
nmap            <silent><leader>^       :LocationToggle<cr>

" Grep local file
nnoremap        <silent><leader>g       :execute ":vimgrep " . expand("<cword>") . " %"<cr>:QFSort<cr>

" Grep all files from cwd
nnoremap        <silent><leader>G       :let word = expand("<cword>")<cr>:tabnew<cr>:execute ":vimgrep " . word . " **"<cr>:QFSort<cr>:cc1<cr>

" Man page for current word
nnoremap        <leader>m               :execute ":Man " . expand("<cword>") <cr>

" Tagbar
nnoremap        <S-T>                   :TagbarToggle<cr>

" NerdTree
nnoremap        <silent><leader>n       :NERDTreeToggle<cr>

" Highlight long lines 
nnoremap        <leader>l               :LongLineHLToggle<cr>

" Format
nnoremap        <silent><leader>fj      :FormatJSON<cr>
nnoremap        <silent><leader>fx      :FormatXML<cr>
vnoremap        <silent><leader>fj      :FormatJSONRange<cr>
vnoremap        <silent><leader>fx      :FormatXMLRange<cr>

" Folding
if has("folding")
    nmap        -                       :ToggleFold<cr>
endif


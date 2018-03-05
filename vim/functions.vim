
"""""""""""""""""""""""""
" window helpers
function! s:LocationToggle()
    let currwin=winnr()
    for bufnr in tabpagebuflist()
        if getbufvar(bufnr, "&buftype") == 'quickfix' "location list is quickfix type buffer
            :lclose
            execute currwin . 'wincmd w'
            return
        endif
    endfor
    :lopen
    execute currwin . 'wincmd w'
endfunction

function! s:QFToggle()
    let currwin=winnr()
    for bufnr in tabpagebuflist()
        if getbufvar(bufnr, "&buftype") == 'quickfix'
            :cclose
            execute currwin . 'wincmd w'
            return
        endif
    endfor
    :copen
    execute currwin . 'wincmd w'
endfunction

function! s:ListCompare( i1, i2 )
    let name1 = bufname(a:i1.bufnr)
    let name2 = bufname(a:i2.bufnr)
    if( name1 == name2 )
        return a:i1.lnum == a:i2.lnum ? 0 : a:i1.lnum > a:i2.lnum ? 1 : -1
    endif
    return name1 > name2 ? 1 : -1
endfunction

function! s:QFSort()
    let qflist = sort(getqflist(), '<SID>ListCompare')
    call setqflist(qflist)
endfunction

function! s:LocationSort()
    let loclist = sort(getloclist(0), '<SID>ListCompare')
    call setloclist(0, loclist)
endfunction

function! s:ExPreview(...)
    redir @c
    silent! exe join(a:000," ")
    redir end
    silent! wincmd P
    if !&previewwindow
        new
        set pvw
        resize 11
    endif
    set noro
    normal 1GdG"cP
    silent! %s/\r$//g
    set ro
    set nomodified
    normal 1G
    wincmd p
endfunction

function! s:ShellPreview(...)
    let cmd = join(a:000," ")
    silent! wincmd P
    if !&previewwindow
        new
        set pvw
        resize 11
    endif
    set noro
    normal 1GdG
    "call append(0, split(result, '\n'))
    exe "r! " . cmd
    set ro
    set nomodified
    normal 1G
    wincmd p
endfunction

"""""""""""""""""""""""""

"""""""""""""""""""""""""
" Diff helpers
function! s:Gundiff()
    :diffoff!
    :wincmd h
    :bd
endfunction
"""""""""""""""""""""""""

"""""""""""""""""""""""""
" Local man page browsing
function! s:DoMan(args)
    new
    execute '%!man ' . a:args . ' | col -bx'
    set filetype=man
    set buftype=nofile
    set bufhidden=delete
    set ro
    setlocal noswapfile
    "%s/.//g
endfunction
"""""""""""""""""""""""""

"""""""""""""""""""""""""
" Function to toggle long line highlight toggling
function! s:LongLineHLToggle()
    if !exists('w:longlinehl')
        highlight OverLength ctermbg=red ctermfg=white guibg=#592929
        match OverLength /\%>79v.\+/
        let w:longlinehl = 1
        echo "Long lines highlighted"
    else
        highlight clear OverLength
        unl w:longlinehl
        echo "Long lines unhighlighted"
    endif
endfunction
"""""""""""""""""""""""""

"""""""""""""""""""""""""
" Format functions
function! s:FormatXML()
    " Save the current position
    let l:pos = getcurpos()
    " Insert new lines
    silent! %s/>\s*</>\r</g
    silent! %s/ \(\S\{-}\s\{-}=\s\{-}".\{-}"\)/\r\1/g
    " Change the filetype to xml
    let l:oft = &ft
    set ft=xml
    " Format the file
    normal ggVG=
    " Restore the filetype
    exe "set ft=" . l:oft
    " Remove any empty lines
    silent! exe ":g/^\s*$/d"
    " Restore the original position
    call setpos('.', l:pos)
endfunction

function! s:FormatXMLRange() range
    " Get the selected text
    let l:orig_text = getline(a:firstline, a:lastline)
    let l:new_text = []
    " For each line in the selected text, insert cariage returns in the
    " apprpriate places
    for l:line in l:orig_text
        let l:new_line = substitute(l:line, '>\s*<', '>\r<', 'g')
        let l:new_line = substitute(l:new_line, '\(\S\{-}\s\{-}=\s\{-}".\{-}"\)', '\r\1', 'g')
        let l:new_text += split(l:new_line, '\r')
    endfor
    " Delete the original selection
    exe ":" . a:firstline . "," . a:lastline . " d"
    " Add the new text
    call append(a:firstline-1, l:new_text)
    " Format as javascript
    let l:oft = &ft
    set ft=javascript
    exe ":" . a:firstline
    exe "normal =" . (len(l:new_text)-1) . "j"
    " Remove any empty lines
    silent! exe ":" . a:firstline . "," . (a:firstline+len(l:new_text)-1) . "g/^\s*$/d"
    " Restore original position and filetype
    exe ":" . a:firstline
    exe "set ft=" . l:oft
endfunction

function! s:FormatJSON()
    " Save the current position
    let l:pos = getcurpos()
    " Insert new lines
    silent! %s/{/{\r/g
    silent! %s/}/\r}/g
    silent! %s/,/,\r/g
    " Change filetype to javascript
    let l:oft = &ft
    set ft=javascript
    " Format the file
    silent! normal ggVG=
    " Restore filetype
    exe "set ft=" . l:oft
    " Remove any empty lines
    silent! exe ":g/^\s*$/d"
    " Restore the original position
    call setpos('.', l:pos)
endfunction

function! s:FormatJSONRange() range
    " Get the selected text
    let l:orig_text = getline(a:firstline, a:lastline)
    let l:new_text = []
    " For each line in the selected text, insert cariage returns in the
    " apprpriate places
    for l:line in l:orig_text
        let l:new_line = substitute(l:line, '}', '\r}', 'g')
        let l:new_line = substitute(l:new_line, '{', '{\r', 'g')
        let l:new_line = substitute(l:new_line, ',', ',\r', 'g')
        let l:new_text += split(l:new_line, '\r')
    endfor
    " Delete the original selection
    exe ":" . a:firstline . "," . a:lastline . " d"
    " Add the new text
    call append(a:firstline-1, l:new_text)
    " Format as javascript
    let l:oft = &ft
    set ft=javascript
    exe ":" . a:firstline
    exe "normal =" . (len(l:new_text)-1) . "j"
    " Remove any empty lines
    silent! exe ":" . a:firstline . "," . (a:firstline+len(l:new_text)-1) . "g/^\s*$/d"
    " Restore original position and filetype
    exe "set ft=" . l:oft
    exe ":" . a:firstline
endfunction
"""""""""""""""""""""""""

"""""""""""""""""""""""""
" Iteration functions
" Like windo but restore the current window.
function! s:WinDo(command)
    let currwin=winnr()
    execute 'windo ' . a:command
    execute currwin . 'wincmd w'
endfunction

" Like bufdo but restore the current buffer.
function! s:BufDo(command)
    let currBuff=bufnr("%")
    execute 'bufdo ' . a:command
    execute 'buffer ' . currBuff
endfunction

" Like tabdo but restore the current tab.
function! s:TabDo(command)
    let currTab=tabpagenr()
    execute 'tabdo ' . a:command
    execute 'tabn ' . currTab
endfunction
"""""""""""""""""""""""""

"""""""""""""""""""""""""
" Function to return '[TS]' if trailing whitespace dectected.  Return ''
" otherwise.  Note that this is only recalculated when vim is idle.  Depends
" on an autocommand to clear the buffer var.  Note that this function is not
" scoped to this script with the 's:' prefix because it must be called from
" elsewhere.
function! StatusLineSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[*TS*]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction
"""""""""""""""""""""""""

"""""""""""""""""""""""""
" Debugging function to return the syntax highlight group under the cursor
" Command usage:
"     :echom StatusLineCurrentHighlight()
" Not in script scope because it has to be called when rendering the status
" line
function! StatusLineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

function! s:FileInfo(filename)
  let fn = expand(a:filename)
  echo "filename: " . expand("%:p")
  echo "type    : " . getftype(fn)
  echo "mtime   : " . strftime("%Y-%m-%d %H:%M %a",getftime(fn))
  echo "size    : " . getfsize(fn) . " bytes"
  echo "perm    : " . getfperm(fn)
endfunction
"""""""""""""""""""""""""

"""""""""""""""""""""""""
" Align table
" From https://gist.github.com/tpope/287147
function! s:AlignTable()
    let p = '^\s*|.*|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction
"""""""""""""""""""""""""

"""""""""""""""""""""""""
" Delete hidden buffers
function! s:DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
"""""""""""""""""""""""""

command! -nargs=0 LocationToggle call <SID>LocationToggle()
command! -nargs=0 QFToggle call <SID>QFToggle()
command! -nargs=0 QFSort call <SID>QFSort()
command! -nargs=0 LocationSort call <SID>LocationSort()
command! -nargs=+ -complete=command ExPreview call<SID>ExPreview("<args>")
command! -nargs=+ -complete=shellcmd ShellPreview call<SID>ShellPreview("<args>")
command! -nargs=0 Gundiff call <SID>Gundiff()
command! -nargs=+ -complete=command Man call <sid>DoMan(<q-args>)
command! -nargs=0 LongLineHLToggle call <SID>LongLineHLToggle()
command! -nargs=0 FormatJSON call <SID>FormatJSON()
command! -nargs=0 -range=% FormatJSONRange <line1>,<line2>call <SID>FormatJSONRange()
command! -nargs=0 FormatXML call <SID>FormatXML()
command! -nargs=0 -range=% FormatXMLRange <line1>,<line2>call <SID>FormatXMLRange()
command! -nargs=+ -complete=command WinDo call <SID>WinDo(<q-args>)
command! -nargs=+ -complete=command BufDo call <SID>BufDo(<q-args>)
command! -nargs=+ -complete=command TabDo call <SID>TabDo(<q-args>)
command! -nargs=0 FileInfo call <SID>FileInfo('%')
command! -nargs=0 AlignTable call <SID>AlignTable()
command! -nargs=0 DeleteHiddenBuffers call <SID>DeleteHiddenBuffers()
command! -nargs=0 JiraOrchestrationSprint call jira#search('project = orchestration and sprint in openSprints()')
command! -nargs=0 JiraConfigurationSprint call jira#search('project = ngconfig and sprint in openSprints()')

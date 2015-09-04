if exists('g:loaded_jira')
  finish
endif
let g:loaded_jira = 1

let s:jira_tab = 0
let s:jira_buf = 0
let s:history = []
let s:breadcrumbs = []

function! s:open_window(type)
    let found = 0
    " Find the tab with our buffer in it
    for t in range(tabpagenr('$'))
        for b in tabpagebuflist(t+1)
            if b == s:jira_buf
                let found = 1
                let s:jira_tab = t+1
            endif
        endfor
    endfor
    if found == 1
        "Found it.  Now see if we need to move to it
        if winbufnr(0) != s:jira_buf
            execute 'normal!' s:jira_tab.'gt'
            let winnr = bufwinnr(s:jira_buf)
            execute winnr.'wincmd w'
        endif
        "Else already there.
    else
        "Did not find it.  Need to create it and save its location.
        tab new
        let s:jira_tab = tabpagenr()
        let s:jira_buf = winbufnr(0)
        call s:syntax()
        call s:assign_name()
        syntax sync fromstart
        setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
        setlocal iskeyword+=- "so issue ids count as a single word
    endif
    call s:keys(a:type)
    setlocal modifiable
    silent %d
    call append(0, "Loading jira...")
    setlocal nomodifiable
    if a:type == 'search' || a:type == 'history'
        setlocal cursorline
    else
        setlocal nocursorline
    endif
    redraw
endfunction

function! s:assign_name()
  " Assign buffer name
  let prefix = '[Jira]'
  let name   = prefix
  let idx    = 2
  while bufexists(name)
    let name = printf('%s (%s)', prefix, idx)
    let idx = idx + 1
  endwhile
  silent! execute 'f' fnameescape(name)
endfunction

function! s:syntax()
    syntax clear
    syntax match jiraIssue /[A-Z][A-Z]*-\d\d*/
    syntax match jiraTitle /^Summary$\|^Description$\|^Comments$/
    syntax region jiraCode start=/{code}/ skip=/\v\\./ end=/{code}/
    syntax region jiraCode start=/{quote}/ skip=/\v\\./ end=/{quote}/
    syntax match jiraCommentAuthor /^[A-Za-z \(\)]*\w: \d\{4}-\d\{2}-\d\{2}T\d\{2}:\d\{2}:\d\{2}\.\d\{3}-\d*[ (edited)]*$/
    syntax match jiraLink /https*:\/\/[A-Za-z\.\/0-9\-\:_\<\> ?=&+%]*/
    syntax match jiraCodeInline /{{\_.\{-}}}/ contains=jiraCodeInlineStart,jiraCodeInlineEnd containedin=ALL
    if v:version >= 703
        syntax match jiraCodeInlineStart contained /{{/ conceal
        syntax match jiraCodeInlineEnd contained /}}/ conceal
        setlocal conceallevel=2
        setlocal concealcursor=nc
    else
        syntax match jiraCodeInlineStart contained /{{/
        syntax match jiraCodeInlineEnd contained /}}/
    endif
    highlight link jiraIssue Tag
    highlight link jiraTitle Title
    highlight link jiraCode Comment
    highlight link jiraCodeInline Comment
    highlight link jiraCodeInlineStart Comment
    highlight link jiraCodeInlineEnd Comment
    highlight link jiraCommentAuthor Type
    highlight link jiraLink Underlined

endfunction

function s:wrap()
    let hits = []
    for linenr in range(1,  line('$')+1)
        let line = getline(linenr)
        if strlen(line) > 80
            call add(hits, linenr)
        endif
    endfor
    call reverse(hits)
    for hit in hits
        execute 'normal!' . hit . "Ggql"
    endfor
endfunction

function! s:keys(type)
    if a:type == 'history'
        nnoremap <silent> <buffer> <cr> :JiraHistoryAtCursor<cr>
    else
        nnoremap <silent> <buffer> <cr> :JiraIssueAtCursor<cr>
    endif
    nnoremap <silent> <buffer> <bs> :JiraHistoryPop<cr>
endfunction

function! jira#issue(key)
    if strlen(a:key)<1
        return
    endif
    call s:open_window("issue")
    execute 'python' "<< EOF"
import vim
import vimjira
vimjira.issue(vim.eval("a:key"))
EOF
endfunction

function! jira#search(query)
    if strlen(a:query)<1
        return
    endif
    call s:open_window("search")
    execute 'python' "<< EOF"
import vimjira
vimjira.search(vim.eval("a:query"))
EOF
endfunction

function! jira#history()
    call s:open_window("history")
    call add(s:breadcrumbs, 'history:')
    set modifiable
    silent %d
    call append(0, 'history')
    call append(1, s:history)
    set nomodifiable
    execute 'normal! gg'
endfunction

function! jira#history_go(line)
    let parts = split(a:line, ':')
    let type = parts[0]
    if type == 'issue'
        call jira#issue(join(parts[1:-1], ':'))
    elseif type == 'history'
        call jira#history()
    elseif type == 'query'
        call jira#search(join(parts[1:-1], ':'))
    endif
endfunction

function! jira#history_pop()
    if len(s:breadcrumbs) == 0
        echom "No previous page"
        return
    elseif len(s:breadcrumbs) == 1
        echom "No previous page"
        return
    elseif len(s:breadcrumbs) == 2
        let l:target = s:breadcrumbs[0]
        let s:breadcrumbs = []
        call jira#history_go(l:target)
    else
        let l:target = s:breadcrumbs[-2]
        let s:breadcrumbs = s:breadcrumbs[:-3]
        call jira#history_go(l:target)
    endif
endfunction

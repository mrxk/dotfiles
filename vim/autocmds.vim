" Open the quickfix window for commands that populate it
autocmd QuickFixCmdPost *grep* cwindow
autocmd QuickFixCmdPost *lvimgrep* lwindow
autocmd QuickFixCmdPost *log* cwindow

" Remove fugitive buffers when they are not displayed
autocmd BufReadPost fugitive://* set bufhidden=delete

" Map .. to 'edit parent object' in fugitive tree and blob buffers
autocmd BufReadPost fugitive://*
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

" Map <cr> to 'edit current file' in quickfix window
autocmd BufReadPost quickfix nnoremap <buffer> <cr> :.cc<cr>

" Signal to recalculate trailing whitespace warning on idle and write
autocmd CursorHold,BufWritePost * unlet! b:statusline_trailing_space_warning

augroup org_mode
    autocmd!
    autocmd FileType org nmap <c-j> m]]
    autocmd FileType org nmap <c-k> m[[
    autocmd BufEnter *.org :syntax sync minlines=250
    " Give some nmonic meaning to the org-mode mappings
    autocmd BufEnter *.org :nnoremap <localleader>tt :py ORGMODE.plugins[u"Todo"].toggle_todo_state(interactive=False)<CR>
    autocmd BufEnter *.org :nnoremap <localleader>tp :py ORGMODE.plugins[u"Todo"].toggle_todo_state(interactive=True)<CR>

    autocmd BufEnter *.org :nnoremap <localleader>at :OrgSetTags<cr>

    autocmd BufEnter *.org :nnoremap <localleader>tsa :OrgDateInsertTimestampActiveCmdLine<cr>
    autocmd BufEnter *.org :nnoremap <localleader>tsi :OrgDateInsertTimestampInactiveCmdLine<cr>
    autocmd BufEnter *.org :nnoremap <localleader>tsca :OrgDateInsertTimestampActiveWithCalendar<cr>
    autocmd BufEnter *.org :nnoremap <localleader>tsci :OrgDateInsertTimestampInactiveWithCalendar<cr>

    autocmd BufEnter *.org setlocal spell spelllang=en_us

    "autocmd BufEnter *.org :nmap <localleader>cN @<Plug>OrgCheckBoxNewAbove
    "autocmd BufEnter *.org :nmap <localleader>cn @<Plug>OrgCheckBoxNewBelow
    "autocmd BufEnter *.org :nmap <localleader>cc @<Plug>OrgCheckBoxToggle
    "autocmd BufEnter *.org :nmap <localleader>c# @<Plug>OrgCheckBoxUpdate

    " Simulate some of the table editing of emacs org mode
    autocmd FileType org inoremap <silent> <Bar>   <Bar><Esc>:AlignTable<CR>a
augroup END

augroup markdown_mode
    autocmd!
    autocmd FileType markdown :set makeprg=slideshow\ build\ %>/dev/null
augroup END

augroup go_mode
    autocmd!
    autocmd BufRead,BufNewFile *.go set filetype=go
    autocmd BufRead,BufNewFile *.go set makeprg=go\ build
augroup END


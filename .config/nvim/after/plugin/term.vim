" A terminal toggler like tman.nvim
let g:last_term = { 'name': '', 'is_open': 0 }
function! Term(name) 
    let g:last_term.name = a:name
    let hasTerm = bufexists(a:name)
    if hasTerm
        split
        wincmd J
        execute(':b ' . a:name)
        return 
    endif
    if has('nvim')
        wincmd s
    endif
    term
    wincmd J
    execute(':file ' . a:name)
endfunction

function! TermToggle() 
    if g:last_term.name == ''
        call Term('term')
        return
    endif
    let has_buf_window = bufwinid(g:last_term.name)
    if has_buf_window == -1
        call Term(g:last_term.name)
        normal! i
    else
        call win_gotoid(has_buf_window)
        wincmd c
    endif
endfunction
command! Term call Term("term")
command! TermRun call Term("term:run")
command! TermGit call Term("term:get")
command! TermToggle call TermToggle() 

nnoremap <C-\> :TermToggle<CR>
nnoremap <M-a> :TermToggle<CR>
nnoremap <A-a> :TermToggle<CR>
nnoremap <T-a> :TermToggle<CR>
tnoremap <C-\> <C-\><C-n>:TermToggle<CR>
tnoremap <M-a> <C-\><C-n>:TermToggle<CR>
tnoremap <A-a> <C-\><C-n>:TermToggle<CR>
tnoremap <T-a> <C-\><C-n>:TermToggle<CR>

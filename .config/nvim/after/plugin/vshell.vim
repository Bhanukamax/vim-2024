let s:vshell_buf = -1

function! VshellRunLine()
    " normal! o<Esc>dG
    normal!  "o<ESC>:r !" . getline(".") . "<CR>"
endfunction

function! VshellRemaps()
    nnoremap <buffer>q :q<CR>
    nnoremap <buffer><expr><CR> "o<ESC>:r !" . getline(".") . "<CR>"
    " nnoremap <buffer><CR> :call VshellRunLine()<CR>
endfunction

function! Vshell()
    new vshell
    call VshellRemaps()
    set hidden
    set filetype=vshell
    set buftype=nofile
    let buf_info = getbufinfo(0)
    let buf = buf_info[0]
    " echo buf
    let s:vshell_buf = buf['bufnr']
    " echo s:vshell_buf
endfunction

command! VV call Vshell()



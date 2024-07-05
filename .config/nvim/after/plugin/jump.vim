function! ReadBufferToArgs()
  let buffer_lines = getline(1, '$')
  let escaped_lines = map(buffer_lines, 'fnameescape(v:val)')
  let arg_string = join(escaped_lines, ' ')
  execute 'args ' . arg_string
  call ListArgs()
endfunction

function! ListArgs() 
    e jump
    argdedupe
    normal ggdG
    set noreadonly
    let s:i = 1
    for x in argv()
        call setline(s:i, x)
        let s:i = s:i + 1
    endfor
    set buftype=nofile
    set hidden
    nnoremap <buffer> q :bp<CR>
    nnoremap <buffer> 1 :bd<CR>:argu1<CR>
    nnoremap <buffer> 2 :bd<CR>:argu2<CR>
    nnoremap <buffer> 3 :bd<CR>:argu3<CR>
    nnoremap <buffer> 4 :bd<CR>:argu4<CR>
    nnoremap <buffer> <leader>u :call ReadBufferToArgs()<CR>
endfunction


nnoremap <leader>j1 :argu1<CR>
nnoremap <leader>j2 :argu2<CR>
nnoremap <leader>j3 :argu3<CR>
nnoremap <leader>j4 :argu4<CR>
nnoremap <leader>1 :argu1<CR>
nnoremap <leader>2 :argu2<CR>
nnoremap <leader>3 :argu3<CR>
nnoremap <leader>4 :argu4<CR>
nnoremap <leader>jj :call ListArgs()<CR>
nnoremap <leader>ja :argadd<CR>
nnoremap <leader>jd :argdel<CR>
nnoremap <leader>a :e#<CR>
command! ArgList :call ListArgs()<CR>

nnoremap <expr> <leader>ff '/'.getcharstr().'<cr><cmd>nohl<cr>'

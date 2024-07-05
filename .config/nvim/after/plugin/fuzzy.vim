function! BmaxFuzzy()
  let fuzz = '/**/*'
    if &filetype == ""
        return ":e ." . fuzz
    endif
  let buf_info = getbufinfo(0)
  if buf_info == []
    return ':e ' .. g:file_search_path
  endif
  if &filetype == 'netrw'
    let buf = buf_info[0]
    let local_path = fnamemodify(substitute(buf['name'], getcwd(), '', ''), ':h')
    let root_dir = fnameescape(buf['name'])
    let root_dir = '.' .. fnameescape(local_path)
  else
    let root_dir = fnameescape(expand("%:h"))
  endif
  let path = root_dir .. fuzz
  if path == fuzz
    let path = '.' .. path
  endif
  let sanitized_path = substitute(path, '\.\.\/', './', '')
  let sanitized_path = substitute(sanitized_path, '\/\/', '/', '')
  return ':e ' .. sanitized_path
endfunction
nnoremap <expr> <C-P> BmaxFuzzy()

nmap <expr> <leader>fL BmaxFuzzy()
nmap <expr> <leader>fl ":e " . g:file_search_path

function! BmaxF()
    return "**/*"
endfunction
cnoremap  <expr><M-f> BmaxF()

nnoremap <leader>ve :e ~/.config/nvim/**/*
nnoremap <leader>so :so %<CR>

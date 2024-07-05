
function! BmaxGrep()
  if &filetype == 'netrw'
    let buf = buf_info[0]
    let local_path = fnamemodify(substitute(buf['name'], getcwd(), '', ''), ':h')
    let root_dir = (buf['name'])
    let root_dir = '.' .. local_path
  else
    let root_dir = expand("%:h")
  endif
  return ':grep ' .. '"' .. root_dir .. '"'
endfunction

nnoremap <expr><leader>fa BmaxGrep()

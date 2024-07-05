augroup TSMappings
  autocmd!

  " Set a buffer-local mapping for the current buffer
  if g:use_coc == 1
      nmap <leader>ff :CocCommand eslint.executeAutofix<CR>
  endif
augroup END

source ~/.vim/ftplugin/tsjscommon.vim


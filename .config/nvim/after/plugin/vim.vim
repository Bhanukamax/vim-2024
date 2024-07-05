if has('nvim') != 1 
   set listchars="tab:> ,trail:-,nbsp:+"
   set mouse=a
endif

function! BmaxEslint()
 return ':!eslint_d --fix --cached "' . fnameescape(expand("%:p")) . '"'
  " return ':!eslint_d --fix --cached "' . expand("%:p") . '"'
endfunction

nnoremap <silent><leader>e :silent! !npx eslint --fix --cache "%:p"<CR>

" nnoremap <expr><leader>e BmaxEslint()

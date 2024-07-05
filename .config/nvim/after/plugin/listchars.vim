"set listchars&
augroup MyHi
    autocmd!
    autocmd BufEnter * match Whitespace /	/
    set listchars=tab:>-
augroup END

if has('nvim')
    set listchars+=leadmultispace:\ \ \ │
else
    set listchars=tab:>-
    hi Whitespace ctermfg=Black guifg=Black
endif



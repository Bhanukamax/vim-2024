"colorscheme torte
"colorscheme tokyonight-night

" if has('nvim')
"     colorscheme tokyonight-night
" else
"     colorscheme koehler
" endif
" colorscheme retrobox
colorscheme sorbet
" set bg=dark

    "CurSearch      xxx links to IncSearch
"
"IncSearch      xxx guifg=#15161e guibg=#fffe64

function! ChooseColorScheme()
    set wildignore=
    let c = input("Choose theme: ", "", "color")
    execute "colorscheme " .. c
    set wildignore=**/*/node_modules/*,**/*/plugged/*
endfunction

command! CC call ChooseColorScheme()

function! FixColors()
    hi! link EndOfBuffer Normal
    hi! link NonText Normal
hi  IncSearch  guifg=#15161e guibg=#fffe64
endfunction

augroup AG_FixColors
    autocmd!
    autocmd ColorScheme * :call FixColors()
    autocmd VimEnter * :call FixColors()
augroup END

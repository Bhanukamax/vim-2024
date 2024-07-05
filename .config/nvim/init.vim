syntax on
let g:use_coc = 1
let g:file_search_path = "./**/*"
let g:is_vim = 0
let g:use_spell_plugin = 0

call plug#begin()
Plug 'tpope/vim-abolish' " Tpop stuff
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-test/vim-test'
if g:use_spell_plugin == 1
    Plug 'kamykn/spelunker.vim'
endif
" Plug 'rafi/awesome-vim-colorschemes' "theme all of them
Plug 'lilydjwg/colorizer'
Plug 'machakann/vim-highlightedyank'
" Plug 'osyo-manga/vim-over' " nvim's inccommand like command line for vim
if has('nvim')
    " Plug 'folke/tokyonight.nvim' " theme
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Tree sitter
    " For vim treesitter support look into following two repos
    " https://github.com/JasonWoof/vim-treesitter
    " https://github.com/mattn/vim-treesitter
    Plug 'APZelos/blamer.nvim'
    Plug 'Bhanukamax/tman.nvim' " terminal manager
    Plug 'nvim-lua/plenary.nvim' " Maybe not required anymore since I ditched Harpoon
else
    Plug 'Eliot00/git-lens.vim'
endif
if has('nvim')
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " I write Typescript BTW
endif
if has('nvim') || v:version >= 900
endif
call plug#end()

" completion stuff
" set completeopt+=menuone
" set completeopt+=noselect
" set shortmess+=c   " Shut off completion messages
" set belloff+=ctrlg " Add only if Vim beeps during completion

" spellings
"https://google.com
if g:use_spell_plugin == 1
    highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#9e9e9e
    highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE
else
    set spell
    set spelloptions=camel
    set spellcapcheck=
endif

let g:netrw_altfile=1
let mapleader = ' '

" yank highlightedyank
let g:highlightedyank_highlight_duration = 100

"Vim Test
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>

" vim-over
nnoremap <leader>: :OverCommandLine<CR>:
nnoremap <leader>/ :OverCommandLine<CR>/


" count loc
nnoremap <leader>cl :!cloc --exclude-dir autoload ~/.config/nvim/<CR>

" neovim with init.vim
" Options
set exrc
set nowrap
filetype plugin on
set omnifunc=syntaxcomplete#Complete

set wildmenu
set splitbelow
set splitright
set nu
"set rnu " relative line numbers
set scrolloff=5
" case
set ignorecase
set smartcase
set tabstop=4
" does not play well with tree-sitter indent
"set smarttab
"set smartindent
set breakindent
set undofile
set list
set signcolumn=yes
if has('nvim')
    set inccommand=split
endif

set noswapfile

" need to set in vim9
" things that are set default by nvim
set wildoptions=pum,tagfile
set backspace=indent,eol,start
set incsearch
set hidden

" Remove if tree sitter fails
set expandtab
set tabstop=4
set shiftwidth=4

" folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
set foldcolumn=1
set foldenable


inoremap <C-c> <ESC>
" colorscheme industry
"colorscheme vim
set undodir="~/.undodir"
set wildignore=**/*/node_modules/*,**/*/plugged/*
" tabs
nnoremap <leader>to :tabe<CR>
nnoremap <M-,> :tabp<CR>
nnoremap <M-.> :tabn<CR>
nnoremap <leader>, :tabp<CR>
nnoremap <leader>. :tabn<CR>

" quickfix list
nnoremap <leader>cc :copen<CR>
nnoremap <leader>co :cclose<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>

" set guicursor = 'n-v-c:block,o:hor50,i-ci:hor1,r-cr:hor30,sm:block'
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50

" clipboard
vnoremap <leader>y "+y

" Find
set path=.,**,/usr/include/,

let g:file_search_path = "./**/*"
" files
"nmap <leader>fl :execute 'edit ' . input('File: ', g:file_search_path, 'file')<CR>
" Does what I orignially wanted, this time using expression register, way
" btter than input()

"nmap <leader>fl :e <C-r>=g:file_search_path<CR>
"nmap <leader>fL :e <C-r>=fnameescape(expand("%:h"))<CR>
nnoremap <C-p> :execute 'edit ' . input('File: ', g:file_search_path, 'file')<CR>

fun! MyEx()
    let s:file_name = expand("%:t")
    :Ex
    :call search(s:file_name)
endfun

nmap - :call MyEx()<CR>

" Spellings
" highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#9e9e9e
" highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE

" Copilot
let g:copilot_filetypes = {
            \ '*': v:false,
            \ 'typescript': v:true,
            \ 'typescriptreact': v:true,
            \ }


"augroup SetupOptions
"    autocmd!
"    autocmd BufEnter, BufRead *.tsx, *.ts 
"
"augroup END
" COC
" Add the following line to the .exrc in the project root if coc is required
" call SetupCocAugroups() 

function! SetupCocAugroups()
    if g:use_coc == 0
        return 
    endif
    " Create an autocmd group
    augroup CocKeybindings
        autocmd!

        " Autocmd for when coc.nvim is enabled in a buffer
        autocmd FileType * if g:use_coc == 1 | call s:setup_coc_keybindings() | endif
    augroup END
endfunction

command! CocSetupKeybinds call SetupCocAugroups()

function! s:setup_coc_keybindings()
    if g:use_coc == 0
        return
    endif
    "nnoremap <leader>j :call CocAction('jumpDefinition')<cr>
    nmap <leader>rn <Plug>(coc-rename) 
    nmap <silent> <Esc> <Plug>(coc-range-select)
    xmap <silent> <Esc> <Plug>(coc-range-select)
    nnoremap <buffer> <silent> gd <Plug>(coc-definition)
    nnoremap <buffer> <silent> gr <Plug>(coc-references)
    nnoremap <buffer> <silent> gi <Plug>(coc-implementation)
    nnoremap <buffer> <silent> gy <Plug>(coc-type-definition)
    nnoremap <buffer> <silent> K :call CocAction('doHover')<CR>
    nnoremap <leader>io :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
    nnoremap <leader>xx :CocList diagnostics<CR>
    "nnoremap <leader>ff :CocCommand eslint.executeAutofix<CR>
    nnoremap <leader>ff :call CocAction('runCommand', 'editor.action.organizeImport')<CR>:CocCommand eslint.executeAutofix<CR>
endfunction

" clipboard
:nnoremap <leader>p "+p
:nnoremap <leader>P O<ESC>"+pa<ESC>
:vnoremap <leader>y "+y
:nnoremap <leader>y "+y

" Git
let g:blamer_enabled = 1
let g:blamer_delay = 100
let g:fugitive_status_vertical = "newtab"
nmap <leader>gf :diffget //2<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gg :tab Git<CR>
nmap <leader>gl :tab Git log --oneline<CR>
nmap <leader>gc :Gwrite<CR>
nmap <leader>gp :Dispatch! git push -u

" Grep
" set grepprg=ag\ --vimgrep\ -S\ --ignore\ *syntax*\ --ignore\ *plugged*\ --ignore\ *autoload*\ --ignore\ systags
set grepprg=ag\ --vimgrep

nmap <leader>fi :silent! grep<space>
nmap <leader>mm Make<space>
nmap <leader>gw :grep<space><C-r><C-w> --ignore tags --ignore TAGS --ignore ./node_modules<CR>
nmap <leader>gi :grep<space>
nnoremap <C-c><C-]> :exe "ptjump " . expand("<cword>")<Esc>


" build
let g:build_cmd = "Make"
nmap <leader>bb :<C-r>=g:build_cmd<CR><CR>
set makeprg=sh\ build_bmax.sh

function! ListArgList()
    redir => l:output
    silent! args
    redir END
    echo output
    sp
    new
    call setline(1, split(l:output))
    normal! ggdd
endfunction

" Just to remove tmux
let g:dispatch_handlers = [
            \ 'job',
            \ 'screen',
            \ 'terminal',
            \ 'windows',
            \ 'x11',
            \ 'headless',
            \ ]

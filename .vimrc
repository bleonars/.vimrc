" begin install plugins
call plug#begin('~/.vim/plugged/')

" install colorschemes
" Plug 'ajmwagar/vim-deus'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

" install completion
" Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" install pair complete
Plug 'jiangmiao/auto-pairs'

" install c/c++ highlights
Plug 'bfrg/vim-cpp-modern'
" Plug 'jackguo380/vim-lsp-cxx-highlight'

" install vim start page
Plug 'mhinz/vim-startify'

" install comment plugin
Plug 'preservim/nerdcommenter'

" install indent line marker plugin
Plug 'Yggdroot/indentLine'

" install nerdtree
Plug 'preservim/nerdtree'

" end installing plugins
call plug#end()

" set status bar
set laststatus=2
let g:lightline = {
            \ 'colorscheme': 'solarized',
            \ }

" set colorscheme
" colors deus
let g:gruvbox_contrast_light='hard'
syntax enable
colorscheme gruvbox
set background=light
set cursorline

" disable vi compatability
set nocompatible

" hidden buffers
set hidden

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" disable backups
set nobackup
set nowritebackup

" set C indentation
set autoindent
set smartindent
" set cindent
set cinoptions+=g0
set cinoptions+=:0

" set tabs
set smarttab
"set tabstop=8
"set shiftwidth=8
"set noexpandtab
set tabstop=4
set shiftwidth=4
set expandtab 

" set line wrap
set textwidth=120 "80

" turn on syntax highlight
set t_Co=256
set term=xterm-256color
syntax on

" disable search highlight
set nohlsearch

" disable bell
set noerrorbells

" set incremental search, ignore case
set smartcase
set ignorecase
set incsearch

" turn on line numbers
set number
set ruler

" turn on brace highlights
set showmatch

" show current command
set showcmd

" let more room for display messages
set cmdheight=1

" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" set backspace behavior
set backspace=indent,eol,start

" fix lag
set timeoutlen=1000 " timeout
set ttimeoutlen=50 " terminal time out
set updatetime=1000 " how often swap file is written to disk

" don't pass messages to |ins-completion-menu|
set shortmess+=c

" enable filetype plugin
filetype plugin indent on

" disable comment insertion after enter
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" escape remap
:imap jj <Esc>

" nerd tree mappings
map <F1> :NERDTreeToggle<CR>
map <F2> :NERDTreeFocus<CR>
map <F3> :terminal<CR>

" coc-nvim mappings
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add ff as format mapping 
noremap <silent> <leader>ff :<C-U>Format<CR>
" inoremap <silent> ff <C-O>:Format<CR>

" Run python command
autocmd Filetype python nnoremap <buffer> <F5> :w<CR>:vert terminal python3 "%"<CR>

execute pathogen#infect()

if !has('gui_running')
  set t_Co=256
endif

set laststatus=2

" Colorscheme
colorscheme gruvbox

" FuzzyFinder integration
set rtp+=~/.fzf


" Set split settings to open horizontal splits below and vertical splits on
" the right
set splitbelow splitright

nmap <C-f> :w<CR>:FZF<CR>
nmap <C-b> :w<CR>:b<Space>

" Basic settings
syntax on
set ruler
set autoindent
set relativenumber
set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
filetype plugin indent on
set incsearch
set ignorecase
set smartcase
set gdefault
set wildmenu

" Activate rainbow parentheses
let g:rainbow_active = 1

nnoremap <C-k> <C-w>

nmap <Space>g gg=G

" Easier saving when in normal mode
nmap <Space>w :wall<CR>
nmap <Space>x :xall<CR>

autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType java nmap <F4> <Plug>(JavaComplete-Imports-Add)
autocmd FileType java nmap <F5> <Plug>(JavaComplete-Imports-RemoveUnused)

autocmd FileType tex nmap <F2> :w<CR>:!pdflatex<Space><C-r>%<CR><CR>
autocmd FileType tex nmap <F3> :!bibtex<Space><C-r>%<BS><BS><BS><BS><CR><CR>
autocmd FileType tex nmap <F4> <F2><F3><F2><F2>
autocmd FileType tex nmap <Space><Space> /<+><CR>ca>
autocmd FileType tex imap ;b \textbf{}<Esc>i

autocmd FileType json nnoremap <F2> :%!python -m json.tool<CR>

let g:ale_fixers = {
            \    '*': ['remove_trailing_lines', 'trim_whitespace'],
            \    'python': ['black', 'isort'],
            \    'rust': ['rustfmt'],
            \}

let g:ale_linters = {
            \    'python': ['pylint'],
            \}

let g:ale_fix_on_save = 1

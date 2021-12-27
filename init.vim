if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-surround'

Plug 'tpope/vim-repeat'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-fugitive'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'

Plug 'airblade/vim-gitgutter'

Plug 'airblade/vim-rooter'

Plug 'itchyny/lightline.vim'

Plug 'ervandew/supertab'

Plug 'phaazon/hop.nvim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'sheerun/vim-polyglot'

call plug#end()

set termguicolors
set bg=dark
color alduin

set guicursor=a:block-blinkon0
set guicursor+=i-r:hor20
set nohlsearch incsearch
set splitbelow splitright
set nowrap
set et sw=4 si ts=4
set hidden

let mapleader = " "

imap kj <Esc>
vmap kj <Esc>

" Move highlight code block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap n nzz

" File related configs
nmap <leader>q :q<CR>
nmap <leader>w :w<CR>
nmap <leader>x :x<CR>
nmap <leader>e :Files<CR>
nmap <leader>r :e<Space>
nmap <leader>f :Rg<CR>
nmap <C-s> <C-w>s
nmap <leader>b :Buffers<CR>

" Hop configs
lua require'hop'.setup { create_hl_autocmd = false }

hi HopNextKey guifg=#F27F38
hi HopNextKey1 guifg=#F27F38
hi HopNextKey2 guifg=#F27F38
hi HopUnmatched guifg=#666666

nmap <silent> W :HopWord<CR>
nmap <silent><leader>s :HopChar2<CR>

" COC configs
nmap gd <Plug>(coc-definition)
nmap gr <Plug>(coc-references)

" Supertab configs
let g:SuperTabNoCompleteAfter = ['^', '\s', '\\', '\*']

" Lighline configs
let g:lightline = {
	    \ 'active': {
	    \   'left': [ [ 'mode', 'paste' ],
	    \             [ 'readonly', 'filename', 'modified', 'gitbranch' ] ]
	    \ },
        \ 'colorscheme': 'PaperColor',
	    \ 'component_function': {
	    \   'gitbranch': 'fugitive#head'
	    \ },
	    \ }

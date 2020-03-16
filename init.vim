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

call plug#end()

color delek

set bg=dark
set relativenumber
set guicursor=a:block
set nonumber
set nohlsearch incsearch
set splitbelow splitright
set nowrap
set et sw=4 si ts=4
set hidden

let mapleader = " "

nmap <leader>q :q<CR>
nmap <leader>w :w<CR>
nmap <leader>x :x<CR>
nmap <leader>g mqgg=G`qzz

nmap <leader>e :Files<CR>
nmap <leader>r :e<Space>
nmap <leader>f :Rg<CR>
nnoremap <silent> <leader>s :call fzf#run({
	    \   'down': '40%',
	    \   'sink': 'botright split' })<CR>
nmap <C-s> <C-w>s

nmap <leader>b :Buffers<CR>
nmap <C-n> :bnext<CR>
nmap <C-p> :bprevious<CR>

nmap <leader>p :Gstatus<CR>
nmap <leader>d :Gdiff<CR>

nmap <leader>c :w !xclip -i -sel c<CR><CR>

nmap <silent> <leader><leader> <C-z>

nnoremap n nzz

let g:SuperTabNoCompleteAfter = ['^', '\s', '\\', '\*']

let g:lightline = {
	    \ 'active': {
	    \   'left': [ [ 'mode', 'paste' ],
	    \             [ 'readonly', 'filename', 'modified', 'gitbranch' ] ]
	    \ },
	    \ 'component_function': {
	    \   'gitbranch': 'fugitive#head'
	    \ },
            \ 'colorscheme': 'srcery_drk',
	    \ }

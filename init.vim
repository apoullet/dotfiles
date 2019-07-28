color srcery
set bg=light

set relativenumber number
syntax on
set shiftwidth=4
set incsearch
set nowrap
set guicursor=i-ci-r-cr-o:hor20
set splitbelow splitright
au FileType tex set spell
au FileType tex set spelllang=en
au FileType tex set spellfile=$HOME/.config/nvim/spell/en.utf-8.add
au FileType tex hi clear SpellBad
au FileType tex hi SpellBad ctermfg=009 ctermbg=011

let mapleader = " "

nmap <leader>q :q<CR>
nmap <leader>w :w<CR>
nmap <leader>x :x<CR>
nmap <leader>e :Files<CR>
nmap <leader>f :Rg<CR>
nnoremap <silent> <leader>p :call fzf#run({
\   'down': '40%',
\   'sink': 'botright split' })<CR>
nmap <leader>b :Buffers<CR> 
nmap <leader>s :Gstatus<CR>
nmap <leader>d :Gdiff<CR>
nmap <leader><leader> :bp<CR>

nmap <C-h> :vertical res -5<CR>
nmap <C-l> :vertical res +5<CR>
nmap <C-j> :res -5<CR>
nmap <C-k> :res +5<CR>

nnoremap <F2> :w<CR>:!pdflatex report.tex<CR>:!bibtex report<CR>:!pdflatex report.tex<CR>:!pdflatex report.tex<CR>
nnoremap n nzz

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

Plug 'luochen1990/rainbow'

Plug 'scrooloose/nerdtree'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'

Plug 'w0rp/ale'

Plug 'airblade/vim-gitgutter'

Plug 'airblade/vim-rooter'

call plug#end()

let g:rainbow_active = 1

nmap <C-n> :NERDTreeToggle %<CR>

let g:ale_fix_on_save = 1

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'rust': ['rustfmt'],
\}

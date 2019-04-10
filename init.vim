colorscheme zellner

set relativenumber number
syntax on
set shiftwidth=4
set incsearch
set guicursor=i-ci-r-cr-o:hor20
set splitbelow splitright
au FileType tex set spell
au FileType tex set spelllang=en
au FileType tex set spellfile=$HOME/.config/nvim/spell/en.utf-8.add
au FileType tex hi clear SpellBad
au FileType tex hi SpellBad ctermfg=009 ctermbg=011

nmap <Space>w :w<CR>
nmap <Space>x :x<CR>
nmap <C-H> :vertical res -5<CR>
nmap <C-L> :vertical res +5<CR>

nnoremap <F2> :w<CR>:!pdflatex report.tex<CR>:!bibtex report<CR>:!pdflatex report.tex<CR>:!pdflatex report.tex<CR>

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-surround'

Plug 'tpope/vim-repeat'

Plug 'tpope/vim-commentary'

Plug 'luochen1990/rainbow'

Plug 'scrooloose/nerdtree'

call plug#end()

let g:rainbow_active = 1

nmap <C-n> :NERDTreeToggle %<CR>

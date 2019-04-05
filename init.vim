colorscheme srcery

set relativenumber number
syntax on
set shiftwidth=4
set incsearch
" set spell
" set spelllang=en
" set spellfile=$HOME/.config/nvim/spell/en.utf-8.add
" hi clear SpellBad
" hi SpellBad ctermfg=009 ctermbg=011

nmap <Space>w :w<CR>
nmap <Space>x :x<CR>

" nnoremap <F2> :w<CR>:!pdflatex report.tex<CR>:!bibtex report<CR>:!pdflatex report.tex<CR>:!pdflatex report.tex<CR>

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

call plug#end()

let g:rainbow_active = 1

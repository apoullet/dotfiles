let g:srcery_transparent_background = 1

color srcery

set relativenumber
syntax on
set shiftwidth=4
set incsearch
set nowrap
set guicursor=i-ci-r-cr-o:hor20
set splitbelow splitright
set expandtab
au FileType tex set spell
au FileType tex set spelllang=en
au FileType tex set spellfile=$HOME/.config/nvim/spell/en.utf-8.add
au FileType tex hi clear SpellBad
au FileType tex hi SpellBad ctermfg=009 ctermbg=011

let mapleader = " "

let s:toggle_buffer = 0

function! ToggleBuffer()
    execute 'w'

    if s:toggle_buffer == 0
	let s:toggle_buffer = 1
	execute 'bp'
    else
	let s:toggle_buffer = 0
	execute 'bn'
    endif
endfunction

function! FilesWrapper()
    execute 'w'
    let s:toggle_buffer = 0
    execute 'Files'
endfunction

function! BuffersWrapper()
    execute 'w'
    let s:toggle_buffer = 0
    execute 'Buffers'
endfunction

function! EditWrapper(file)
    execute 'w'
    let s:toggle_buffer = 0
    execute 'e ' . a:file
endfunction

command -nargs=* -complete=file E call EditWrapper(<f-args>)

nmap <leader>q :q<CR>
nmap <leader>w :w<CR>
nmap <leader>x :x<CR>
nmap <leader>e :call FilesWrapper()<CR>
nmap <leader>r :E
nmap <leader>f :Rg<CR>
nnoremap <silent> <leader>p :call fzf#run({
	    \   'down': '40%',
	    \   'sink': 'botright split' })<CR>
nmap <leader>b :call BuffersWrapper()<CR>
nmap <leader>s :Gstatus<CR>
nmap <leader>d :Gdiff<CR>
nmap <leader><leader> :call ToggleBuffer()<CR>
nmap Y "*y

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

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'

Plug 'w0rp/ale'

Plug 'airblade/vim-gitgutter'

Plug 'airblade/vim-rooter'

Plug 'itchyny/lightline.vim'

Plug 'ervandew/supertab'

Plug 'sheerun/vim-polyglot'

call plug#end()

let g:rainbow_active = 1

let g:SuperTabNoCompleteAfter = ['^', '\s', '\\']

let g:ale_fix_on_save = 1

let g:ale_fixers = {
	    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
	    \   'rust': ['rustfmt'],
	    \	'python': ['autopep8']
	    \}

let g:lightline = {
	    \ 'active': {
	    \   'left': [ [ 'mode', 'paste' ],
	    \             [ 'readonly', 'filename', 'modified', 'gitbranch' ] ]
	    \ },
	    \ 'component_function': {
	    \   'gitbranch': 'fugitive#head'
	    \ },
            \ 'colorscheme': 'landscape',
	    \ }

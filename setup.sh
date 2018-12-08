#!/usr/bin/bash

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \
    git clone https://github.com/w0rp/ale.git .vim/bundle/ale && \
    git clone https://github.com/luochen1990/rainbow.git .vim/bundle/rainbow && \
    git clone https://github.com/ervandew/supertab.git .vim/bundle/supertab && \
    git clone https://github.com/tpope/vim-commentary.git .vim/bundle/vim-commentary && \
    git clone https://github.com/tpope/vim-repeat.git .vim/bundle/vim-repeat && \
    git clone https://github.com/tpope/vim-surround.git .vim/bundle/vim-surround && \
    git clone https://github.com/sheerun/vim-polyglot.git .vim/bundle/vim-polyglot

export ZSH="$HOME/.oh-my-zsh"

# -- [[ THEME ]]
fpath+=($HOME/.zsh/pure)

ZSH_THEME=""
autoload -U promptinit; promptinit

PURE_PROMPT_SYMBOL=";"
PURE_PROMPT_VICMD_SYMBOL=";"

zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:git:branch color magenta
zstyle :prompt:pure:git:arrow color blue
zstyle :prompt:pure:git:stash color blue
zstyle :prompt:pure:prompt:success color green

prompt pure

# -- [[ PLUGINS ]]
plugins=(zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# -- [[ ALIASES ]]
alias zrc="nvim $HOME/.zshrc"
alias szrc="source $HOME/.zshrc"

alias nrc="nvim $HOME/.config/nvim/init.lua"

alias krc="nvim $HOME/.config/kitty/custom.conf"

# -- [[ MISC ]]
[ -f "/home/apoullet/.ghcup/env" ] && source "/home/apoullet/.ghcup/env" # ghcup-env

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export VIRTUAL_ENV_DISABLE_PROMPT=1 # Stop virtualenv randomly inserting stuff in my prompt

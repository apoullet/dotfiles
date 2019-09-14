ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

get_info() {
    if [[ -v IN_NIX_SHELL ]]; then
      color=208
    else
      color=82
    fi
    
    echo "%F{$color}%n%F{226}@%F{$color}%M %F{75}%1~%{$reset_color%}$(git_prompt_info) | %F{white}%D{%f/%m/%y} %D{%L:%M}%{$reset_color%}"
}

PROMPT=$'\n%{$(get_info)%}\n%(?.%F{200}.%F{red})λ%f '

if type "virtualenv_prompt_info" > /dev/null
then
	RPROMPT='%F{200}$(virtualenv_prompt_info)%f %F{200}${SSH_TTY:+%n@%m}%f'
else
	RPROMPT='%F{200}${SSH_TTY:+%n@%m}%f'
fi

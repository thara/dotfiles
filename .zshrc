## Environment variable configuration
export LANG=ja_JP.UTF-8

## Default shell configuration
PROMPT='%F{white}[%n@%m]# '
RPROMPT="[%~]"
SPROMPT="%B%{^[[31m%}%r is correct? [n,y,a,e]:%{^[[m%}%b "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{^[[37m%}${HOST%%.*} ${PROMPT}"

autoload -U compinit
compinit

## Command History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
# historical backward/forward search with linehead string
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

## Key bind configuration
bindkey -e
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

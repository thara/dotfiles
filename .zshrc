## Environment variable configuration
export LANG=ja_JP.UTF-8

## Default shell configuration
PROMPT='%F{white}[%n@%m]# '
RPROMPT="[%~]"
SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{^[[37m%}${HOST%%.*} ${PROMPT}"

## Completion configuration
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

# auto chnage directory
setopt auto_cd
# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd
# command correct edition before each completion attempt
setopt correct
# no remove postfix slash of command line
setopt noautoremoveslash
# no beep sound when complete list displayed
setopt nolistbeep

## Command aliases
alias ls='ls -G'
alias la='ls -a'
alias ll='ls -l'
alias lsa='ls -la'

alias du="du -h"
alias df="df -h"

[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

export LSCOLORS=exfxcxdxbxegedabagacad
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

export LSCOLORS=ExFxCxdxBxegedabagacad
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

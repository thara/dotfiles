## Environment variable configuration
export LANG=ja_JP.UTF-8

## Default shell configuration
#
autoload colors
colors

## Completion configuration
autoload -U compinit
compinit

## Command History configuration
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
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
# ls after cd
function chpwd() { ls -G }
# cd search path
cdpath=(~ ..)
# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd
# command correct edition before each completion attempt
setopt correct
# no remove postfix slash of command line
setopt noautoremoveslash
# no beep sound when complete list displayed
setopt nolistbeep

## Command aliases
setopt complete_aliases
alias ls='ls -GF'
alias la='ls -aF'
alias ll='ls -lF'
alias lsa='ls -laF'

alias du="du -h"
alias df="df -h"

alias gr="grep --color=auto -EDUIn"

alias g="git"
alias gi="git"
alias gs="git status -s -b"
alias gst="git status -s -b"
alias gc="git commit"
alias gca="git commit -a"
alias gcls="git config --list | grep alias"

# fabric
alias fab='nocorrect fab'
# tmux
alias tmux='nocorrect tmux'

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

export LSCOLORS=ExFxCxdxBxegedabagacad
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

# Auto execution from file extension
alias -s zip=zipinfo
alias -s tgz=gzcat
alias -s gz=gzcat
alias -s tbz=bzcat
alias -s bz2=bzcat
alias -s java=vim
alias -s c=vim
alias -s h=vim
alias -s C=vim
alias -s cpp=vim
alias -s txt=vim
alias -s xml=vim
alias -s html=vim
alias -s xhtml=vim

# Direcotry Bookmarks
alias m1='alias g1="cd `pwd`"'
alias m2='alias g2="cd `pwd`"'
alias m3='alias g3="cd `pwd`"'
alias m4='alias g4="cd `pwd`"'
alias m5='alias g5="cd `pwd`"'
alias m6='alias g6="cd `pwd`"'
alias m7='alias g7="cd `pwd`"'
alias m8='alias g8="cd `pwd`"'
alias m9='alias g9="cd `pwd`"'
alias mdump='alias | grep -e "g[0-9]=" | grep -v "m[0-9]" | sed "s/^g/alias g/g" > ~/.zsh_bookmarks'
alias mls='alias | grep -e "g[0-9]=" | grep -v "m[0-9]" | sed "s/^g/alias g/g"'
touch ~/.zsh_bookmarks
source ~/.zsh_bookmarks


## Environment variable configuration
export LANG=ja_JP.UTF-8

## Default shell configuration
PROMPT='%F{white}[%n@%m]# '
RPROMPT="[%~]"
SPROMPT="%B%{^[[31m%}%r is correct? [n,y,a,e]:%{^[[m%}%b "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{^[[37m%}${HOST%%.*} ${PROMPT}"

autoload -U compinit
compinit

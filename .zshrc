#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

## Command History configuration
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt nonomatch
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history

# auto chnage directory
setopt auto_cd
# ls after cd
function chpwd() { ls -GF }
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
# Do not exit on end-of-file by Ctrl-d
setopt ignore_eof
# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line

disable r

# zaw.zsh 
#
# from http://yagays.github.io/blog/2013/05/20/zaw-zsh/
# autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
# add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# source ~/zaw/zaw.zsh
zstyle ':filter-select' case-sensitive yes
# bindkey '^@' zaw-cdr

[ -f ~/.zshrc.func ] && source ~/.zshrc.func

if [ -n "$(get_os)" ]; then
  f="$HOME/.zshrc.$(get_os)"
  if [ -f "$f" ]; then
    source "$f"
  fi
fi

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

export RIPGREP_CONFIG_PATH=~/.ripgreprc
## bat
export BAT_THEME="Gray Matter Dark"

## Command aliases
setopt complete_aliases

alias tmux='nocorrect tmux'

if exists "bat"; then
  alias b='bat'
  export BAT_CONFIG_PATH="$HOME/.bat.conf"
fi

alias c='clear'
alias cl='vi $NOTES_DIR/changelog'

alias du="du -h"
alias df="df -h"

if exists "exa"; then
  alias exa='exa --time-style long-iso'
  alias e='exa -l'
  alias ea='exa -lag'
  alias es='exa -l --git --git-ignore'
  alias eg='exa -l --git'
  alias et='exa -lT'
fi

alias f='tmux capture-pane -S -1 -E 1000 -p | fpp'

alias g='git'

alias j='jobs'

alias ls='ls -GF'
alias la='ls -aF'
alias ll='ls -lF'
alias lsa='ls -laF'

# Copy last line on CLI
alias p='tmux capture-pane -S -1 -E 1000 -p | sed '/^$/d' | tail -n 2 | head -n 1 | pbcopy'

alias t="tmux"
alias td="todo.sh"

alias v='vim'
alias vi='vim'

# http://grml.org/zsh/zsh-lovers.html
alias -g ..2='../..'
alias -g ..3='../../..'
alias -g G='| egrep'
alias -g H='| head'
alias -g L='| less'
alias -g EG='|& egrep'
alias -g EH='|& head'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g ETL='|& tail -20'
alias -g ET='|& tail'

alias -g C='| pbcopy'
alias -g P='| pbcopy'
alias -g EP='|& pbcopy'

# Suffix alias
alias -s zip=zipinfo
alias -s {tgz,gz}=gzcat
alias -s {tbz,bz2}=bzcat
alias -s html=open

# ripgrep: Reduce the level of "smart" searching.
alias rgu="rg -u"
# ripgrep: to disable all smart filtering and make ripgrep behave a bit more like classical grep
alias rguu="rg -uu"

alias zshrc='vi ~/src/github.com/thara/dotfiles/.zshrc'
alias vimrc='vi ~/src/github.com/thara/dotfiles/.vimrc'
alias today='date +%Y-%m-%d'
alias now='date "+%Y-%m-%d %H:%M:%S"'

vimruntime=`vim -e -T dumb --cmd 'exe "set t_cm=\<C-M>"|echo $VIMRUNTIME|quit' | tr -d '\015' `
alias vless=$vimruntime/macros/less.sh

alias edit-cheatsheet="vim $HOME/Dropbox/Work/cheatsheet.md"
alias git-first-commit="git log --date-order --format=%cI | tail -1"
alias git-commiter-last-month="git shortlog --summary --since='1 month ago' | sort -r"

export EDITOR='vim'
export VISUAL='vim'
#[[ -s /Users/hara/.tmuxinator/scripts/tmuxinator ]] && source /Users/hara/.tmuxinator/scripts/tmuxinator
#
export GOPATH="$HOME"
export PATH="$PATH:$GOPATH/bin"

export RUST_BACKTRACE=1

for i in $HOME/etc/profile.d/*.sh ; do
    if [ -r "$i" ]; then
        if [ "${-#*i}" != "$-" ]; then
            source "$i"
        else
            source "$i" >/dev/null 2>&1
        fi
    fi
done

[ -f ~/.zshrc.tools ] && source ~/.zshrc.tools
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH="$HOME/.cargo/bin:$PATH"

export TERM=xterm-256color

## Key bindings

# historical backward/forward search with linehead string
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

bindkey '^ ' autosuggest-accept

autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word

# Emacs style
bindkey -M viins '^?'  backward-delete-char
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^D'  delete-char-or-list
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^F'  forward-char
bindkey -M viins '^G'  send-break
bindkey -M viins '^H'  backward-delete-char
bindkey -M viins '^K'  kill-line
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^Y'  yank

zstyle ':completion:*:default' menu select=1

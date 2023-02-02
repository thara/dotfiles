export PATH=$HOME/bin:/usr/local/bin:$PATH

# no limit
HISTSIZE=-1
HISTFILESIZE=-1

export CDPATH=".:..:~"

export EDITOR=vim
export VISUAL=vim

export TERM=xterm-256color

export RIPGREP_CONFIG_PATH=~/.ripgreprc

if command -v exa &> /dev/null; then
  alias exa='exa --time-style long-iso'
  # grid, all, sort by type
  alias ls='exa -G -a -s type'
  alias l='exa -G -a -s type'
  # table, all, sort by type, show group & git status
  alias ll='exa -l -a -s type -g --git'
  # tree
  alias lt='exa -T'
fi

if command -v bat &> /dev/null; then
  # show plain
  alias cat='bat -p -P'
  export BAT_CONFIG_PATH="$HOME/.bat.conf"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init bash)"
fi

if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
  export STARSHIP_CONFIG=~/.starship
fi

if command -v fzf &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden'
  export FZF_DEFAULT_OPTS='--border'
  export FZF_TMUX_HEIGHT="50%"
  export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
  export FZF_CTRL_T_COMMAND="rg --files --hidden --follow --glob '!.git/*'"
  export FZF_CTRL_T_OPTS="--preview 'bat  --color=always --style=header,grid --line-range :100 {}'"
  export FZF_ALT_C_COMMAND="fd -t d . | sort"
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
fi

[ -f ~/.bashrc.local ] && source ~/.bashrc.local

export GOPATH="$HOME"
export PATH="$PATH:$GOPATH/bin"

export RUST_BACKTRACE=1

for i in $HOME/etc/profile.d/*.sh ; do
  [ -r "$i" ] && source "$i"
done

function fzf-select-repos {
  local selected_dir=$(ghq list | fzf-tmux --query "$LBUFFER" --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$selected_dir" ]; then
    cd $(ghq root)/${selected_dir}
  fi
}

bind -m vi-command -x '"\C-o":fzf-select-repos'

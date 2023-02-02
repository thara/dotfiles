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

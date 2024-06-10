if command -v eza &> /dev/null; then
  alias eza='eza --time-style long-iso'
  # grid, all, sort by type
  alias ls='eza -G -a -s type'
  alias l='eza -G -a -s type'
  # table, all, sort by type, show group & git status
  alias ll='eza -l -a -s type -g --git'
  # tree
  alias lt='eza -T'
fi

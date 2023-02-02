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

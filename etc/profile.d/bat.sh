if command -v bat &> /dev/null; then
  # show plain
  alias cat='bat -p -P'
  export BAT_CONFIG_PATH="$HOME/.bat.conf"
fi

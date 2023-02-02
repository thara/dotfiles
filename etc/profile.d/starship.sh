if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
  export STARSHIP_CONFIG=~/.starship
fi

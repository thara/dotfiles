#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -ex

brew bundle --file="$DOTFILES_ROOT/macos/Brewfile"

if [ -n "${DOTFILES_INSTALL_APPS:-}" ]; then
  echo "Installing GUI apps via Brewfile_app"
  brew bundle --file="$DOTFILES_ROOT/macos/Brewfile_app"
fi

# ========================
# Set up
# ========================

. "$DOTFILES_ROOT/script/functions"

VIM_DIR=$DOTFILES_ROOT/.vim

mkdir -p "$VIM_DIR/autoload"

: "Install vim-plug" && {
  if ! [ -f "$VIM_DIR/autoload/plug.vim" ] ; then
    curl -fLo "$VIM_DIR/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    log_pass "vim: Install vim-plug"
  fi
}

: "Install tmux-plugins" && {
  if ! [ -d "$HOME/.tmux/plugins/tpm" ] ; then
    mkdir -p "$HOME/.tmux/plugins/"
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  fi
}

: "Install bat theme" && {
  if ! [ -d "$HOME/.config/bat/themes" ] ; then
    mkdir -p "$HOME/.config/bat/themes"
    git clone https://github.com/thara/gray-matter.git "$HOME/.config/bat/themes/" || :
  fi
}

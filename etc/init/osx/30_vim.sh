#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib/func

VIM_DIR=$DOTPATH/.vim

mkdir -p $VIM_DIR/autoload

: "Install vim-plug" && {
  if ! [ -f "$VIM_DIR/autoload/plug.vim" ] ; then
    curl -fLo $VIM_DIR/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    log_pass "vim: Install vim-plug"
  fi
}

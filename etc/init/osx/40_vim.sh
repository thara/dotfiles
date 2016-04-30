#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib/func

VIM_DIR=$DOTPATH/.vim

mkdir -p $VIM_DIR

: "Install Dein.vim" && {
  if ! [ -d "$VIM_DIR/dein" ] ; then
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
    sh ./installer.sh $VIM_DIR/dein
    rm ./installer.sh
  fi
}

#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib/func

VIM_DIR=$DOTPATH/.vim

mkdir -p $VIM_DIR

: "Install Dein.vim" && {
  if ! [ -d "$VIM_DIR/dein" ] ; then
    # Use my fork because realpath command does not found
    curl https://raw.githubusercontent.com/tomochikahara/dein.vim/stop-using-realpath-in-installer/bin/installer.sh > installer.sh
    bash ./installer.sh $VIM_DIR/dein
    rm ./installer.sh
  fi
}

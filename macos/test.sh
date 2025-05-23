#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTFILES_ROOT/script/functions"

ERR=0
export ERR

test_homebrew() {
  if is_exists "brew"; then
    print_success "homebrew installed"
  else
    failure "$0: $LINENO: $FUNCNAME"
  fi
}

test_homebrew


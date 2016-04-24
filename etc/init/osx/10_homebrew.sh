#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib/func


: "Hombrew install" && {

  if has "brew"; then
    log_pass "Homebrew: already installed"
  else
    if ! has "ruby"; then
        log_fail "error: require: ruby"
        exit 1
    fi

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    if has "brew"; then
        brew doctor
    else
        log_fail "error: brew: failed to install"
        exit 1
    fi

    log_pass "brew: installed successfully"
  fi
}

: "Homebrew bundle" && {

  if ! brew tap Homebrew/bundle; then
      log_fail "error: failed to tap Homebrew/bundle"
      exit 1
  fi

  brew bundle -f "$DOTPATH"/Brewfile

  log_pass "brew: bundle successfully"
}

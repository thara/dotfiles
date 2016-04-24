#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib/func


: "Install mjolnir dependencies" && {

  if ! has "luarocks"; then
      log_fail "error: require: luarocks"
      exit 1
  fi

  luarocks install mjolnir.hotkey
  luarocks install mjolnir.application
  luarocks install mjolnir.th.hints
  luarocks install mjolnir.fnutils
  luarocks install mjolnir.geometry
  luarocks install mjolnir.screen
  luarocks install mjolnir.keycodes
}

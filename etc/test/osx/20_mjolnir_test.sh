#!/bin/bash

# -- START sh test
#
trap 'echo Error: $0: stopped; exit 1' ERR INT

. "$DOTPATH"/etc/lib/func

ERR=0
export ERR

test_mjolnir() {
    if bash $DOTPATH/etc/init/osx/20_mjolnir.sh; then
        print_success "mjolnir setup"
    else
        failure "$0: $LINENO: $FUNCNAME"
    fi
}

test_mjolnir

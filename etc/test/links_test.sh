#!/bin/bash

# -- START sh test
#
trap 'echo Error: $0: stopped; exit 1' ERR INT

. "$DOTPATH"/etc/lib/func

ERR=0
export ERR

test_links() {
    cd "$DOTPATH"
    make links >/dev/null
    if [ $? -eq 0 ]; then
        print_success "linking dot files"
    else
        failure "$0: $LINENO: $FUNCNAME"
    fi
}

test_links

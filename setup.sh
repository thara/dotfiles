#!/bin/bash

DOT_FILES=( ".vimrc" ".gvimrc" ".vim" ".ghci" ".todo.cfg" )

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

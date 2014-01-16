#!/bin/bash

DOT_FILES=( ".zshrc" ".vimrc" ".gvimrc" ".vim" ".ghci" ".todo.cfg" ".vrapperrc" ".gitconfig" ".tmux.conf")

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

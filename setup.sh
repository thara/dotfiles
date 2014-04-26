#!/bin/bash

DOT_FILES=( ".zshrc" ".vimrc" ".gvimrc" ".vim" ".ghci" ".todo.cfg" ".vrapperrc" ".gitconfig" ".tmux.conf" ".gemrc")

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

[ ! -d ~/.oh-my-zsh ] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
ln -s $HOME/dotfiles/.oh-my-zsh/custom/.zsh $HOME/.oh-my-zsh/custom/.zsh

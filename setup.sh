#!/bin/bash

[ ! -d ~/.zprezto ] && git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

DOT_FILES=( ".zshrc" ".zlogin" ".zlogout" ".zprofile" ".zshenv" ".zpreztorc" ".zshrc.func"\
  ".vimrc" ".gvimrc" ".vim" ".xvimrc" ".ghci" ".todo.cfg" ".vrapperrc" ".gitconfig" \
  ".tmux.conf" ".gemrc" ".emacs.d" ".emacs.el" ".lessfilter" ".ctags")

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

[ ! -d ~/zaw ] && git clone git://github.com/zsh-users/zaw.git ~/zaw
[ ! -d ~/.vim/bundle ] && git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# Linux : diff-highlight for git diff
# $ dpkg -L git | grep 'diff-highlight'
# $ sudo ln -s /usr/share/doc/git/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
# $ sudo chmod 755 /usr/local/bin/diff-highlight


#!/bin/bash

DOT_FILES=( ".zshrc" ".zshrc.func" ".vimrc" ".gvimrc" ".vim" ".ghci" ".todo.cfg" ".vrapperrc" ".gitconfig" \
  ".tmux.conf" ".gemrc" ".emacs.d" ".emacs.el" ".lessfilter" ".ctags")

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

[ ! -d ~/.oh-my-zsh ] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
ln -s $HOME/dotfiles/.oh-my-zsh/custom/.zsh $HOME/.oh-my-zsh/custom/.zsh


[ ! -d ~/zaw ] && git clone git://github.com/zsh-users/zaw.git ~/zaw
[ ! -d ~/.vim/bundle ] && git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim


# Linux : diff-highlight for git diff
# $ dpkg -L git | grep 'diff-highlight'
# $ sudo ln -s /usr/share/doc/git/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
# $ sudo chmod 755 /usr/local/bin/diff-highlight


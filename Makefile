DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin .vim
EXCLUSIONS := .DS_Store .git .gitignore .gitmodules .travis.yml
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

links:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

init:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/initialize

initzsh:
	@DOTPATH=$(DOTPATH) zsh $(DOTPATH)/etc/initialize_zsh

update:
	git pull origin master

test:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/runtest

clean:
	@echo 'Remove dotfiles in home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

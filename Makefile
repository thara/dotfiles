CANDIDATES := $(wildcard .??*) .vim
EXCLUSIONS := .DS_Store .git .gitignore .gitmodules .travis.yml
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

links:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

init:
	@DOTFILES_ROOT=$(PWD) bash $(PWD)/script/init

initzsh:
	@DOTFILES_ROOT=$(PWD) zsh $(PWD)/script/init_zsh

test:
	@DOTFILES_ROOT=$(PWD) bash $(PWD)/script/runtest

clean:
	@echo 'Remove dotfiles in home directory...'
	@-$(foreach val, $(DOTFILES_ROOT), rm -vrf $(HOME)/$(val);)

CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitignore .gitmodules .travis.yml bin .vim
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
BINFILES   := $(shell ls ./bin)

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)
	@$(foreach val, $(BINFILES), /bin/ls -dF ./bin/$(val);)

links:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@ln -sfnv src/github.com/thara/dotfiles $(HOME)/dotfiles
	@mkdir -p $(HOME)/bin
	@$(foreach val, $(BINFILES), ln -sfnv $(abspath bin/$(val)) $(HOME)/bin/$(val);)
	@ln -sfnv src/github.com/thara/dotfiles/.vim $(HOME)/.vim

init:
	@DOTFILES_ROOT=$(PWD) bash $(PWD)/script/init

initzsh:
	@DOTFILES_ROOT=$(PWD) zsh $(PWD)/script/init_zsh
	@ln -sfnv $(HOME)/src/github.com/thara/dotfiles/etc $(HOME)/etc

test:
	@DOTFILES_ROOT=$(PWD) bash $(PWD)/script/runtest

clean:
	@echo 'Remove dotfiles in home directory...'
	@-$(foreach val, $(DOTFILES_ROOT), rm -vrf $(HOME)/$(val);)

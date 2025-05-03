SHELL := /bin/bash

DOTFILES_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
export DOTFILES_ROOT

OS := $(shell . $(DOTFILES_ROOT)/script/functions && get_os)

CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitignore .gitmodules .travis.yml bin .vim .config
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
BINFILES   := $(shell ls ./bin)

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)
	@$(foreach val, $(BINFILES), /bin/ls -dF ./bin/$(val);)

links:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@ln -sfnv $(HOME)/src/github.com/thara/dotfiles $(HOME)/dotfiles
	@mkdir -p $(HOME)/bin
	@$(foreach val, $(BINFILES), ln -sfnv $(abspath bin/$(val)) $(HOME)/bin/$(val);)
	@ln -sfnv $(HOME)/src/github.com/thara/dotfiles/.vim $(HOME)/.vim
	@ln -sfnv $(HOME)/src/github.com/thara/dotfiles/etc $(HOME)/etc

install:
	@echo "Detected OS: $(OS)"
	@if [ -x "$(DOTFILES_ROOT)/$(OS)/install.sh" ]; then \
		bash "$(DOTFILES_ROOT)/$(OS)/install.sh"; \
	else \
		echo "No install.sh found for OS: $(OS)"; \
	fi

init:
	@DOTFILES_ROOT=$(PWD) bash $(PWD)/script/init

test:
	@DOTFILES_ROOT=$(PWD) bash $(PWD)/script/runtest

clean:
	@echo 'Remove dotfiles in home directory...'
	@-$(foreach val, $(DOTFILES_ROOT), rm -vrf $(HOME)/$(val);)

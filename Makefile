SHELL := /bin/bash

DOTFILES_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
export DOTFILES_ROOT

OS := $(shell . $(DOTFILES_ROOT)/script/functions && get_os)

install:
	@if [ -r "$(DOTFILES_ROOT)/$(OS)/install.sh" ]; then \
		bash "$(DOTFILES_ROOT)/$(OS)/install.sh"; \
	else \
		echo "No $@.sh found for OS: $(OS)"; \
	fi

test:
	@if [ -r "$(DOTFILES_ROOT)/$(OS)/test.sh" ]; then \
		bash "$(DOTFILES_ROOT)/$(OS)/test.sh"; \
	else \
		echo "No $@.sh found for OS: $(OS)"; \
	fi

CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitignore .gitmodules .travis.yml bin .vim .config
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.PHONY: shell
shell:
	@stow --target=$(HOME) --dir=$(DOTFILES_ROOT) shell

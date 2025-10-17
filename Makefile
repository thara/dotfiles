SHELL := /bin/bash

DOTFILES_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
export DOTFILES_ROOT

OS := $(shell . $(DOTFILES_ROOT)/shell/.bashrc.d/functions && get_os)

STOW          ?= stow
STOW_FLAGS    ?= --target=$(HOME) --dir=$(DOTFILES_ROOT) --no-folding --restow $(STOW_VERBOSE)

STOW_PACKAGES ?= shell macos vim git config bin
.PHONY: $(STOW_PACKAGES)

$(STOW_PACKAGES):
	@$(STOW) $(STOW_FLAGS) $@

dry-%: ## dry run stow packages
	@$(STOW) --no -v $(STOW_FLAGS) $(@:dry-%=%)

un%: ## uninstall stow packages
	@$(STOW) $(STOW_FLAGS) -D $(@:un%=%)

apply: ## apply multiple packages: make apply PKG="shell macos"
	@test -n "$(PKG)" || { echo "PKG is empty. ex: make apply PKG=\"shell macos\""; exit 1; }
	@for p in $(PKG); do \
		echo "==> stow $$p"; \
		$(STOW) $(STOW_FLAGS) $$p; \
	done

unapply: ## unstow multiple packages: make unapply PKG="shell macos"
	@test -n "$(PKG)" || { echo "PKG is empty. ex: make unapply PKG=\"shell macos\""; exit 1; }
	@for p in $(PKG); do \
		echo "==> unstow $$p"; \
		$(STOW) $(STOW_FLAGS) -D $$p; \
	done

apply_macos:  ## apply macOS settings
	@$(MAKE) apply PKG="shell macos vim git config bin"

apply_debian:  ## apply Debian settings
	@$(MAKE) apply PKG="shell vim git config bin"

apply_all:  ## apply all settings
	@$(MAKE) apply_$(OS)

.DEFAULT_GOAL := apply_all

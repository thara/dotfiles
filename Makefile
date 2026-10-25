SHELL := /bin/bash

DOTFILES_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
export DOTFILES_ROOT
MISE ?= mise

.DEFAULT_GOAL := bootstrap

.PHONY: bootstrap bootstrap-dry-run
bootstrap: ## Deploy dotfiles with mise
	$(MISE) -C "$(DOTFILES_ROOT)" bootstrap --only dotfiles

bootstrap-dry-run: ## Preview dotfile changes without applying them
	$(MISE) -C "$(DOTFILES_ROOT)" bootstrap --dry-run --only dotfiles

.PHONY: action_lint
action_lint:
	@actionlint
	@pinact run --verify
	@ghalint run

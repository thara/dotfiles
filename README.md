# dotfiles
My dotfiles

[![CI](https://github.com/thara/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/thara/dotfiles/actions/workflows/ci.yml)

## Requirements

- [GNU Make](https://www.gnu.org/software/make/)
- [mise](https://mise.jdx.dev/) 2026.10.18 or newer
- [GNU Stow](https://www.gnu.org/software/stow/) (during migration)

## Usage

Run these commands from this repository:

```sh
mise trust
make bootstrap-dry-run
make bootstrap
```

`make bootstrap` runs only the dotfiles step. It does not install tools.
Existing Stow installations should follow [the migration guide](docs/migration-to-mise.md)
before applying: existing files may need to be reconciled first.
The default `make` and existing Stow targets remain available during migration.

## Layout

- `mise.toml`: common dotfile deployment groups.
- `mise.macos.toml`: macOS-only groups, enabled by `.miserc.toml`.
- `shell/`, `vim/`, `git/`, `config/`, `bin/`, `macos/`, `agents/`, `mise/`: files to deploy under your home directory.
- `mise/.config/mise/mise.toml`: global mise settings and future tool versions;
  bootstrap links this file to `~/.config/mise/mise.toml`.
- `etc/`: supporting files, not deployed by bootstrap.

All groups defined for the current OS apply by default. For a machine-specific
selection, copy `mise.local.toml.example` to `mise.local.toml` and edit the list.
This local file is ignored by Git.

## My development environments

- [bash](https://www.gnu.org/software/bash/)
- [tmux](https://github.com/tmux/tmux)
  - [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
- [starship](https://github.com/starship/starship)

- [vim](https://www.vim.org/)

- [exa](https://github.com/ogham/exa)
- [bat](https://github.com/sharkdp/bat)
- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [fzf](https://github.com/junegunn/fzf)
- [rb](https://github.com/thisredone/rb)

- [direnv](https://direnv.net)
- [rbenv](https://github.com/rbenv/rbenv)

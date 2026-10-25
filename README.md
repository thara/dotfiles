# dotfiles
My dotfiles

[![CI](https://github.com/thara/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/thara/dotfiles/actions/workflows/ci.yml)

## Requirements

- [GNU Make](https://www.gnu.org/software/make/)
- [mise](https://mise.jdx.dev/) 2026.10.18 or newer

Install mise with Homebrew:

```sh
brew install mise
```

Alternatively, use the [official installer](https://mise.jdx.dev/installing-mise.html):

```sh
curl -fsSL https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"
```

Check the installed version with `mise --version`.

## Usage

Run these commands from this repository:

```sh
mise trust
make bootstrap-dry-run
make bootstrap
mise dot status
```

`make` is shorthand for `make bootstrap`. Both run only the dotfiles step;
they do not install tools.
For existing Stow installations, use the migration script below before applying.
The old Stow Make targets have been removed. The migration guide records the
commands used before their removal.

## Migrate an existing machine

Install mise and Python 3, then update this checkout **at its existing location**.
Keep a terminal open while migrating shell settings.

```sh
python3 scripts/migrate-to-mise.py          # Preview; no home links changed
python3 scripts/migrate-to-mise.py --apply  # Migrate and verify
mise dot status
```

The script uses the groups selected by this checkout's mise configuration,
including `mise.local.toml` when present. It first rehearses deployment in a
temporary home. It stops before changing your links if a normal file or a link
to another source conflicts with the planned deployment.

Only links pointing into this checkout are migrated; Stow itself is not required.
Directory links are expanded into directories and file links, preserving excluded
runtime paths (such as Vim plugins). Unrelated global mise settings are not used
by the migration script. The script prints a recovery record in a temporary
directory and attempts to restore original links if migration fails. Keep that
record until you have checked a new terminal and application settings saves.

Run `python3 -m unittest discover -s tests -v` to test migration with isolated homes.

Run `make action_lint` to check GitHub Actions workflows. This requires
`actionlint`, `pinact`, and `ghalint`, with network access for tag verification.

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

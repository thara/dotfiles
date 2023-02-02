export PATH=$HOME/bin:/usr/local/bin:$PATH

# no limit
HISTSIZE=-1
HISTFILESIZE=-1

export CDPATH=".:..:~"

export EDITOR=vim
export VISUAL=vim

export TERM=xterm-256color

[ -f ~/.bashrc.local ] && source ~/.bashrc.local

for i in $HOME/etc/profile.d/*.sh ; do
  [ -r "$i" ] && source "$i"
done

function fzf-select-repos {
  local selected_dir=$(ghq list | fzf-tmux --query "$LBUFFER" --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$selected_dir" ]; then
    cd $(ghq root)/${selected_dir}
  fi
}

bind -m vi-command -x '"\C-o":fzf-select-repos'

function get_os {
  case "$(uname | awk '{print tolower($0)}')" in
      *'linux'*)  echo 'linux'   ;;
      *'darwin'*) echo 'osx'     ;;
      *'bsd'*)    echo 'bsd'     ;;
      *)          echo 'unknown' ;;
  esac
}

if [ -n "$(get_os)" ]; then
  f="$HOME/.bashrc.$(get_os)"
  if [ -f "$f" ]; then
    source "$f"
  fi
fi

export GOPATH="$HOME"
export RUST_BACKTRACE=1

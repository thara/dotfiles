export PATH=/usr/local/bin:$PATH

# no limit
HISTSIZE=-1
HISTFILESIZE=-1

export CDPATH=".:..:~"

export EDITOR=vim
export VISUAL=vim

export TERM=xterm-256color

[ -f ~/.bashrc.local ] && source ~/.bashrc.local
[ -f ~/.bashrc.etc ] && source ~/.bashrc.etc

function fzf-select-session {
  local selected_dir=$(ghq list | fzf-tmux --query "$LBUFFER" --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  echo $selected_dir
  if [ -n "$selected_dir" ]; then
    local project_path=$(ghq root)/${selected_dir}
    if [[ ! -z ${TMUX} ]]; then
      local name=${selected_dir##*/}
      local session=${name//./-}
      tmux new-session -d -c $project_path -s $session 2> /dev/null
      tmux switch-client -t $session 2> /dev/null
    else
      cd $project_path
    fi
  fi
}

bind -m vi-command -x '"\C-o":fzf-select-session'

function fzf-select-repos {
  local selected_dir=$(ghq list | fzf-tmux --query "$LBUFFER" --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$selected_dir" ]; then
    cd $(ghq root)/${selected_dir}
  fi
}

bind -m vi-command -x '"\C-[":fzf-select-repos'

function fzf-git-fixup {
  local commit_hash=$(git log --pretty=format:'%h - %s' --abbrev-commit | fzf --height 40% --reverse --ansi | awk '{print $1}')
  if [ -n "$commit_hash" ]; then
    git commit --fixup $commit_hash
  else
    echo "No commit selected"
  fi
}

bind -m vi-command -x '"\C-f":fzf-git-fixup'

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

# update history in real time
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

bind -m vi-insert '"\C-x\C-e": edit-and-execute-command'

if command -v mcfly >/dev/null 2>&1; then
  export MCFLY_FUZZY=2
  export MCFLY_RESULTS_SORT=LAST_RUN
  eval "$(mcfly init bash)"
fi

# fzf configration
export FZF_DEFAULT_COMMAND='fd --type f --hidden'
export FZF_DEFAULT_OPTS='--border'
export FZF_TMUX_HEIGHT="50%"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_COMMAND="rg --files --hidden --follow --glob '!.git/*'"
export FZF_CTRL_T_OPTS="--preview 'bat  --color=always --style=header,grid --line-range :100 {}'"
export FZF_ALT_C_COMMAND="fd -t d . | sort"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"


function fzf_select_session() {
  local selected_dir=$(ghq list | fzf-tmux --query "$LBUFFER" --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  echo $selected_dir
  if [ -n "$selected_dir" ]; then
    local project_path=$(ghq root)/${selected_dir}
    if [[ ! -z ${TMUX} ]]; then
      local session=${${selected_dir##*/}//./-}
      local current_sessoin=$(tmux list-sessions | grep 'attached' | cut -d":" -f1)
      if [[ $current_session =~ ^[0-9]+$ ]]; then
        BUFFER="cd $project_path && tmux rename-session $session"
      else
        tmux list-sessions | cut -d":" -f1 | grep -e "^$session\$" > /dev/null
        if [[ $? != 0 ]]; then
          tmux new-session -d -c $project_path -s $session
        fi
        BUFFER="tmux switch-client -t $session"
      fi
    else
      BUFFER="cd $project_path"
    fi
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf_select_session

function fzf_select_repos() {
  local selected_dir=$(ghq list | fzf-tmux --query "$LBUFFER" --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")

  if [ -n "$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi

  zle reset-prompt
}
zle -N fzf_select_repos

function fzf_select_git_branch() {
  local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-authordate refs/heads | perl -pne 's{^refs/heads/}{}' | fzf-tmux --query "$LBUFFER" --preview "git show --color=always {}")

  if [ -n "$selected_branch" ]; then
    BUFFER="git checkout ${selected_branch}"
    zle accept-line
  fi

  zle reset-prompt
}
zle -N fzf_select_git_branch

function fzf_open_editor() {
  local selected=$(fd | fzf-tmux --query "$LBUFFER" --multi --select-1)

  if [ -n "$selected" ]; then
    ${EDITOR:-vim} "${selected}"
  fi
  zle reset-prompt
}
zle -N fzf_open_editor

function fkill() {
  local pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ -n "$pid" ]; then
      echo $pid | xargs kill -9
  fi
}

## https://junegunn.kr/2016/07/fzf-git/

function is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

funciton git_files() {
  is_in_git_repo || return
  git -c color.status=always status --short |
    fzf-tmux -m --ansi --nth 2..,.. --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
    cut -c4- | sed 's/.* -> //'
}

function git_branches() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-tmux --ansi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
    sed 's/^..//' | cut -d' ' -f1 |
    sed 's#^remotes/##'
}

function git_tags() {
  is_in_git_repo || return
  git tag --sort -version:refname | fzf-tmux --preview 'git show --color=always {} | head -'$LINES
}

function git_history() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-tmux --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

# A helper function to join multi-line output from fzf
join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

fzf-git-files-widget() LBUFFER+=$(git_files | join-lines)
fzf-git-branches-widget() LBUFFER+=$(git_branches | join-lines)
fzf-git-tags-widget() LBUFFER+=$(git_tags | join-lines)

zle -N fzf-git-files-widget
zle -N fzf-git-branches-widget
zle -N fzf-git-tags-widget

bindkey "^f" fzf-file-widget
bindkey '^_' fzf_select_repos
bindkey '^o' fzf_select_session
bindkey '^B' fzf_select_git_branch
bindkey '^E' fzf_open_editor

## Git
bindkey '^g^f' fzf-git-files-widget
bindkey '^g^b' fzf-git-branches-widget
bindkey '^g^t' fzf-git-tags-widget

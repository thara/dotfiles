# Agent skills の配置規約

自作の skill は `.agents/skills/<name>/SKILL.md` をSSoTとし、各エージェントへはリンクで見せる。

## 各ツールが読む場所

| ツール      | global                                          | project               |
| ----------- | ----------------------------------------------- | --------------------- |
| Codex       | `~/.agents/skills`                              | `.agents/skills`      |
| opencode    | `~/.agents/skills`（`~/.claude/skills` も読む） | `.agents/skills`      |
| Claude Code | `~/.claude/skills` のみ                         | `.claude/skills` のみ |

Claude Code は `.agents/skills` を読まないため、Claude 向けのリンクだけ別に張る。

## この dotfiles（global）

- SSoT: `agents/.agents/skills/<name>/`
- `dotfile_groups.agents` → `~/.agents/skills/`
- `dotfile_groups.claude-skills` → `~/.claude/skills/`（`mise.macos.toml`）
- `~/.claude/skills/synced/` は claude.ai 同期用で Claude が管理するため、ディレクトリごとリンクしない

skill を追加・ファイルを増やしたら `make bootstrap` を再実行する（`symlink-each` はファイル単位でリンクするため）。

## SKILL.md の注意

- frontmatter の `name` はディレクトリ名と一致させる（一致しないと読み込まないツールがある）
- Claude Code 専用のフィールドは他ツールでは無視される

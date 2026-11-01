# stow → mise bootstrap 移行 TODO

参考: https://blog.shibayu36.org/entry/2026/10/13/173000

## Phase 0: 下調べ（変更しない）
- [x] mise をインストールする（Homebrew で導入済み）
- [x] mise を更新し、今回使う `dotfile_groups` / `mise dot` が使えることを確認する（`2026.10.18` で検証済み）
- [x] `dotfile_groups` のデフォルトの `mode` / `target` を公式ドキュメントで確かめる
- [x] OS別configの書き方（`auto_env`、`mise.macos.toml`、platform environments）を確かめる
- [x] `mise.toml` をリポジトリ直下に置くか、`~/.config/mise/` 側に置くかを決める

### Phase 0 調査メモ（2026-10-24）

- 実機は `/opt/homebrew/bin/mise`（Homebrew）。`brew update` → `brew upgrade mise` で `2026.9.1` から `2026.10.18` に更新済み。グローバル設定の配置は Phase 2 で行う。
- 一時ディレクトリに設定・状態・ソース・適用先を分離し、`dotfile_groups` の定義、`mise trust`、`mise bootstrap --dry-run --only dotfiles`、実適用、`mise dot status` を検証済み。1ファイルのリンク作成と `up to date` を確認した。ホームの dotfiles には未適用。
- [公式 Groups](https://mise.jdx.dev/dotfiles/groups.html): グループの既定値は `mode = "symlink-each"`、`target = "~"`。意図を明確にするため両方を明記する。
- 相対 `root` の基準は設定ファイルのディレクトリではなく、`dotfiles.root`（既定値 `~/.dotfiles`）。このリポジトリの実際の場所を明示する必要がある。
- [公式 Config environments](https://mise.jdx.dev/configuration/environments.html#platform-environments): `auto_env` を有効にすると `mise.macos.toml` などを自動ロードできる。現時点では既定で無効。設定探索に関わるため `mise.toml` 内ではなく `.miserc.toml` または `MISE_AUTO_ENV=true` で有効化する。
- 配置定義はリポジトリ直下の `mise.toml` / `mise.macos.toml` に置く。`.miserc.toml` で OS 別設定を有効化し、このリポジトリで `make bootstrap` を実行する。
- 配布ファイルはリポジトリ直下の `shell/` / `vim/` などのグループ別ディレクトリに置く。グローバルなツール設定は `mise/.config/mise/mise.toml` で管理し、mise グループでホームに配置する。ツールのバージョンはまだ指定しない。
- グループの `root` は `shell` などとし、`[settings.dotfiles] root = "."` で基準を設定する。mise 2026.10.18 ではグループの root 内の `{{ config_root }}` が展開されないため使用しない。
- 作業開始時点で `vim/.stow-local-ignore` は削除済み（未コミット）。Phase 1 の `exclude` は Git に残っている削除前の内容から移す。現状の `make dry-vim` だけでは除外条件の比較基準にならないため注意する。

## Phase 1: 定義を書き、dry-runで突き合わせる
- [x] リポジトリ直下の `mise.toml` に `[dotfile_groups]` を定義する
  - [x] shell / vim / git / config / bin / mise（共通）
  - [x] macos / agents（`mise.macos.toml`、macOSのみ）
  - [x] すべて `target = "~"`、`mode = "symlink-each"`
- [x] 削除前の `vim/.stow-local-ignore` の内容を vim グループの `exclude` に移す
- [x] `etc/` が対象外のままになっていることを確かめる
- [x] マシンごとの選択用に `mise.local.toml.example` を用意する（必要な場合にリポジトリ直下の `mise.local.toml` にコピー。Git 管理対象外）
- [x] 実機でリポジトリ設定に `mise trust` を実行する
- [x] mise と stow の配置先・リンク元を比較する
- [x] `make bootstrap` / `make bootstrap-dry-run` を追加する

### Phase 1 検証結果

- 既存7グループは、削除前の Vim 除外設定を復元した一時コピーで stow の dry-run と一時適用を行い、mise の結果と比較した。配置先・リンク元が102ファイルすべて一致（shell 7 / vim 67 / git 4 / config 8 / bin 3 / macos 2 / agents 11）。
- 構成変更後、空の一時ホームで `make bootstrap-dry-run` → `make bootstrap` → `mise dot status --json` を実行。mise グループを含む8グループ・103ファイルが適用され、全グループが `applied`。再度の dry-run でも変更なし。
- `~/.config/mise/mise.toml` が配布用のグローバル設定を指すことを一時ホームで確認した。実ホームへの配置も Phase 2 で完了した。
- ディレクトリ移動に合わせ、実ホームの既存リンク47本の参照先をリポジトリ直下の各グループに戻した。移動前に有効だったリンクはすべて有効。元から切れていた `~/bin2/clgrep` / `~/bin2/rb` は今回修復していない。
- 実ホームの `make bootstrap-dry-run` は Vim の既存ファイルとの衝突で停止する。`~/.vim/autoload/plug.vim`、`plug.vim.old`、`pack/github/start/copilot.vim/` のファイル、およびディレクトリリンクの `ftplugin` / `syntax` が対象。この衝突は Phase 2 の Vim 切り替えで解消済み。`--force` は使用していない。
- 既存の `make` のデフォルトと stow ターゲットは移行期間中維持する。stow の対象ディレクトリは従来どおりリポジトリ直下。

## Phase 2: 1パッケージずつ切り替える
リポジトリ直下の `mise.local.toml` で `[bootstrap] dotfile_groups` を切り替え済み＋今回のグループに限定する（初回は `config` のみ）。各パッケージで「dry-runで確認 → `make unapply PKG=<pkg>` → `make bootstrap` → `mise dot status`」を繰り返す。未移行の Vim などを同時に適用しない。

Vim の除外設定はすでに削除されているため、unstow の前に削除前の設定を一時的に復元するなどして対象を確認する。
- [x] config（8ファイルを stow から mise に切り替え済み）
- [x] mise（グローバル設定の初回配置済み。stow の解除は不要）
- [x] bin（3ファイルを stow から mise に切り替え済み）
- [x] git（4ファイルを stow から mise に切り替え済み）
- [x] vim（67ファイルを mise で配置、除外対象の既存リンクは保持）
- [x] macos（2ファイルを stow から mise に切り替え済み）
- [x] agents（11ファイルを stow から mise に切り替え済み）
- [ ] Claude Code 等のアプリ自身が設定を保存した後もリンクが保たれることを確認する（書き込み権限は確認済み、アプリからの保存は未検証）
- [x] shell（7ファイルを切り替え、Bash / Zsh の構文確認済み）
- [x] 移行前に記録した既存リンク47本を再確認（維持対象・既存のリンク切れは下記参照）

### Phase 2 進捗

- `mise.local.toml` を作成し、現在の選択は `dotfile_groups = ["config", "mise", "bin", "git", "vim", "macos", "agents", "shell"]`。
- config: stow の解除 dry-run で8本のみが対象と確認し、`make unapply PKG=config` → `make bootstrap-dry-run` → `make bootstrap` を実行した。
- mise が8本のリンクを作成したこと、リンク先が正しいこと、元ファイルの内容が変わっていないことを検証済み。`mise dot status` は `1 entry up to date`。
- 現在の status は全8グループを表示する。全グループのリンク切り替えは完了。
- mise: `make bootstrap` で `~/.config/mise/mise.toml` を作成。リンク先がリポジトリの `mise/.config/mise/mise.toml` であることと、リポジトリ外（`/tmp`）からもグローバル設定が読み込まれることを確認済み。ツールのバージョンはまだ指定していない。
- bin: 解除 dry-run で `~/bin/bookmark.sh` / `clgrep` / `rb` の3本のみを確認し、stow から mise に切り替え済み。リンク先・ファイル内容・実行権限を検証した。
- git: 解除 dry-run で4本のみが対象と確認し、stow から mise に切り替え済み。リンク先・ファイル内容・権限、および Git が読み込むグローバル設定が切り替え前後で一致することを検証した。
- vim: 一時ホームで検証後、削除前の `.stow-local-ignore` を一時復元して unstow。`autoload` / `ftplugin` / `pack` / `plugin` / `syntax` を実ディレクトリに変更し、mise で67ファイルを配置した。元ファイルの内容と `.netrwhist` は変更なし。一時復元した除外ファイルは再度削除済み。
- 除外対象の `~/.vim/plugged` / `vim-lsp-servers` / `spell` は元のディレクトリリンクを復元して保持する。これらは mise の管理外であり、後の旧リンク確認でも削除しない。
- macos: Hammerspoon の `init.lua` と LuaRocks の `config.lua` の2本を stow から mise に切り替え済み。リンク先・元ファイルの内容・権限を検証した。
- agents: Claude Code / OpenCode / Herdr の設定リンク11本を切り替え済み。リンク先・内容・権限の維持と `~/.claude/settings.json` の書き込み権限を確認した。アプリ自身による設定保存後の挙動は未検証のため、別項目として残す。
- shell: 7本のリンクを切り替え、元ファイルの内容・権限を維持していることを確認。配置後の Bash 設定5ファイルと Zsh 設定を `-n` で構文検証済み。新しい対話シェルでの実利用は未確認。
- 移行前に記録した47本を再確認。元の相対リンクが残るのは意図的に保持した Vim の3ディレクトリと、移行前から切れていた `~/bin2/clgrep` / `~/bin2/rb` のみ。
- status は全8グループが `applied`（`8 entries up to date`）。再度の dry-run は変更なし。次は Phase 3 の CI 置き換え。agents のアプリ保存動作の確認は引き続き未完了。

## Phase 3: CIを置き換える
- [x] stow のインストール手順を消す
- [x] `jdx/mise-action` v4.3.0 を SHA 固定で導入する（mise 本体は 2026.10.18）
- [x] `actionlint` / `pinact run --verify` / `ghalint run` を通す
- [x] 一時ホームに `make bootstrap` で実適用する方式を採用（`MISE_YES=1`）
- [x] status の JSON で全グループの適用状態と、OS 別のグループ集合を検証する
- [ ] GitHub Actions の Ubuntu / macOS マトリクス実行を確認する（ワークフロー実装済み、リモート実行は未確認）

### Phase 3 検証結果

- CI は一時ホームと mise の設定・状態・キャッシュディレクトリを使用し、`make bootstrap-dry-run` → `make bootstrap` → status 検証 → 再 dry-run を実行する。
- `.github/scripts/verify-dotfiles.py` は Linux の共通6グループ、macOS の8グループが選択され、すべて `applied` であることを検証する。グローバル mise 設定のリンク先も確認する。
- `make action_lint` はネットワークアクセスを許可した状態で成功（SHA とタグの照合を含む）。
- macOS では Git 管理対象と今回の追加ファイルだけを一時コピーし、`mise.local.toml` や未追跡プラグインを含めない状態で CI と同じ手順を実行して成功。GitHub Actions 上での実行、Linux 実機での動作は未確認。

## Phase 4: 後片付け
- [ ] Makefile の stow 関連ターゲットを消す
- [ ] `action_lint` を Makefile に残すか、`[tasks]` に移すかを決める
- [ ] `vim/.stow-local-ignore` を消す
- [ ] README を更新する（前提条件を mise にし、初回手順を `mise bootstrap` にする）

## Phase 5（任意・別件）
- [ ] `[bootstrap.packages]`（Homebrew / apt）でパッケージを管理するか検討する
- [ ] `[bootstrap.macos.defaults]` で macOS 設定を管理するか検討する
- [ ] `[bootstrap.mise_shell_activate]` を使うか検討する（.bashrc/.zshrc の管理とぶつからないか）

## 副作用・注意点
- stow のリンクは相対パスなので、mise が `differs` と判定する可能性がある → `--force` に頼らず、unstow してから適用する
- `--prune` で消せるのは mise が張ったリンクだけ → stow 時代のリンクは `make unapply` で消す
- `mise.toml` をリポジトリ直下に置くと、リポジトリに cd するたびにプロジェクト設定として読み込まれる
- まっさらな環境では mise の導入が前提になる → README にインストール手順を書いておく

" My autocmd group
augroup MyAutoCmd
    autocmd!
augroup END

scriptencoding utf-8

" ## Vim options {{{

" ### Indent {{{

" 新しい行のインデントを現在行と同じにする
set autoindent

" 高度なインデント
set smartindent

" タブが対応する空白の数
set tabstop=2

" インデントでずれる幅
set shiftwidth=2

" タブキーでカーソルが動く幅
set softtabstop=2

" タブの代わりに空白を挿入
set expandtab

" 行頭ではshiftwidth分インデント挿入(それ以外ではtabstop分空白)
set smarttab

" 折り返しの際にインデント
if exists('+breakindent')
  set breakindent
endif
" }}}


" ### Folding {{{

" マーカーで折り畳みを指定
set foldmethod=indent

" 折りたたみを示す列を表示
set foldcolumn=1

" 最初に折りたたみをなるべく開く
set foldlevel=99

" }}}


" ### Search {{{

" ハイライトで検索
set hlsearch
nohlsearch

" 大文字小文字を無視
set ignorecase

" インクリメンタル検索
set incsearch

" 大文字が入力されたら大文字小文字を区別する
set smartcase

" }}}


" ### Buffer {{{

" 外部でファイルが変更されたら自動で読みなおす
set autoread

" 編集中でも他のファイルを開けるようにする
set hidden

" スワップファイルを作らない
set noswapfile

" バックアップを作らない
set nobackup

" 既存のファイルを開くときはとりあえず utf-8
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp

" Vim を終了しても undo の記録を残す
set undofile undodir=~/.vimundo

" }}}


" ### Appearance {{{

" 色数
if !has('gui_running')
  set t_Co=256
endif

" 背景色
set background=dark

" コマンドラインの行数
set cmdheight=2

" 現在行の色を変えない
set nocursorline

" ルーラー表示
set ruler

" ステータス行を常に表示
set laststatus=2

" スクリプト実行中に画面を描画しない
set lazyredraw

" 不可侵文字を可視化
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<

" 行番号を表示 (相対)
set number relativenumber

" タイプライタースクロール
set scrolloff=5

" 入力したコマンドを画面下に表示
set showcmd

" 自動折り返ししない
set textwidth=0

" 2個以上のタブページがあるときのみタブページのラベルを表示
set showtabline=1

" 長い行を @ にさせない, 印字不可能文字を16進数で表示
set display=lastline,uhex

" 埋める文字
set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-,diff:-

" vim script の継続行(\)のインデント量を 0 にする
let g:vim_indent_cont = 0

" ステータスライン
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}

" 補完で preview しない
set completeopt-=preview

" 構文アイテムを検索する桁数の最大値
set synmaxcol=150

" 常に左側に列を表示する(gitgutterでガタガタしない)
set signcolumn=yes
" }}}


" ### Input {{{

" バックスペースで削除できる文字
set backspace=indent,eol,start

" ヤンクなどで * レジスタにも書き込む
set clipboard& clipboard+=unnamed

" マッピングの受付時間 (<Leader> とか)
set timeout timeoutlen=3000 ttimeoutlen=100

" キーコード待ち時間
set ttimeoutlen=10

" 矩形選択を可能にする
set virtualedit& virtualedit+=block

" 行連結でスペースを入れない
set nojoinspaces

" 辞書
set dictionary=/usr/share/dict/words

if !exists('loaded_matchit')
  " matchitを有効化
  runtime macros/matchit.vim
endif

" }}}


" ### Command {{{

" コマンドライン補完
set wildmenu

" コマンドライン補完の方法
set wildmode=longest:full,full

" コマンドの履歴の保存数
set history=5000
" }}}


" ### Misc {{{

" <C-a> や <C-x> で数値を増減させるときに8進数を無効にする
set nrformats-=octal

" 行をまたいでカーソル移動
set whichwrap&
set whichwrap+=h,l

" 行を折り返さない
set nowrap

" 日本語ヘルプ
set helplang=ja

" K でヘルプを引く
set keywordprg=:help"

" swap への書き込みや CursorHold 発生の間隔
set updatetime=1000

" " いろんなコマンドの後にカーソルを先頭に移動させない
set nostartofline"

" 改行文字
set ffs=unix,dos,mac

" デフォルトエンコーディング
set encoding=utf-8

" undoファイルの置き場所
set undodir=/tmp/vim/

" viminfoファイルの設定
set viminfo='50,<1000,s100,\"50

" 新しいウィンドウを右に開く
set splitright

" changelog設定
let g:changelog_dateformat = "%Y-%m-%d"
let g:changelog_username = "thara"
" エントリの下に空行を入れておくと新アイテム行が一番下になる
let g:changelog_new_date_format = "%d  %u\n\n  * %p %c\n\n\n"
let g:changelog_new_entry_format = "  *  %c"

" changelogグローバルマッピング自動設定
autocmd MyAutoCmd BufEnter * runtime ftplugin/changelog.vim

" }}}

" }}}



" ## Key mapping {{{

"if has("mac")
"  " option(alt)キーをMetaキー扱いにする
"  set macmeta
"  map <ESC>h <M-h>
"  map <ESC>l <M-l>
"endif

" Escの2回押しでハイライト消去
noremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" 素早くコマンドモードに
noremap ; :
noremap : ;

" 検索結果マッチ時にカーソル位置を画面中央に
nnoremap n nzzzv
nnoremap N Nzzzv
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Ex-Mode 無効
nnoremap Q <Nop>

" ページ送り
noremap <C-f> <C-e>
noremap <C-b> <C-y>

" ウィンドウ移動
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

" 引数リスト
nnoremap <Space><Space> :args<CR>
nnoremap <Space>l :arglocal<CR>
nnoremap <Space>j :argadd % <Bar> next <Bar> args<CR>
nnoremap <Space>e :argedit % <Bar> args<CR>
nnoremap <Space>k :<C-R>=argidx()+1<CR>argdelete <Bar> args<CR>
" 新規ローカル引数リストを作る
nnoremap <Space>s :arglocal! %<CR>
" 引数リスト内の現在指しているファイルに戻る
nnoremap <Space>c :argument<CR>
nnoremap <silent> <C-h> :previous<CR>
nnoremap <silent> <C-l> :next<CR>
nnoremap <Space>f :first<CR>
nnoremap <Space>t :last<CR>

" タブページ間の移動
"nnoremap <silent> <C-h> :tabprevious<CR>
"nnoremap <silent> <C-l> :tabnext<CR>
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [T :tabfirst<CR>
nnoremap <silent> ]T :tablast<CR>

" タブページの移動
nnoremap <silent> <M-h> :<C-u>tabmove -1<CR>
nnoremap <silent> <M-l> :<C-u>tabmove +1<CR>

" バッファ移動
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" arglist移動
nnoremap <silent> [a :previous<CR>
nnoremap <silent> ]a :next<CR>
nnoremap <silent> [A :first<CR>
nnoremap <silent> ]A :last<CR>

" Quickfix
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :<C-u>cfirst<CR>
nnoremap <silent> ]Q :<C-u>clast<CR>

" 相対行番号表示をトグル
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>

" 貼り付けたテキストの末尾へ自動的に移動
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" 行末までヤンク
nnoremap Y y$

" x,X,s,S でレジスタを汚さない
" nnoremap x "_x
" vnoremap x "_x
" nnoremap X "_X
" vnoremap X "_X
nnoremap s "_s
vnoremap s "_s
nnoremap S "_S
vnoremap S "_S

" 貼り付けたテキストを素早く選択する
noremap gV `[v`]

" コマンドラインウィンドウ暴発防止
map q: :q
" 保存して閉じる/保存せず閉じるの暴発防止
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" LeaderをSpaceキーに
let mapleader = "\<Space>"

" .vimrcを開く
nnoremap <silent> <Leader>ev  :<C-u>tabedit $MYVIMRC<CR>

" bundles.vimを開く
nnoremap <silent> <Leader>eb  :<C-u>tabedit ~/.vim/bundles.vim<CR>

" .vimrcのリロード
nnoremap <silent> <Leader>rv :<C-u>source $MYVIMRC<CR>

" vimgrep時に同時にquickfix-windowを開く
autocmd MyAutoCmd QuickFixCmdPost *grep* cwindow

" インサートモードでも誤爆を防ぐ
inoremap <C-@> <C-[>

" Emacs風
inoremap <silent> <C-b> <Left>
inoremap <silent> <C-f> <Right>
inoremap <silent> <C-e> <End>
inoremap <silent> <C-a> <Home>
inoremap <silent> <C-d> <Del>

nnoremap <silent> <C-X>0 :only<CR>
nnoremap <silent> <C-x>2 :sp<CR>

" コマンドラインモードでもEmacs風
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

" コマンド履歴のフィルタリングにカーソルキーを使わない
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" 繰り返しを楽にする
xnoremap . :normal .<CR>

" ヤンクレジスタの値をペースト
xnoremap <silent> <Leader>p "0p

" lexima.vim で括弧repeat可能にする https://qiita.com/yami_beta/items/26995a5c382bd83ac38f
inoremap <C-l> <C-g>U<Right>

" grep https://www.pixiv.net/fanbox/creator/3615/post/38621
nnoremap g/  :<C-u>global//print<CR>
" }}}



" ## Plugins {{{
call plug#begin('~/.vim/plugged')

" Vim help written by japanese
Plug 'vim-jp/vimdoc-ja'

" ### Appearance {{{
" Color Scheme
Plug 'pbrisbin/vim-colors-off'

" Minimalist path navigator
Plug 'justinmk/vim-dirvish'
" Plug 'kristijanhusak/vim-dirvish-git'
"  let g:dirvish_git_indicators = {
"   \ 'Modified'  : 'M',
"   \ 'Staged'    : '+',
"   \ 'Untracked' : '?',
"   \ 'Renamed'   : 'R',
"   \ 'Unmerged'  : '-',
"   \ 'Ignored'   : 'x',
"   \ 'Unknown'   : '?'
"   \ }

" Fuzzy Finder (ctrlp alternative)
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" インデント可視化
"Plug 'Yggdroot/indentLine'
" Coolなステータスライン
Plug 'itchyny/lightline.vim'
" インサートモード時に行番号の色を反転
Plug 'cohama/vim-insert-linenr'
" AsciiDoc syntax highlighting
"Plug 'asciidoc/vim-asciidoc'
" }}}


" ### Input {{{
" 賢い入力補助
"Plug 'kana/vim-smartinput'
Plug 'cohama/lexima.vim'
" テキストオブジェクトのまわりに文字を挿入
Plug 'tpope/vim-surround'
" surround.vim を繰り返し可能に
Plug 'tpope/vim-repeat'
"コメントアウト/アンコメントのトグル
Plug 'tpope/vim-commentary'
" Alignment
Plug 'junegunn/vim-easy-align'
" 整形 (Vim Align them all)
Plug 'h1mesuke/vim-alignta', {'on': ['Alignta', 'Align']}
" Stop ]
Plug 'tyru/stoptypofile.vim'
" 一部分だけ別バッファで編集
Plug 'thinca/vim-partedit'
" }}}

" ### Language {{{
"Plug 'davidhalter/jedi-vim', { 'for': ['python'] }

Plug 'toyamarinyon/vim-swift', { 'for': ['swift'] }
Plug 'derekwyatt/vim-scala', { 'for': ['scala'] }
Plug 'fatih/vim-go', { 'for': ['go']}

Plug 'rust-lang/rust.vim', { 'for': ['rust']}
Plug 'racer-rust/vim-racer', { 'for': ['rust']}
Plug 'rhysd/rust-doc.vim', { 'for': ['rust']}

Plug 'leafgarland/typescript-vim', { 'for': ['typescript']}

" Pythonの関数とクラスをテキストオブジェクト化 + motion追加
Plug 'bps/vim-textobj-python', { 'for': ['python']}
" Rubyのブロックをテキストオブジェクト化
Plug 'rhysd/vim-textobj-ruby', { 'for': ['ruby']}
" end キーワードの自動挿入
Plug 'tpope/vim-endwise'

Plug 'elzr/vim-json', { 'for': ['json']}

Plug 'reasonml-editor/vim-reason-plus'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" the path to python3 is obtained through executing `:echo exepath('python3')` in vim
let g:python3_host_prog = "/usr/local/bin/python3"

"Plug 'tpope/vim-markdown'
" }}}

" ### Misc {{{
" Git
Plug 'tpope/vim-fugitive'
" Add GitHub support to fugitive
Plug 'tpope/vim-rhubarb'
" Show git diff left
Plug 'airblade/vim-gitgutter'
" テキストオブジェクト拡張
Plug 'kana/vim-textobj-user'
" 全体をテキストオブジェクト化
Plug 'kana/vim-textobj-entire'
" タグページごとにカレントディレクトリを設定
Plug 'kana/vim-tabpagecd'
" 独自モードを作成
Plug 'thinca/vim-submode'
" ヤンク履歴
"Plug 'LeafCage/yankround.vim'
" Ack
Plug 'mileszs/ack.vim'

" Cheat Sheet
Plug 'reireias/vim-cheatsheet'
let g:cheatsheet#cheat_file = '~/Dropbox/Work/cheatsheet.md'
let g:cheatsheet#vsplit = 1

" コードを書いて即実行
" 汎用的な quickrun-hook
" QuickFix 該当箇所のハイライト
" 非同期でシンタックスチェック
Plug 'thinca/vim-quickrun', { 'on': ['QuickRun']}
\   | Plug 'osyo-manga/shabadou.vim'
\   | Plug 'cohama/vim-hier'
\   | Plug 'osyo-manga/vim-watchdogs', {
\       'for': [
\         'cpp', 'ruby', 'javascript', 'haskell', 'python', 'perl', 'php', 'lua', 'c', 'scala', 'ocaml', 'sh', 'zsh', 'sass', 'scss',
\       ],
\ }

" Better JSON for vim
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" Plug 'fuenor/qfixhowm'
" let g:QFixHowm_Key = 'g'
" let g:howm_dir           = '~/Dropbox/howm'
" let g:howm_filename      = '%Y/%m/%Y-%m-%d-%H%M%S.txt'
" let g:howm_fileencoding  = 'utf-8'
" let g:howm_fileformat    = 'unix'
" let g:QFixWin_EnableMode = 1
" let g:QFixHowm_FileType = 'asciidoc'
" let g:QFixHowm_Title = '#'
" let g:QFixHowm_Wiki = 1
" let g:QFixHowm_WikiDir = 'wiki'
" let g:QFixHowm_UserSwActionLock = ['[ ]', '[:draft]', '[:work]', '[:private]']
" let g:QFixHowm_Template = [
"   \"# %TAG%",
"   \""
" \]
" let QFixHowm_MenuDir = 'menu'

" Dash
Plug 'rizzatti/dash.vim'

" }}}

call plug#end()
" }}}



" ## Color {{{
filetype plugin indent on

autocmd MyAutoCmd ColorScheme * highlight Search term=reverse ctermfg=black ctermbg=106
autocmd MyAutoCmd ColorScheme * highlight clear CursorLine
autocmd MyAutoCmd ColorScheme * highlight CursorLine cterm=None ctermbg=233 gui=None guibg=DarkBlue
autocmd MyAutoCmd ColorScheme * highlight LineNr ctermfg=241 ctermbg=none guifg=Yellow
autocmd MyAutoCmd ColorScheme * highlight Normal ctermfg=250 ctermbg=none
autocmd MyAutoCmd ColorScheme * highlight SpecialComment ctermfg=8

"let g:hybrid_custom_term_colors = 1
"let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme off

syntax on
" }}}

"## Plugin Setting {{{

" ##### dirvish.vim {{{
let g:dirvish_mode = ':sort r /[^\/]$/'
nnoremap <silent> <C-e> :Dirvish<CR>
" hidden files
"autocmd MyAutoCmd FileType dirvish keeppatterns g@\v/(\.|__)[^\/]+/?$@d
augroup my_dirvish_events
  autocmd!
  " Map t to "open in new tab".
  autocmd FileType dirvish
    \  nnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>
    \ |xnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>

  " Enable :Gstatus and friends.
  "autocmd FileType dirvish call fugitive#detect(@%)

  " Map CTRL-R to reload the Dirvish buffer.
  autocmd FileType dirvish nnoremap <buffer> <C-R> :<C-U>Dirvish %<CR>

  " Map `gh` to hide dot-prefixed files.
  " To "toggle" this, just press `R` to reload.
  autocmd FileType dirvish nnoremap <buffer> gh :keeppatterns g@\v/(\.\|__)[^\/]+/?$@d<cr>
augroup END

let g:LanguageClient_serverCommands = {
    \ 'ruby': ['solargraph', 'stdio'],
\}
" }}}

" ### Submode {{{
let g:submode_keep_leaving_key = 1
let g:submode_timeout = 0
call submode#enter_with('winsize', 'n', '', '<C-W>>', '<C-W>>')
call submode#enter_with('winsize', 'n', '', '<C-W><', '<C-W><')
call submode#enter_with('winsize', 'n', '', '<C-W>+', '<C-W>+')
call submode#enter_with('winsize', 'n', '', '<C-W>-', '<C-W>-')
call submode#map('winsize', 'n', '', '>', '<C-W>>')
call submode#map('winsize', 'n', '', '<', '<C-W><')
call submode#map('winsize', 'n', '', '+', '<C-W>+')
call submode#map('winsize', 'n', '', '-', '<C-W>-')
" }}}

" JSONファイル表示に何も隠さない
let g:vim_json_syntax_conceal = 0

nnoremap [fzf] <Nop>
nmap s [fzf]
" https://github.com/junegunn/fzf.vim#commands
nnoremap [fzf]b :Buffers<CR>
nnoremap [fzf]f :Files<CR>
nnoremap [fzf]t :Tags<CR>
nnoremap [fzf]l :Lines<CR>
nnoremap [fzf]c :Commits<CR>
nnoremap [fzf]h :History<CR>

cnoreabbrev Ack Ack!
nnoremap [fzf]a :Ag<CR>

" Search a word under cursor about the file type on Dash
:nmap <silent> sd <Plug>DashSearch

" ### Ack {{{
nnoremap <Space>/ :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <Space>\ :Ag

let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack
" }}}

nnoremap [Plugin]    <Nop>
nmap     , [Plugin]

" Rust
let g:rustfmt_autosave = 1
let g:rustfmt_command = expand('~/.cargo/bin/rustfmt')
let g:racer_cmd = expand("~/.cargo/bin/racer")
let g:racer_experimental_completer = 1
let g:rust_doc#open_cmd = 'open'

" OCaml
set rtp+=<SHARE_DIR>/merlin/vim

let g:LanguageClient_serverCommands = {
    \ 'reason': ['/absolute/path/to/reason-language-server.exe'],
    \ }

" enable autocomplete
let g:deoplete#enable_at_startup = 1

" arglist status line
"function! StatuslineArglistIndicator()
"    return '%{argc()>0?("A[".repeat("-",argidx()).(expand("%")==argv(argidx())?"+":"~").repeat("-",argc()-argidx()-1)."]"):""}'
"endfunction

" lightline
"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ 'active': {
"      \   'left': [['mode', 'paste', 'arglist'], ['readonly', 'filename', 'modified']],
"      \   'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype']]
"      \ },
"      \ 'component_function': {
"      \   'arglist': 'StatuslineArglistIndicator'
"      \ },
"      \ }

" }}}


"## Scripts {{{

command! Today r!date +\%Y-\%m-\%d


" ### c0hama流スムースなスクロール {{{
" let s:scroll_time_ms = 100
" let s:scroll_precision = 8
" function! MySmoothScroll(dir, windiv, factor)
"   let cl = &cursorline
"   let cc = &cursorcolumn
"   set nocursorline nocursorcolumn
"   let height = winheight(0) / a:windiv
"   let n = height / s:scroll_precision
"   if n <= 0
"     let n = 1
"   endif
"   let wait_per_one_move_ms = s:scroll_time_ms / s:scroll_precision * a:factor
"   let i = 0
"   let scroll_command = a:dir == "down" ?
"     \ "normal! " . n . "\<C-e>" . n . "j" :
"     \ "normal! " . n . "\<C-y>" . n . "k"
"   while i < s:scroll_precision
"     let i = i + 1
"     execute scroll_command
"     execute "sleep " . wait_per_one_move_ms . "m"
"     redraw
"   endwhile
"   let &cursorline = cl
"   let &cursorcolumn = cc
" endfunction
"noremap <silent> <C-d> :call MySmoothScroll("down", 2, 1)<CR>
"noremap <silent> <C-u> :call MySmoothScroll("up", 2, 1)<CR>
"noremap <silent> <C-j> :call MySmoothScroll("down", 1, 2)<CR>
"noremap <silent> <C-k> :call MySmoothScroll("up", 1, 2)<CR>

" 指定のデータをレジスタに登録する
function! s:Clip(data)
  let @*=a:data
  echo "clipped: " . a:data
endfunction

" 現在開いているファイルのパスをレジスタへ
command! -nargs=0 ClipPath call s:Clip(expand('%'))
" 現在開いているファイルの絶対パスをレジスタへ
command! -nargs=0 ClipFullPath call s:Clip(expand('%:p'))
" 現在開いているファイルのファイル名をレジスタへ
command! -nargs=0 ClipFile call s:Clip(expand('%:t'))
" 現在開いているファイルのディレクトリパスをレジスタへ
command! -nargs=0 ClipDir  call s:Clip(expand('%:p:h'))

" }}}


" ### Dvorak {{{
let g:is_dvorak = 0

function! ToggleDvorakMode()
  if g:is_dvorak
    let g:is_dvorak = 0
    set keymap=
  else
    let g:is_dvorak = 1
    set keymap=dvorak
  endif
endfunction

command! ToggleDovorakMode call ToggleDvorakMode()
" }}}



" }}}

" ファイルタイプ別設定 {{{
autocmd MyAutoCmd FileType c setlocal tabstop=4 tw=0 sw=4 expandtab
autocmd MyAutoCmd FileType cpp setlocal tabstop=4 tw=0 sw=4 expandtab
autocmd MyAutoCmd FileType cs setlocal textwidth=0 tabstop=4 shiftwidth=4 noexpandtab
autocmd MyAutoCmd FileType ruby setlocal tabstop=2 tw=0 sw=2 expandtab
autocmd MyAutoCmd FileType eruby setlocal tabstop=2 tw=0 sw=2 expandtab
autocmd MyAutoCmd BufNewFile,BufRead app/*/*.rhtml setlocal ft=mason fenc=utf-8
autocmd MyAutoCmd BufNewFile,BufRead app/**/*.rb setlocal ft=ruby fenc=utf-8
autocmd MyAutoCmd BufNewFile,BufRead app/**/*.yml setlocal ft=ruby fenc=utf-8
autocmd MyAutoCmd FileType c highlight Comment ctermfg=darkcyan
autocmd MyAutoCmd FileType cpp highlight Comment ctermfg=darkcyan
autocmd MyAutoCmd FileType haskell setlocal tabstop=2 tw=0 sw=2 expandtab
autocmd MyAutoCmd FileType php setlocal tabstop=4 tw=0 sw=4 expandtab
autocmd MyAutoCmd FileType python setlocal tabstop=4 tw=0 shiftwidth=4 expandtab softtabstop=4
autocmd MyAutoCmd FileType python setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd MyAutoCmd FileType python setlocal completeopt-=preview
autocmd MyAutoCmd FileType python :inoremap # #
autocmd MyAutoCmd FileType html setlocal tabstop=2 tw=0 sw=2 expandtab
autocmd MyAutoCmd FileType swift setlocal tabstop=4 tw=0 sw=4 expandtab
autocmd MyAutoCmd BufWritePre *.go GoFmt
autocmd MyAutoCmd FileType go setlocal tabstop=4 tw=0 sw=4 noexpandtab nolist

autocmd MyAutoCmd FileType rust nmap gd <Plug>(rust-def)
autocmd MyAutoCmd FileType rust nmap gs <Plug>(rust-def-split)
autocmd MyAutoCmd FileType rust nmap gx <Plug>(rust-def-vertical)
autocmd MyAutoCmd FileType rust nmap <leader>gd <Plug>(rust-doc)
" }}}

" }}}

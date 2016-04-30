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
set foldmethod=marker

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
set nohidden

" スワップファイルを作らない
set noswapfile

" バックアップを作らない
set nobackup

" 既存のファイルを開くときはとりあえず utf-8
set fileencodings=utf-8,default,ucs-bom,latin1

" Vim を終了しても undo の記録を残す
set undofile undodir=~/.vimundo

" }}}


" ### Appearance {{{

" 色数
set t_Co=256

" 背景色
set background=dark

" コマンドラインの行数
set cmdheight=2

" 現在行の色を変える
set cursorline
let g:cursorline_flg = 1 " cursorline はウィンドウローカルなのでグローバルなフラグを用意しておく
let g:cursorcolumn_flg = 0

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

" 最低でも上下に表示する行数
set scrolloff=5

" 入力したコマンドを画面下に表示
set showcmd

" 自動折り返ししない
set textwidth=0

" タブページのラベルを常に表示
set showtabline=2

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

" }}}


" ### Input {{{

" バックスペースで削除できる文字
set backspace=indent,eol,start

" ヤンクなどで * レジスタにも書き込む
set clipboard& clipboard+=unnamed

" マッピングの受付時間 (<Leader> とか)
set timeout
set timeoutlen=1000

" キーコード待ち時間
set ttimeoutlen=10

" 矩形選択を可能にする
set virtualedit& virtualedit+=block

" 行連結でスペースを入れない
set nojoinspaces

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

" }}}

" }}}


" ## Plugins {{{
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.cache/dein'))

" ### Appearance {{{

" Color Scheme
call dein#add('w0ng/vim-hybrid')
" }}}

call dein#end()

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
" }}}

" ## Color {{{
  autocmd MyAutoCmd ColorScheme * highlight Search term=reverse ctermfg=black ctermbg=106
  autocmd MyAutoCmd ColorScheme * highlight clear CursorLine
  autocmd MyAutoCmd ColorScheme * highlight CursorLine cterm=None ctermbg=233
  autocmd MyAutoCmd ColorScheme * highlight CursorLine gui=None guibg=DarkBlue
  autocmd MyAutoCmd ColorScheme * highlight LineNr ctermfg=241 ctermbg=none guifg=Yellow
  autocmd MyAutoCmd ColorScheme * highlight Normal ctermfg=250 ctermbg=none
  colorscheme hybrid
  syntax on
" }}}



" ## Settings and keymaps {{{

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

" ページ送り
noremap <C-f> <C-e>
noremap <C-b> <C-y>

" ウィンドウ移動
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

" タブページ間の移動
nnoremap <silent> <C-h> :tabprevious<CR>
nnoremap <silent> <C-l> :tabnext<CR>
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

" 貼り付けたテキストを素早く選択する
noremap gV `[v`]

" コマンドラインウィンドウ暴発防止
map q: :q

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
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-d> <Del>

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

" }}}


"## Scripts {{{

" ### c0hama流スムースなスクロール {{{
let s:scroll_time_ms = 100
let s:scroll_precision = 8
function! MySmoothScroll(dir, windiv, factor)
  let cl = &cursorline
  let cc = &cursorcolumn
  set nocursorline nocursorcolumn
  let height = winheight(0) / a:windiv
  let n = height / s:scroll_precision
  if n <= 0
    let n = 1
  endif
  let wait_per_one_move_ms = s:scroll_time_ms / s:scroll_precision * a:factor
  let i = 0
  let scroll_command = a:dir == "down" ?
    \ "normal! " . n . "\<C-e>" . n . "j" :
    \ "normal! " . n . "\<C-y>" . n . "k"
  while i < s:scroll_precision
    let i = i + 1
    execute scroll_command
    execute "sleep " . wait_per_one_move_ms . "m"
    redraw
  endwhile
  let &cursorline = cl
  let &cursorcolumn = cc
endfunction
noremap <silent> <C-d> :call MySmoothScroll("down", 2, 1)<CR>
noremap <silent> <C-u> :call MySmoothScroll("up", 2, 1)<CR>
noremap <silent> <C-j> :call MySmoothScroll("down", 1, 2)<CR>
noremap <silent> <C-k> :call MySmoothScroll("up", 1, 2)<CR>
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
autocmd MyAutoCmd FileType go setlocal tabstop=4 tw=0 sw=4 noexpandtab
autocmd MyAutoCmd FileType swift setlocal tabstop=4 tw=0 sw=4 expandtab
autocmd MyAutoCmd BufWritePre *.go Fmt
" }}}

" }}}

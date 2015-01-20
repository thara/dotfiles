"-------------------------------------------------------------------------------
" Plugin Bundles
"-------------------------------------------------------------------------------
filetype off

if has('vim_starting')
  execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
  set runtimepath+=$GOROOT/misc/vim
  exe "set runtimepath+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
endif
call neobundle#rc(expand('~/.vim/bundle'))

if !exists('loaded_matchit')
  " matchitを有効化
  runtime macros/matchit.vim
endif

" NeoBundle
NeoBundle 'Shougo/neobundle.vim'
" タグページごとにカレントディレクトリを設定
NeoBundle 'kana/vim-tabpagecd'
" 構文チェック
NeoBundle 'scrooloose/syntastic'
" Finder
NeoBundle 'kien/ctrlp.vim'

NeoBundle 'thinca/vim-quickrun.git'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'vim-jp/vimdoc-ja'
" インデント可視化
NeoBundle 'Yggdroot/indentLine'
let g:indentLine_color_term=239
NeoBundle 'derekwyatt/vim-scala'
" NERDTree
NeoBundle 'scrooloose/nerdtree'

NeoBundle 'groenewege/vim-less'
NeoBundle 'cohama/vim-insert-linenr'
NeoBundle 'cohama/vim-smartinput-endwise'
call smartinput_endwise#define_default_rules()
NeoBundle 'rizzatti/funcoo.vim'
NeoBundle 'rizzatti/dash.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'rhysd/clever-f.vim'

" ColorScheme{{{{
" Hybrid ColorScheme
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'tomasr/molokai'
NeoBundle 'desert256.vim'
" }}}

" Unite
NeoBundle 'Shougo/unite.vim'
" カラースキーム一覧表示
NeoBundle 'ujihisa/unite-colorscheme'

" VimProc
NeoBundle 'Shougo/vimproc', {
\ 'build': {
\ 'windows': 'make -f make_mingw32.mak',
\ 'cygwin': 'make -f make_cygwin.mak',
\ 'mac': 'make -f make_mac.mak',
\ 'unix': 'make -f make_unix.mak',
\ }
\}
" VimShell
NeoBundle 'Shougo/vimshell'
let g:vimshell_interactive_update_time = 10
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'

" 補完
NeoBundle 'Shougo/neocomplete'
" スニペット補完プラグイン
NeoBundle 'Shougo/neosnippet'
" 各種スニペット
NeoBundle 'Shougo/neosnippet-snippets'

" テキストオブジェクト拡張
NeoBundle 'kana/vim-textobj-user'
" 全体をテキストオブジェクト化
NeoBundle 'kana/vim-textobj-entire'
" Rubyのブロックをテキストオブジェクト化
NeoBundle 'rhysd/vim-textobj-ruby'
" Exuberant ctags
NeoBundle 'majutsushi/tagbar', {
      \ "autload": {
      \   "commands": ["TagbarToggle"],
      \ },
      \ "build": {
      \   "mac": "brew install ctags",
      \ }}
let g:tagbar_width=50
" nmap <Leader>t :TagbarToggle<CR>

" ### 編集系 ### {{{
" コメント化
NeoBundle 'tpope/vim-commentary'

" 整形 (Vim Align them all)
NeoBundleLazy 'h1mesuke/vim-alignta', {
\ 'autoload' : {
\   'commands' : ['Alignta', 'Align']
\ }}

" ヤンク履歴
NeoBundle 'LeafCage/yankround.vim'
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

" }}}


" Markdown
NeoBundle 'plasticboy/vim-markdown.git'
let g:vim_markdown_folding_disabled=1

NeoBundle 'itchyny/lightline.vim'

" 独自モードを作成
NeoBundle 'thinca/vim-submode'

" for Dart
NeoBundle 'dart-lang/dart-vim-plugin.git'
" for JavaScript
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
" for Handlerbars
NeoBundle 'nono/vim-handlebars'
" for Jade
NeoBundle 'digitaltoad/vim-jade'

" Zen-Coding
NeoBundleLazy 'mattn/emmet-vim', {
\ 'autoload' : {
\   'filetypes' : ['html', 'eruby', 'jsp', 'xml'],
\   'commands' : ['<Plug>ZenCodingExpandNormal']
\ }}

let g:user_emmet_mode = 'iv'
let g:user_emmet_leader_key = '<C-Y>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
      \ 'lang' : 'ja',
      \ 'html' : {
      \   'filters' : 'html',
      \ },
      \ 'css' : {
      \   'filters' : 'fc',
      \ },
      \ 'php' : {
      \   'extends' : 'html',
      \   'filters' : 'html',
      \ },
      \}
" for CSS3
NeoBundle 'hail2u/vim-css3-syntax'
" for HTML5
NeoBundle 'othree/html5.vim'

" for AngularJS
NeoBundle 'burnettk/vim-angular'

" for Ruby
NeoBundleLazy 'vim-ruby/vim-ruby', {
\ 'autoload': {
\   'filetypes' : ['ruby', 'eruby']
\ }}
NeoBundle 'slim-template/vim-slim'
NeoBundle 'cakebaker/scss-syntax.vim'
" for CoffeeScript
NeoBundle 'kchmck/vim-coffee-script'

" for Python
NeoBundle 'vim-scripts/django.vim'
NeoBundle 'Glench/Vim-Jinja2-Syntax'

" for Golang
NeoBundle 'Blackrush/vim-gocode'

" for Swift
NeoBundle 'toyamarinyon/vim-swift'

" tagbar
" NeoBundle 'vim-scripts/tagbar'
" NeoBundle 'vim-scripts/tagbar-phpctags', {
"   \   'build' : {
"   \     'others' : 'chmod +x bin/phpctags',
"   \   },
"   \ }

" Gist
NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
let g:gist_show_privates = 1 " 一覧でPrivateを表示
let g:gist_post_private = 1  " Privateで投稿

" todo.txt
NeoBundle 'freitass/todo.txt-vim'

" URLからブラウザを開く
NeoBundle 'tyru/open-browser.vim'
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" Calendar
NeoBundle 'itchyny/calendar.vim'
let g:calendar_google_calendar = 1

NeoBundle 'xolox/vim-notes'
NeoBundle 'xolox/vim-misc'
let g:notes_directories = ['~/Dropbox/Notes']

filetype plugin indent on
NeoBundleCheck

augroup MyAutoCmd
    autocmd!
augroup END
let g:quickrun_config = {}
let g:quickrun_config.mkd = {'outputter' : 'null', 'command' : 'open', 'cmdopt' : '-a', 'args' : 'Marked', 'exec' : '%c %o %a %s',}

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" submode.vim {{{
"   ウィンドウリサイズモード
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
"   タブ移動モード
function! s:SIDP()
  return '<SNR>' . matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SIDP$') . '_'
endfunction
function! s:modulo(n, m)
  let d = a:n * a:m < 0 ? 1 : 0
  return a:n + (-(a:n + (0 < a:m ? d : -d)) / a:m + d) * a:m
endfunction
function! s:movetab(nr)
  execute 'tabmove' s:modulo(tabpagenr() + a:nr - 1, tabpagenr('$'))
endfunction
let s:movetab = ':<C-u>call ' . s:SIDP() . 'movetab(%d)<CR>'
call submode#enter_with('tabmove', 'n', '', '<Space>gt', printf(s:movetab, 1))
call submode#enter_with('tabmove', 'n', '', '<Space>gT', printf(s:movetab, -1))
call submode#map('tabmove', 'n', '', 'h', printf(s:movetab, -1))
call submode#map('tabmove', 'n', '', 'l', printf(s:movetab, 1))
" }}}

" CD  : カレントディレクトリを変更する
" CD! : 移動先のディレクトリを表示する
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>') 
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

if !has('gui_running') && !(has('win32') || has('win64'))
    " .vimrcの再読込時にも色が変化するようにする
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
    " .vimrcの再読込時にも色が変化するようにする
    autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC | if has('gui_running') | source $MYGVIMRC
    autocmd MyAutoCmd BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
endif

"-------------------------------------------------------------------------------
" 基本設定 Basics
"-------------------------------------------------------------------------------
set scrolloff=5                  " スクロール時の余白確保
set nobackup                     " バックアップ取らない
set autoread                     " 他で書き換えられたら自動で読み直す
set noswapfile                   " スワップファイル作らない
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                     " ビープをならさない
set showmode                     " 現在のモードを表示
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
set modelines=0                  " モードラインは無効

"set iminsert=0
"set imsearch=0
set imdisable
set iminsert=1
set imsearch=1

" OSのクリップボードを使用する
set clipboard& clipboard+=unnamed

" マッピングの待ち時間
set timeout
set timeoutlen=1000
" キーコード待ち時間
set ttimeoutlen=50

" 新しい行のインデントを現在行と同じに
set autoindent
" 高度なインデント
set smartindent
" 画面上でタブ文字が対応する幅
set tabstop=2
" Tabで動くカーソルの幅
set softtabstop=2
" インデントでずれる幅
set shiftwidth=2
" Tabの代わりにSpaceを挿入
set expandtab
" 行頭の余白内でのTabがshiftwidth分になる
set smarttab

set helplang=ja

set nojoinspaces

" 自動改行禁止
set tw=0

set undodir=/tmp/vim/

"-------------------------------------------------------------------------------
" 表示 Apperance
"-------------------------------------------------------------------------------
set t_Co=256

set showmatch         " 括弧の対応をハイライト
set number relativenumber " 行番号表示
set list              " 不可視文字表示
set listchars=tab:>.,trail:_,extends:>,precedes:< " 不可視文字の表示形式
set display=uhex      " 印字不可能文字を16進数で表示

set ruler " ルーラー
set title " タイトル
set showmatch "閉じ括弧入力時に対応する開き括弧にジャンプ
set showcmd "コマンド表示
set cmdheight=2
set laststatus=2 "ステータス行を常時表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}

" 行を折り返さない
set nowrap
set scrolloff=5

" Folding
set foldcolumn=1
set foldmethod=marker

set breakindent

" カーソル行
set cursorline

autocmd MyAutoCmd ColorScheme * highlight Search term=reverse ctermfg=black ctermbg=106

autocmd MyAutoCmd WinLeave * set nocursorline
autocmd MyAutoCmd WinEnter,BufRead * set cursorline
autocmd MyAutoCmd ColorScheme * highlight clear CursorLine
autocmd MyAutoCmd ColorScheme * highlight CursorLine cterm=None ctermbg=233
autocmd MyAutoCmd ColorScheme * highlight CursorLine gui=None guibg=DarkBlue

autocmd MyAutoCmd ColorScheme * highlight LineNr ctermfg=241 ctermbg=none guifg=Yellow
autocmd MyAutoCmd ColorScheme * highlight Normal ctermfg=250 ctermbg=none

" vimgrep時に同時にquickfix-windowを開く
autocmd MyAutoCmd QuickFixCmdPost *grep* cwindow

" ファイルタイプ
autocmd MyAutoCmd FileType c setlocal tabstop=4 tw=0 sw=4 expandtab
autocmd MyAutoCmd FileType cpp setlocal tabstop=4 tw=0 sw=4 expandtab
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
autocmd MyAutoCmd FileType python :inoremap # X#
autocmd MyAutoCmd FileType html setlocal tabstop=2 tw=0 sw=2 expandtab
autocmd MyAutoCmd FileType go setlocal tabstop=4 tw=0 sw=4 noexpandtab
autocmd MyAutoCmd FileType swift setlocal tabstop=4 tw=0 sw=4 expandtab
autocmd MyAutoCmd BufWritePre *.go Fmt

set showtabline=1

"Completion {{{
set completeopt=menu,preview

"------------------------------------
" neocomplete.vim
"------------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" }}}


" スニペット展開
imap <C-s> <Plug>(neosnippet_expand_or_jump)
smap <C-s> <Plug>(neosnippet_expand_or_jump)

colorscheme hybrid
syntax on

"-------------------------------------------------------------------------------
" エンコーディング関連 Encoding
"-------------------------------------------------------------------------------
set ffs=unix,dos,mac  " 改行文字
set encoding=utf-8    " デフォルトエンコーディング

"------------------------------------------------------------------------------
" キーマップ Key mappings
"-------------------------------------------------------------------------------
"Escの2回押しでハイライト消去
noremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
noremap ; :
noremap : ;

" 検索結果マッチ時にカーソル位置を画面中央に
nnoremap n nzzzv
nnoremap N Nzzzv

nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

if has('gui_macvim')
  map ¥ <leader>
endif

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>

nnoremap <silent> <Space>ev  :<C-u>tabedit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>tabedit $MYGVIMRC<CR>
" Load .gvimrc after .vimrc edited at GVim.
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
nnoremap <silent> <Space>rg :<C-u>source $MYGVIMRC<CR>

nnoremap <silent> <Space>et :<C-u>tabedit  ~/Dropbox/work/todo/todo.txt<CR>
nnoremap <silent> <Space>ec :<C-u>tabedit  ~/Dropbox/work/changelog<CR>

" Unite
nnoremap [unite]    <Nop>
nmap     <Space>u [unite]
nnoremap <silent> [unite]f :<C-u>Unite file<CR>
nnoremap <silent> [unite]r :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]m :<C-u>Unite bookmark<CR>

" VimShell
nnoremap [vimshell]    <Nop>
nmap     <Space>v [vimshell]
nnoremap <silent> [vimshell]s :<C-u>VimShell<CR>
nnoremap <silent> [vimshell]c :<C-u>VimShellCreate<CR>
nnoremap <silent> [vimshell]t :<C-u>VimShellTab<CR>
nnoremap <silent> [vimshell]p :<C-u>VimShellPop<CR>


" ページ送り
" Scroll
noremap <C-f> <C-e>
noremap <C-b> <C-y>

" c0hama smooth scroll
let s:scroll_time_ms = 50
let s:scroll_precision = 8
function! TomochikaSmoothScroll(dir, windiv, factor)
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
noremap <silent> <C-d> :call TomochikaSmoothScroll("down", 2, 1)<CR>
noremap <silent> <C-u> :call TomochikaSmoothScroll("up", 2, 1)<CR>
noremap <silent> <Space>j :call TomochikaSmoothScroll("down", 1, 2)<CR>
noremap <silent> <Space>k :call TomochikaSmoothScroll("up", 1, 2)<CR>

" 行末までヤンクする
nnoremap Y y$
" 行末まで選択
vnoremap v $h

" 引数リスト移動
"nnoremap <silent> <C-l> :<C-u>next<CR>:<C-u>args<CR>
"nnoremap <silent> <C-h> :<C-u>prev<CR>:<C-u>args<CR>
"nnoremap <C-j> :<C-u>argadd %<CR>:<C-u>args<CR>
"nnoremap <C-k> :<C-u>argdelete %<CR>:<C-u>args<CR>
"nnoremap <ESC>d :<C-u>argdelete *<CR>:<C-u>args<CR>

" ウィンドウ移動
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

" タブ移動
nnoremap <silent> <C-h> :tabprevious<CR>
nnoremap <silent> <C-l> :tabnext<CR>
" nnoremap <silent> <ESC>n :tabnew<CR>
" nnoremap <silent> <ESC>c :tabclose<CR>
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [T :tabfirst<CR>
nnoremap <silent> ]T :tablast<CR>

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

" NERD Tree 設定
nnoremap <silent> <C-e> :NERDTreeToggle<CR>
nnoremap <silent> <C-@> :NERDTreeFind<CR>
" let g:NERDTreeShowBookmarks = 1
" let g:NERDTreeMapJumpNextSibling = '<C-n>'
" let g:NERDTreeMapJumpPrevSibling = '<C-p>'
let NERDTreeIgnore=[
\ 'vendor', '.bundle', '.sass-cache', 'node_modules', 'bower_components',
\ '.git', '.*\.lock', '__pycache__', '.*.egg-info', '.idea', '.*\.pyc', '.DS_Store', '.tmp']

" ctrlp
let g:ctrlp_map = '<Nop>'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:18'

let g:ctrlp_use_migemo = 1
let g:ctrlp_clear_cache_on_exit = 0   " 終了時キャッシュをクリアしない
let g:ctrlp_mruf_max            = 500 " MRUの最大記録数
let g:ctrlp_open_new_file       = 1   " 新規ファイル作成時にタブで開く

nnoremap [ctrlp] <Nop>
nmap     s [ctrlp]
nnoremap sp :<C-u>CtrlP<Space>
nnoremap sb :<C-u>CtrlPBuffer<CR>
nnoremap sh :<C-u>CtrlPMRUFiles<CR>
nnoremap sl :<C-u>CtrlPLine<CR>
nnoremap sd :<C-u>CtrlPDir<CR>
nnoremap sq :<C-u>CtrlPQuickfix<CR>
nnoremap st :<C-u>CtrlPTag<CR>
nnoremap ss :<C-u>CtrlPMixed<CR>
nnoremap sy :<C-u>CtrlPYankRound<CR>

" tagbar
nnoremap <C-k> :TagbarToggle<CR>

"-------------------------------------------------------------------------------
" Insert Mode
"-------------------------------------------------------------------------------
" インサートモードでも誤爆を防ぐ
inoremap <C-@> <C-[>

" Emacs風
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-d> <Del>

"-------------------------------------------------------------------------------
" コマンドライン CommandLine
"-------------------------------------------------------------------------------
" コマンドライン補完
set wildmenu
" コマンドライン補完方法
set wildmode=longest:full,full
" コマンドライン履歴の保存数
set history=2000

cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

" コマンド履歴のフィルタリングにカーソルキーを使わない
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" アクティブなファイルが含まれているディレクトリを展開
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"-------------------------------------------------------------------------------
" Visual Mode
"-------------------------------------------------------------------------------

" 繰り返しを楽にする
xnoremap . :normal .<CR>
" ヤンクレジスタの値をペースト
xnoremap <silent> <ESC>p "0p

"-------------------------------------------------------------------------------
" 検索設定 Search
"-------------------------------------------------------------------------------
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト

if has ("migemo")
  set migemo
endif

set formatoptions& formatoptions+=mM
let format_join_spaces = 2
let format_allow_over_tw = 1

" changelog
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "Tomochika Hara"
let g:changelog_spacing_errors = 0

" Kobitoを開く
function! s:open_kobito(...)
    if a:0 == 0
        call system('open -a Kobito '.expand('%:p'))
    else
        call system('open -a Kobito '.join(a:000, ' '))
    endif
endfunction

" 引数のファイル(複数指定可)を Kobitoで開く
" （引数無しのときはカレントバッファを開く
command! -nargs=* Kobito call s:open_kobito(<f-args>)
" Kobito を閉じる
command! -nargs=0 KobitoClose call system("osascript -e 'tell application \"Kobito\" to quit'")
" Kobito にフォーカスを移す
command! -nargs=0 KobitoFocus call system("osascript -e 'tell application \"Kobito\" to activate'")

" Netrw
let g:netrw_altv = 1
let g:netrw_winsize=70

" 隠しファイルを表示する
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize=35

" Magic comment
function! AddMagicComment()
  let magic_comment = "# -*- coding: utf-8 -*-\n"
  let pos = getpos(".")
  call cursor(1,0)
  execute ":normal i" . magic_comment
  call setpos(".", pos)
endfunction

noremap <silent> <F12> :call AddMagicComment()<CR><ESC>

" タブページのラベル http://d.hatena.ne.jp/thinca/20111204/1322932585
" thx thinca!
function! s:tabpage_label(n)
  " n 番目のタブのラベルを返す
  let title = gettabvar(a:n, 'title')
  if title !=# ''
    return title
  endif

  " タブページ内のバッファのリスト
  let bufnrs = tabpagebuflist(a:n)

  " カレントタブページかどうかでハイライトを切り替える
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  " バッファが複数あったらバッファ数を表示
  let no = len(bufnrs)
  if no is 1
    let no = ''
  endif
  " タブページ内に変更ありのバッファがあったら '+' を付ける
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let sp = (no . mod) ==# '' ? '' : ' '  " 隙間空ける

  " カレントバッファ
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() は 1 origin
  let fname = pathshorten(bufname(curbufnr))

  let label = no . mod . sp . fname
  return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfunction

function! MakeTabLine()
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ' | '  " タブ間の区切り
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'

  " カレントディレクトリ
  let info = fnamemodify(getcwd(), ":~") . ' '

  return tabpages . '%=' . info  " タブリストを左に、情報を右に表示
endfunction

"set tabline=%!MakeTabLine()

"--- <F6>  タイムスタンプを挿入してinsertモードへ移行 ----
function! AddTimeStamp()
  let current_locale = v:lc_time
  language time en_US
  let now = strftime("%a, %d %b %Y %H:%M:%S %z")
  execute 'language time '. current_locale
  execute ":normal i" . now
endfunction

noremap <silent> <F6> :call AddTimeStamp()<CR><ESC>
" noremap <silent> <F12> :call AddMagicComment()<CR><ESC>

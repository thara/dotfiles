augroup MyAutoCmd
    autocmd!
augroup END

scriptencoding utf-8

" Options{{{1
" Indent {{{
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
if exists('+breakindent')
  set breakindent
endif
"}}}
" Folding {{{
set foldmethod=marker
set foldcolumn=1
set foldlevel=0
"}}}
" Search{{{
set hlsearch
"nohlsearch
set ignorecase
set incsearch
set smartcase
"}}}
" Buffer{{{
set autoread
set hidden
set noswapfile
set nobackup
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp
set undofile undodir=~/.vimundo
"}}}
" Appearance{{{
filetype plugin indent on
syntax on

if !has('gui_running')
  set t_Co=256
endif
set background=dark
set cmdheight=1
set nocursorline
set ruler
set laststatus=2
set lazyredraw
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<
set number relativenumber
set scrolloff=5
set showcmd
" 自動折り返ししない
set textwidth=0
set showtabline=1
set display=lastline,uhex
set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-,diff:-
set synmaxcol=150
set signcolumn=yes

set completeopt-=preview
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}

let g:vim_indent_cont = 0

"let g:hybrid_custom_term_colors = 1
"let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
"}}}
" Input{{{
set backspace=indent,eol,start
set clipboard& clipboard+=unnamed
set timeout timeoutlen=3000 ttimeoutlen=10
set virtualedit& virtualedit+=block
set nojoinspaces
set dictionary=/usr/share/dict/words
if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif
"}}}
" Command{{{
set wildmenu
set wildmode=longest:full,full
set history=5000
"}}}
" Misc{{{
set nrformats-=octal
set whichwrap&
set whichwrap+=h,l
set nowrap
set helplang=ja
set keywordprg=:help"
set updatetime=1000
set nostartofline
set ffs=unix,dos,mac
set encoding=utf-8
set undodir=/tmp/vim/
set viminfo='50,<1000,s100,\"50
set splitright
" changelog設定
let g:changelog_dateformat = "%Y-%m-%d"
let g:changelog_username = "thara"
" エントリの下に空行を入れておくと新アイテム行が一番下になる
let g:changelog_new_date_format = "%d  %u\n\n  * %p %c\n\n\n"
let g:changelog_new_entry_format = "  *  %c"
" changelogグローバルマッピング自動設定
autocmd MyAutoCmd BufEnter * runtime ftplugin/changelog.vim
"}}}
"}}}1

" Key mapping{{{

"if has("mac")
"  " option(alt)キーをMetaキー扱いにする
"  set macmeta
"  map <ESC>h <M-h>
"  map <ESC>l <M-l>
"endif

noremap ; :
noremap : ;
" Escの2回押しでハイライト消去
noremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
" 検索結果マッチ時にカーソル位置を画面中央に
nnoremap n nzzzv
nnoremap N Nzzzv
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
" Ex-Mode 無効
nnoremap Q <Nop>
" ウィンドウ移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" 一つ前に開いたファイルを開く
nnoremap <Space><Space> <C-^>
" 引数リスト
"nnoremap <Space><Space> :args<CR>
"nnoremap <Space>l :arglocal<CR>
"nnoremap <Space>j :argadd % <Bar> next <CR>
"nnoremap <Space>e :argedit %<CR>
"nnoremap <Space>k :<C-R>=argidx()+1<CR>argdelete<CR>
" 新規ローカル引数リストを作る
"'nnoremap <Space>s :arglocal! %<CR>
" 引数リスト内の現在指しているファイルに戻る
"nnoremap <Space>c :argument<CR>
"nnoremap <Space>f :first<CR>
"nnoremap <Space>t :last<CR>
"nnoremap <silent> <C-h> :previous<CR>
"nnoremap <silent> <C-l> :next<CR>
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
let g:maplocalleader = "\<Space>"
" .vimrcを開く
nnoremap <silent> <Leader>ev  :<C-u>tabedit $MYVIMRC<CR>
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
"nnoremap <silent> <C-X>0 :only<CR>
"nnoremap <silent> <C-x>2 :sp<CR>
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

nnoremap <Leader>cd :cd %:h<CR>:pwd<CR>

" Go to index of notes
nnoremap <Leader>o :e $NOTES_DIR/inbox.md<CR>
nnoremap <Leader>ni :e $NOTES_DIR/index.md<CR>cd $NOTES_DIR<CR>
" Run ctags
nnoremap <Leader>tt :silent !ctags -R . <CR>:redraw!<CR>
"}}}

" Plugin{{{1
call plug#begin('~/.vim/plugged')

Plug 'vim-jp/vimdoc-ja'

" Appearance{{{
" Color Scheme
Plug 'pbrisbin/vim-colors-off'
" Coolなステータスライン
Plug 'itchyny/lightline.vim'
" インサートモード時に行番号の色を反転
Plug 'cohama/vim-insert-linenr'
"}}}
" Navigation{{{
" Minimalist path navigator
Plug 'justinmk/vim-dirvish'
" Fuzzy Finder (ctrlp alternative)
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
"}}}
" Input{{{
" 賢い入力補助
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
" easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'
" Emoji
Plug 'junegunn/vim-emoji'
" extends f, F, t and T mappings for more convenience
Plug 'rhysd/clever-f.vim'
"}}}
" Language{{{
Plug 'keith/swift.vim', { 'for': ['swift'] }
" let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
"Plug 'derekwyatt/vim-scala', { 'for': ['scala'] }
Plug 'mattn/vim-goimports'
Plug 'elixir-editors/vim-elixir', { 'for': ['ex', 'exs', 'eex', 'leex'] }
" Rust
Plug 'rust-lang/rust.vim', { 'for': ['rust']}
Plug 'racer-rust/vim-racer', { 'for': ['rust']}
Plug 'rhysd/rust-doc.vim', { 'for': ['rust']}

Plug 'leafgarland/typescript-vim', { 'for': ['typescript']}
" [Python] 関数とクラスをテキストオブジェクト化 + motion追加
Plug 'bps/vim-textobj-python', { 'for': ['python']}
" [Ruby] ブロックをテキストオブジェクト化
"Plug 'rhysd/vim-textobj-ruby', { 'for': ['ruby']}
" [Ruby] end キーワードの自動挿入
Plug 'tpope/vim-endwise'
Plug 'elzr/vim-json', { 'for': ['json']}

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
"}}}
" Misc{{{
" Auto change directory to project root directory of the file
Plug 'mattn/vim-findroot'
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

" View and search LSP symbols, tags in Vim/NeoVim
Plug 'liuchengxu/vista.vim'

" ヤンク履歴
"Plug 'LeafCage/yankround.vim'

" Cheat Sheet
Plug 'reireias/vim-cheatsheet'

" Plug 'davidoc/taskpaper.vim'
" let g:task_paper_date_format = "%Y-%m-%d %H:%M:%S"

" Plug 'vim-scripts/todo-txt.vim'
" Plug 'jkramer/vim-checkbox'

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
" Google Translate
Plug 'skanehira/translate.vim'
"}}}

call plug#end()
"}}}1

" Plugin Settings{{{1
nnoremap [Plugin]    <Nop>
nmap     , [Plugin]

" dirvish{{{
let g:dirvish_mode = ':sort r /[^\/]$/'
"nnoremap <silent> <C-e> :Dirvish<CR>
" hidden files
"autocmd MyAutoCmd FileType dirvish keeppatterns g@\v/(\.|__)[^\/]+/?$@d
augroup my_dirvish_events
  autocmd!
  " Map t to "open in new tab".
  autocmd FileType dirvish
    \  nnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>
    \ |xnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>
  " Map CTRL-R to reload the Dirvish buffer.
  autocmd FileType dirvish nnoremap <buffer> <C-R> :<C-U>Dirvish %<CR>
  " Map `gh` to hide dot-prefixed files.
  " To "toggle" this, just press `R` to reload.
  autocmd FileType dirvish nnoremap <buffer> gh :keeppatterns g@\v/(\.\|__)[^\/]+/?$@d<cr>
augroup END

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
"}}}
" fzf{{{
nnoremap [fzf] <Nop>
nmap s [fzf]
" https://github.com/junegunn/fzf.vim#commands
nnoremap [fzf]h :History<CR>
nnoremap [fzf]a :Rg<CR>
nnoremap [fzf]f :Files<CR>
nnoremap [fzf]b :Buffers<CR>
nnoremap [fzf]t :Tags<CR>
nnoremap [fzf]v :Vista finder vim_lsp<CR>
nnoremap [fzf]m :Marks<CR>
"nnoremap [fzf]ln :Lines<CR>
nnoremap [fzf]l :BLines<CR>
nnoremap [fzf]s :GFiles?<CR>
nnoremap [fzf]gc :Commits<CR>
nnoremap [fzf]gb :BCommits<CR>
nnoremap [fzf]c :History:<CR>
nnoremap [fzf]w :Windows<CR>
"}}}
" Color Scheme{{{
autocmd MyAutoCmd ColorScheme * highlight Search term=reverse ctermfg=black ctermbg=106
autocmd MyAutoCmd ColorScheme * highlight clear CursorLine
autocmd MyAutoCmd ColorScheme * highlight CursorLine cterm=None ctermbg=233 gui=None guibg=DarkBlue
autocmd MyAutoCmd ColorScheme * highlight LineNr ctermfg=241 ctermbg=none guifg=Yellow
autocmd MyAutoCmd ColorScheme * highlight Normal ctermfg=250 ctermbg=none
autocmd MyAutoCmd ColorScheme * highlight SpecialComment ctermfg=8
colorscheme off
"}}}
" vim-lsp{{{
let g:lsp_settings_servers_dir = expand("~/.vim/vim-lsp-servers")

let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_highlights_enabled = 1
let g:lsp_textprop_enabled = 1
let g:lsp_virtual_text_enabled = 0
let g:lsp_signature_help_enabled = 0
" let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/vim-lsp.log')
"let g:lsp_settings = {
"\  'solargraph': {'whitelist': []}
"\}
nnoremap <silent> gd :<C-u>LspDefinition<CR>
nnoremap <silent> gD :<C-u>LspDeclaration<CR>
nnoremap <silent> gr :<C-u>LspReferences<CR>
nnoremap <silent> gs :<C-u>LspDocumentSymbol<CR>
nnoremap <silent> gS :<C-u>LspWorkspaceSymbol<CR>
nnoremap <silent> gQ :<C-u>LspDocumentFormat<CR>
vnoremap <silent> gQ :LspDocumentRangeFormat<CR>
nnoremap <silent> gh :<C-u>LspHover<CR>
nnoremap <silent> gp :<C-u>LspImplementation<CR>
noremap <silent> gR :<C-u>LspRename<CR>
"nnoremap <silent> gh  :<C-u>LspDocumentDiagnostics<CR>
nnoremap <silent> ]e  :<C-u>LspNextError<CR>
nnoremap <silent> [e  :<C-u>LspPreviousError<CR>

let g:asyncomplete_auto_popup = 0

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"}}}
" Rust{{{
let g:rustfmt_autosave = 1
let g:rustfmt_command = expand('~/.cargo/bin/rustfmt')
let g:racer_cmd = expand("~/.cargo/bin/racer")
let g:racer_experimental_completer = 1
let g:rust_doc#open_cmd = 'open'
"}}}
" fugitive{{{
nnoremap <silent> <Leader>gs  :<C-u>Gstatus<CR>
nnoremap <silent> <Leader>gc  :<C-u>Gcommit<CR>
nnoremap <silent> <Leader>gd  :<C-u>Gdiff<CR>
nnoremap <silent> <Leader>gb  :<C-u>Gblame<CR>
nnoremap <silent> <Leader>gw  :<C-u>Gbrowse<CR>
"}}}
" lightline{{{
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
"}}}
" Submode{{{
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
"}}}
" Misc{{{
let g:vim_json_syntax_conceal = 0
" the path to python3 is obtained through executing `:echo exepath('python3')` in vim
let g:python3_host_prog = "/usr/local/bin/python3"
" cheatsheet
let g:cheatsheet#cheat_file = '~/Dropbox/Work/cheatsheet.md'
let g:cheatsheet#vsplit = 1
" Search a word under cursor about the file type on Dash
nmap <silent> sd <Plug>DashSearch

" f matchs Japanese characters by roman
let g:clever_f_across_no_line = 1
let g:clever_f_use_migemo = 1

let g:findroot_patterns = [
\  '.git/',
\  '.svn/',
\  '.hg/',
\  '.bzr/',
\  'Rakefile',
\  'pom.xml',
\  'project.clj',
\  '*.csproj',
\  '*.sln',
\]

let g:vista#renderer#enable_icon = 0

set completefunc=emoji#complete
"}}}
"}}}1

" Misc{{{

" Use ripgrep by default
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

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
" }}}
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
autocmd MyAutoCmd BufNewFile,BufRead *.swift setfiletype swift
autocmd MyAutoCmd FileType swift setlocal tabstop=4 tw=0 sw=4 expandtab
autocmd MyAutoCmd BufWritePre *.go GoFmt
autocmd MyAutoCmd FileType go setlocal tabstop=4 tw=0 sw=4 noexpandtab nolist

autocmd MyAutoCmd FileType rust nmap gd <Plug>(rust-def)
autocmd MyAutoCmd FileType rust nmap gs <Plug>(rust-def-split)
autocmd MyAutoCmd FileType rust nmap gx <Plug>(rust-def-vertical)
autocmd MyAutoCmd FileType rust nmap <leader>gd <Plug>(rust-doc)

autocmd MyAutoCmd FileType markdown nnoremap <buffer> T :call checkbox#ToggleCB()<CR>
autocmd MyAutoCmd FileType markdown setlocal wrap syntax=off
autocmd FileType vim setlocal foldmethod=marker
" }}}
"}}}

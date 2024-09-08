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
set number

autocmd MyAutoCmd BufEnter,FocusGained,InsertLeave * set relativenumber
autocmd MyAutoCmd BufLeave,FocusLost,InsertEnter * set number norelativenumber

set scrolloff=5
set showcmd
" 自動折り返ししない
set textwidth=0
set showtabline=1
set display=lastline,uhex
set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-,diff:-
set synmaxcol=300
set signcolumn=yes
set ambiwidth=double
set formatoptions+=mM

let g:vim_indent_cont = 0
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
set nrformats+=unsigned
"}}}
" Command{{{
set wildmenu
set wildmode=longest:full,full
set history=5000
set isfname+=@-@
"}}}
" Misc{{{
set nrformats-=octal
set whichwrap=b,s
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
set termwinkey=<C-l>
" changelog設定
let g:changelog_dateformat = "%Y-%m-%d"
let g:changelog_username = "thara"
let g:changelog_date_entry_search = "^## %d"
let g:changelog_new_date_format = "## %d\n\n- %p %c\n\n"
" エントリの下に空行を入れておくと新アイテム行が一番下になる
let g:changelog_new_entry_format = "-  %c"
" changelogグローバルマッピング自動設定(どこでもchangelogを開ける)
autocmd MyAutoCmd BufEnter * runtime ftplugin/changelog.vim

if executable('rg')
    let &grepprg = 'rg --vimgrep --hidden'
    set grepformat=%f:%l:%c:%m
endif
"}}}
"}}}1

" Key mapping{{{

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
" 一つ前に開いたファイルを開く
nnoremap <Space><Space> <C-^>
" タブページ間の移動
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [T :tabfirst<CR>
nnoremap <silent> ]T :tablast<CR>
" バッファ移動
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <space>k :bprevious<CR>
nnoremap <space>j :bnext<CR>
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
" s,S でレジスタを汚さない
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
noremap <Space> <Nop>
map <Space> <Leader>
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
inoremap <silent> <C-d> <Del>
" コマンドラインモードでもEmacs風
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
" コマンド履歴のフィルタリングにカーソルキーを使わない
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" オムニ補完
inoremap <C-f> <C-x><C-o>
" ユーザー定義補完
inoremap <C-u> <C-x><C-u>
" 繰り返しを楽にする
xnoremap . :normal .<CR>
" ヤンクレジスタの値をペースト
xnoremap <silent> <Leader>p "0p
"}}}

" Plugin{{{1
call plug#begin('~/.vim/plugged')

Plug 'vim-jp/vimdoc-ja'

" Appearance{{{
" Color Scheme
"Plug 'pbrisbin/vim-colors-off'
Plug 'smypf/vim-colors-off'
" Coolなステータスライン
Plug 'itchyny/lightline.vim'
" インサートモード時に行番号の色を反転
Plug 'cohama/vim-insert-linenr'
" place, toggle and display marks
Plug 'kshenoy/vim-signature'
" Scroll bar for terminal
Plug 'obcat/vim-sclow'
"}}}
" Navigation{{{
" Minimalist path navigator
Plug 'justinmk/vim-dirvish'
" Fuzzy Finder (ctrlp alternative)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" > move between Vim panes and tmux splits seamlessly.
" <C-h> Left
" <C-j> Down
" <C-k> Up
" <C-l> Right
Plug 'christoomey/vim-tmux-navigator'
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
" Stop ]
Plug 'tyru/stoptypofile.vim'
" 一部分だけ別バッファで編集
Plug 'thinca/vim-partedit'
" easily search for, substitute, and abbreviate multiple variants of a word
" crs: snake_case
" crc: camelCase
" cru: UPPER_CASE
Plug 'tpope/vim-abolish'
" Emoji
Plug 'junegunn/vim-emoji'

" clever-fはnot for meなので使わない(意思表示のためにコメントアウトを残しておく)
"Plug 'rhysd/clever-f.vim'

" Code template
Plug 'mattn/vim-sonictemplate'
"}}}
" Language{{{
Plug 'mattn/vim-goimports'

Plug 'elixir-editors/vim-elixir', { 'for': ['ex', 'exs', 'eex', 'leex'] }
" Rust
Plug 'rust-lang/rust.vim', { 'for': ['rust']}
Plug 'rhysd/rust-doc.vim', { 'for': ['rust']}

Plug 'udalov/kotlin-vim', { 'for': ['kotlin'] }
Plug 'jparise/vim-graphql'

Plug 'leafgarland/typescript-vim', { 'for': ['typescript']}

" Ruby: end キーワードの自動挿入
Plug 'tpope/vim-endwise'

Plug 'elzr/vim-json', { 'for': ['json']}

Plug 'axvr/zepl.vim'

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-lsp-icons'

Plug 'hashivim/vim-terraform'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'asciidoc/vim-asciidoc'

Plug 'gleam-lang/gleam.vim'
Plug 'tikhomirov/vim-glsl'

Plug 'onyx-lang/onyx.vim'

Plug 'Nymphium/vim-koka'

"}}}
" Misc{{{
" Auto change directory to project root directory of the file
Plug 'mattn/vim-findroot'

" git関連はterminalでやる
" Git (using by lightline )
"Plug 'tpope/vim-fugitive'
" Add GitHub support to fugitive
" Plug 'tpope/vim-rhubarb'
" Show git diff left
"Plug 'airblade/vim-gitgutter'

" テキストオブジェクト拡張
Plug 'kana/vim-textobj-user'
" 全体をテキストオブジェクト化
Plug 'kana/vim-textobj-entire'
" タグページごとにカレントディレクトリを設定
Plug 'kana/vim-tabpagecd'

" 独自モードを作成
Plug 'thinca/vim-submode'

" Visually select increasingly larger regions of text using the same key combination
Plug 'terryma/vim-expand-region'

" View and search LSP symbols, tags in Vim/NeoVim
Plug 'liuchengxu/vista.vim'
let g:vista_sidebar_width = 50

" Cheat Sheet
Plug 'reireias/vim-cheatsheet'

Plug 'wakatime/vim-wakatime'

" Git commit message
Plug 'rhysd/committia.vim'
" Spell checker
Plug 'kamykn/spelunker.vim'

" Personal Wiki for Vim
Plug 'vimwiki/vimwiki'
"}}}

call plug#end()
"}}}1

" Plugin Settings{{{

" dirvish{{{
let g:dirvish_mode = ':sort ,^\v(.*[\/])|\ze,'
let g:dirvish_relative_paths = 1
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
"}}}
" fzf{{{
nnoremap [fzf] <Nop>
nmap s [fzf]
" https://github.com/junegunn/fzf.vim#commands
nnoremap [fzf]h :History<CR>
nnoremap [fzf]a :RG<CR>
nnoremap [fzf]f :Files<CR>
nnoremap [fzf]s :GFiles?<CR>
nnoremap [fzf]b :Buffers<CR>
"nnoremap [fzf]t :Tags<CR>
nnoremap [fzf]v :Vista finder vim_lsp<CR>
nnoremap [fzf]m :Marks<CR>
"nnoremap [fzf]l :Lines<CR>
"nnoremap [fzf]l :BLines<CR>
"nnoremap [fzf]c :Commits<CR>
"nnoremap [fzf]bc :BCommits<CR>
nnoremap [fzf]w :Windows<CR>

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" https://github.com/junegunn/fzf.vim/issues/714
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Hide status line
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
"}}}
" Color Scheme{{{
"autocmd MyAutoCmd ColorScheme * highlight Search term=reverse ctermfg=black ctermbg=106
"autocmd MyAutoCmd ColorScheme * highlight clear CursorLine
"autocmd MyAutoCmd ColorScheme * highlight LineNr ctermfg=241 ctermbg=none guifg=Yellow
"autocmd MyAutoCmd ColorScheme * highlight Normal ctermfg=250 ctermbg=none
"autocmd MyAutoCmd ColorScheme * highlight SpecialComment ctermfg=8
autocmd MyAutoCmd ColorScheme * highlight Normal ctermbg=none
colorscheme off
"}}}
" vim-lsp{{{
let g:lsp_settings_servers_dir = expand("~/.vim/vim-lsp-servers")

let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_highlights_enabled = 1
let g:lsp_textprop_enabled = 1
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/vim-lsp.log')
let g:lsp_settings = {
\  'bufls': {'cmd': ['bufls', 'serve'],'allowlist': ['proto']},
\  'sourcekit-lsp': {'cmd': ['xcrun', 'sourcekit-lsp']},
\}
nnoremap <silent> gs :<C-u>LspPeekDefinition<CR>

nnoremap <silent> gd :<C-u>LspDefinition<CR>
nnoremap <silent> gD :<C-u>vertical LspDefinition<CR>
nnoremap <silent> gr :<C-u>vertical LspReferences<CR>
nnoremap <silent> gl :<C-u>vertical LspCodeLens<CR>
"nnoremap <silent> gy :<C-u>LspDocumentSymbol<CR>
nnoremap <silent> gy :<C-u>Vista finder vim_lsp<CR>
nnoremap <silent> gY :<C-u>vertical LspWorkspaceSymbol<CR>
nnoremap <silent> gQ :<C-u>LspDocumentFormat<CR>
vnoremap <silent> gQ :LspDocumentRangeFormat<CR>
nnoremap <silent> gh :<C-u>LspHover<CR>
nnoremap <silent> gH :<C-u>LspTypeHierarchy<CR>
nnoremap <silent> gp :<C-u>vertical LspImplementation<CR>
noremap <silent> gR :<C-u>LspRename<CR>
noremap <silent> gj :<C-u>LspCallHierarchyOutgoing<CR>
noremap <silent> gk :<C-u>LspCallHierarchyIncoming<CR>
"nnoremap <silent> gh  :<C-u>LspDocumentDiagnostics<CR>
nnoremap <silent> ]e  :<C-u>LspNextError<CR>
nnoremap <silent> [e  :<C-u>LspPreviousError<CR>

"let g:asyncomplete_auto_popup = 1
"
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

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

"set omnifunc=lsp#complete
"set completeopt+=preview
set omnifunc=lsp#complete
set completeopt=menuone,noinsert,noselect,preview

" allow modifying the completeopt variable, or it will
" be overridden all the time
let g:asyncomplete_auto_completeopt = 0

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server', 'gql-language-server']

"}}}
" Vista{{{
" https://github.com/liuchengxu/vista.vim

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
"}}}
" Rust{{{
let g:rustfmt_autosave = 1
let g:rustfmt_command = expand('~/.cargo/bin/rustfmt')
let g:rust_doc#open_cmd = 'open'
let g:rust_doc#downloaded_rust_doc_dir = expand('~/.rustup/doc')

" autocmd User asyncomplete_setup call asyncomplete#register_source(
"     \ asyncomplete#sources#racer#get_source_options())
"}}}
" committia.vim{{{
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    setlocal spell
    setlocal spelllang+=cjk

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction
" }}}
" lightline{{{
let g:uesrhome = expand('%:p:h')

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified', 'method' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'method': 'NearestMethodOrFunction',
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
let g:python3_host_prog = "/opt/local/bin/python3"
" cheatsheet
let g:cheatsheet#cheat_file = '~/Dropbox/Work/cheatsheet.md'
let g:cheatsheet#vsplit = 1

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

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

augroup onyx_ft
    au!
    autocmd BufNewFile,BufRead *.onyx set syntax=onyx
augroup END

" vimwiki
" https://github.com/patrickdavey/vimwiki_markdown
let g:vimwiki_list = [
  \ {'path': '~/plain/garden',
  \   'syntax': 'markdown', 'ext': 'md',
  \   'custom_wiki2html': 'vimwiki_markdown', 'path_html': '~/plain/dist/garden_html',
  \   'template_path': '~/src/github.com/thara/dotfiles/templates',
  \   'html_filename_parameterization': 1
  \ }]
let g:vimwiki_global_ext = 0
let g:vimwiki_key_mappings =
  \ {
  \ 'headers': 0,
  \ }

let g:memolist_memo_suffix = "md"
let g:memolist_template_dir_path = expand("~/Dropbox/memo/.memolist-template")

" Copilot
" https://codeinthehole.com/tips/vim-and-github-copilot/
let g:copilot_filetypes = #{
  \   gitcommit: v:true,
  \   markdown: v:true,
  \   text: v:true,
  \ }
autocmd BufReadPre *
  \ let f=getfsize(expand("<afile>"))
  \ | if f > 100000 || f == -2
  \ | let b:copilot_enabled = v:false
  \ | endif
"}}}
"}}}1

" Misc{{{

" Use ripgrep by default
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

command! Today r!date +\%Y-\%m-\%d
" {{{ same_indent
" https://github.com/tyru/config/blob/c765a18ee9577cd8f62e654e348ad066d4e4d3e2/home/volt/rc/default/vimrc.vim#L489-L506
function! s:same_indent(dir) abort
  let lnum = line('.')
  let width = col('.') <= 1 ? 0 : strdisplaywidth(matchstr(getline(lnum)[: col('.')-2], '^\s*'))
  while 1 <= lnum && lnum <= line('$')
    let lnum += (a:dir ==# '+' ? 1 : -1)
    let line = getline(lnum)
    if width >= strdisplaywidth(matchstr(line, '^\s*')) && line =~# '^\s*\S'
      break
    endif
  endwhile
  return abs(line('.') - lnum) . a:dir
endfunction
nnoremap <expr><silent> sj <SID>same_indent('+')
nnoremap <expr><silent> sk <SID>same_indent('-')
onoremap <expr><silent> sj <SID>same_indent('+')
onoremap <expr><silent> sk <SID>same_indent('-')
xnoremap <expr><silent> sj <SID>same_indent('+')
xnoremap <expr><silent> sk <SID>same_indent('-')
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
" ファイルタイプ別設定 {{{
autocmd MyAutoCmd FileType c setlocal tabstop=4 tw=0 sw=4 expandtab
autocmd MyAutoCmd FileType cpp setlocal tabstop=4 tw=0 sw=4 expandtab
autocmd MyAutoCmd FileType cs setlocal textwidth=0 tabstop=4 shiftwidth=4 noexpandtab
autocmd MyAutoCmd FileType ruby setlocal tabstop=2 tw=0 sw=2 expandtab
autocmd MyAutoCmd FileType eruby setlocal tabstop=2 tw=0 sw=2 expandtab
autocmd MyAutoCmd BufNewFile,BufRead app/*/*.rhtml setlocal ft=mason fenc=utf-8
autocmd MyAutoCmd BufNewFile,BufRead app/**/*.rb setlocal ft=ruby fenc=utf-8
autocmd MyAutoCmd BufNewFile,BufRead app/**/*.yml setlocal ft=ruby fenc=utf-8
autocmd MyAutoCmd FileType haskell setlocal tabstop=2 tw=0 sw=2 expandtab
autocmd MyAutoCmd FileType php setlocal tabstop=4 tw=0 sw=4 expandtab
autocmd MyAutoCmd FileType python setlocal tabstop=4 tw=0 shiftwidth=4 expandtab softtabstop=4
autocmd MyAutoCmd FileType python setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd MyAutoCmd FileType python :inoremap # #
autocmd MyAutoCmd FileType html setlocal tabstop=2 tw=0 sw=2 expandtab
autocmd MyAutoCmd BufNewFile,BufRead *.swift setfiletype swift
autocmd MyAutoCmd FileType swift setlocal tabstop=4 tw=0 sw=4 expandtab
autocmd MyAutoCmd FileType swift setlocal omnifunc=lsp#complete
autocmd MyAutoCmd FileType go setlocal tabstop=4 tw=0 sw=4 noexpandtab nolist
autocmd MyAutoCmd FileType go iabbrev <buffer> u8 uint8
autocmd MyAutoCmd FileType go iabbrev <buffer> u16 uint16
autocmd MyAutoCmd FileType go iabbrev <buffer> u32 uint32
autocmd MyAutoCmd FileType go iabbrev <buffer> u64 uint64
autocmd MyAutoCmd FileType go iabbrev <buffer> i8 int8
autocmd MyAutoCmd FileType go iabbrev <buffer> i16 int16
autocmd MyAutoCmd FileType go iabbrev <buffer> i32 int32
autocmd MyAutoCmd FileType go iabbrev <buffer> i64 int64

autocmd MyAutoCmd BufNewFile,BufRead *.changelog setf changelog
autocmd MyAutoCmd BufNewFile,BufRead *.clg setf changelog

autocmd MyAutoCmd FileType markdown nnoremap <buffer> T :call checkbox#ToggleCB()<CR>
autocmd MyAutoCmd FileType markdown setlocal wrap syntax=off
autocmd MyAutoCmd FileType make setlocal isfname-==
autocmd FileType vim setlocal foldmethod=marker

autocmd MyAutoCmd FileType vimwiki :nmap - <Plug>(dirvish_up)

augroup zepl
    autocmd!
    autocmd FileType python     let b:repl_config = { 'cmd': 'python3' }
    autocmd FileType javascript let b:repl_config = { 'cmd': 'node' }
    autocmd FileType ruby       let b:repl_config = { 'cmd': 'irb' }
    autocmd FileType swift      let b:repl_config = { 'cmd': 'swift' }
augroup END
" }}}

if has('python3')
  command -range FormatSQL :call FormatSQL(<line1>, <line2>)

  function! FormatSQL(start, end)
python3 << EOF
import vim
import sqlparse

start = int(vim.eval('a:start')) - 1
end = int(vim.eval('a:end')) - 1
buf = vim.current.buffer

try:
    sql = '\n'.join(buf[start:end + 1])
    formatted = sqlparse.format(sql,
      reindent=True,
      keyword_case='upper',
      indent_columns=True,
    )

    lines = [line.encode('utf-8') for line in formatted.split('\n')]
    buf[:] = buf[:start] + lines + buf[end + 1:]
except Exception as e:
    print(e)
EOF
  endfunction
else
    echo "Error: FormatSQL Required vim compiled with +python"
endif

"}}}

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

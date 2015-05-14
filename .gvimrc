" colorscheme solarized
set background=dark

highlight CursorIM guibg=Purple guifg=NONE
highlight Search guibg=DarkBlue guifg=NONE

if has("gui_macvim")
  " set gfn=Osaka-Mono:h14
  " set gfw=Osaka-Mono:h14
  set transparency=10
  "set guioptions-=T
elseif has("gui_mac")
  set gfn=Osaka-Mono:h14
  set gfw=Osaka-Mono:h14
  set macatsui
  set noantialias
  set transparency=240
  
  highlight IMLine guibg=DarkGreen guifg=Black
  
  map <D-w> :q<CR>gT
  map <D-t> :tabnew<CR>
  map <D-n> :new<CR>
  map <D-S-t> :browse tabe<CR>
  map <D-S-n> :browse split<CR>
  map <D-]> :tabn<CR>
  map <D-[> :tabp<CR>
  map <D-M-Right> :tabn<CR>
  map <D-M-Left> :tabp<CR>
  imap <D-M-Right> <C-o>:tabn<CR>
  imap <D-M-Left> <C-o>:tabp<CR>
end


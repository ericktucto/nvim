set encoding=utf-8
hi Pmenu ctermbg=10 ctermfg=15 guibg=#051b26 guifg=#ffffff
hi PmenuSel ctermbg=10 ctermfg=15 guibg=#ffffff guifg=#051b26
hi Visual ctermbg=255 ctermfg=10 cterm=NONE guibg=#2e4a59 guifg=NONE gui=NONE
hi NonText guifg=#ffff60

syntax enable
set backspace=indent,eol,start
set hidden
set nobackup
set noswapfile
set noshowmode " IMPIDE VER EL MODO POR DEFAULT NEOVIM (INSERT,VISUAL,NORMAL).
set showmatch
set list
set eol
let g:copilot_proxy = 'http://localhost:11435'
let g:copilot_proxy_strict_ssl = v:false
" let mapleader="\<C-h>"


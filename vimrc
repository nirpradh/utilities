# ~/.vimrc

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=^[[4%dm
     set t_Sf=^[[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

" Highlight whitespace in the file
highlight ExtraWhitespace ctermbg=Blue guibg=LightGray
match ExtraWhitespace /\s\+$/

" Show cursor line
set cursorline

set number
set colorcolumn=80

set ignorecase
set smartcase
set incsearch

" Color setting for vimdiff
hi DiffAdd      cterm=bold      ctermfg=White         ctermbg=Green
hi DiffChange   cterm=bold      ctermfg=NONE          ctermbg=NONE
hi DiffDelete   cterm=bold      ctermfg=LightBlue     ctermbg=LightRed
hi DiffText     cterm=bold      ctermfg=Yellow        ctermbg=LightRed

autocmd FilterWritePre * if &diff | setlocal wrap< | endif

" Rules for git commit message
autocmd FileType gitcommit set textwidth=72
autocmd FileType gitcommit set colorcolumn=72
autocmd FileType gitcommit set spell
autocmd FileType diff set colorcolumn=72

" Indentation for YAML file
autocmd FileType yaml set shiftwidth=2
autocmd FileType yaml set tabstop=2
autocmd FileType yaml set expandtab

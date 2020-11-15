" Load Plugins
source ~/.vim/plugin.vim

" BASICS -----------------------------------------------------------------------
"
"
" Set to auto read when the file is changed from the outside
set autoread

" Highlight current search
set hlsearch

" Move cursor to the pattern while is searching
set incsearch

" Highlight brackets when cursor is over them
set showmatch

" Make backspace work like most other app
set backspace=2

" Show lines
set number

" No backup
set nobackup
set nowb
set noswapfile

" Indentation
set expandtab shiftwidth=2 softtabstop=2 smarttab
filetype plugin indent on

" Sets default line limiter bar width and specific for each filetype.
set colorcolumn=80
augroup colorcolumn100
  autocmd!
  autocmd FileType soy,java set colorcolumn=100
augroup END

" Timeout for key combo.
set ttimeoutlen=50

" Allow change buffers without saving
set hidden

" Enable syntax
syntax enable

" Don't show -- INSERT -- text because vim-airline already show this.
set noshowmode

" Don't save netrwhist files.
let g:netrw_dirhistmax=0

" Set clipboard support.
set clipboard=unnamedplus

" KEY MAPPING ------------------------------------------------------------------
"
"
nnoremap <S-left> :bp <enter>
nnoremap <S-right> :bn <enter>
nnoremap <C-P> :CtrlP <enter>

" delete without overwritting registers
nnoremap d "_d
vnoremap d "_d

" paste on selection without overwritting registers
vnoremap p "_dP

" COMMANDS ---------------------------------------------------------------------

" Open CtrlP on the same directory as the current opened file.
command! -nargs=* -complete=file CtrlP lcd %:p:h
                                       \| exec 'Files <args>'
                                       \| exec 'lcd' getcwd(-1) 

" COLOR SCHEME -----------------------------------------------------------------
"
"
" Gruvbox colorscheme
set background=dark
let g:gruvbox_contrast_dark="soft"
colorscheme gruvbox

" PLUGINS CONFIG ---------------------------------------------------------------
"
"
" Empty value to disable preview window altogether
let g:fzf_preview_window = ''

" vim-airline
let g:airline_powerline_fonts=1
let g:airline_extensions = ['tabline']
let g:airline_section_c = ''
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = ''

" VIMDIFF CONFIG ---------------------------------------------------------------
"
"
if &diff
  " Disable airline in diff mode.
  let g:airline_disable_statusline = 1
  let g:airline_extensions = []
  " Remove navigations to act on vim windows instead.
  nnoremap <S-left> <C-w>h
  nnoremap <S-right> <C-w>l
endif

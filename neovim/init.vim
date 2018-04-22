" Load Plugins
execute pathogen#infect()

" Set to auto read when the file is changed from the outside
set autoread

" Highlight current search
set hlsearch

" Move cursor to the pattern while is searching
set incsearch

" Highlight brackets when cursor is over them
set showmatch

" Show cursor line
" ! cursorline is causing slow performance !
" set cursorline

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
"filetype plugin indent on

" Vim default update time
if !has('nvim')
  set updatetime=100
endif

" Visual bar for 80 characters
set colorcolumn=80

" Allow change buffers without saving
set hidden

" Enable syntax
syntax enable

" Don't show -- INSERT -- text because vim-powerline already show this.
set noshowmode

" Necessary for airline in vim.
if !has('nvim')
  set laststatus=2
endif

" Don't save netrwhist files.
let g:netrw_dirhistmax=0

" ----------- MAPS ----------- "
nnoremap <C-left> :bp <enter>
nnoremap <C-right> :bn <enter>
map <C-y> "+y
map <C-i> "+p

" Gruvbox colorscheme
if !has('nvim')
  set t_Co=256
endif
set background=dark
let g:gruvbox_contrast_dark="soft"
let g:gruvbox_contrast_light="soft"
colorscheme gruvbox

" vim-indentLine
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_char = '┆'
let g:indentLine_first_char = '┆'


" vim-ctrlp
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_custom_ignore = {
  \ 'dir': 'node_modules',
  \ 'file': '.*.o$'
  \ }

" vim-airline
let g:airline_powerline_fonts=1
let g:airline_extensions = ['ctrlp', 'tabline']
let g:airline_section_c = ''
let g:airline_section_z = ''

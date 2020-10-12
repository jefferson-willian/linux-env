" Load Plugins
source ~/.vim/plugin.vim

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
nnoremap <S-left> :bp <enter>
nnoremap <S-right> :bn <enter>
nnoremap <C-P> :Files <enter>

" Gruvbox colorscheme
if !has('nvim')
  set t_Co=256
endif
set background=dark
let g:gruvbox_contrast_dark="soft"
let g:gruvbox_contrast_light="soft"
colorscheme gruvbox

" Empty value to disable preview window altogether
let g:fzf_preview_window = ''

" vim-airline
let g:airline_powerline_fonts=1
let g:airline_extensions = ['ctrlp', 'tabline']
let g:airline_section_c = ''
let g:airline_section_z = ''

" NERDTree
"
" Sync current directory to current opened file.
autocmd BufEnter * lcd %:p:h
" Toggle
map <C-n> :NERDTreeToggle<CR>

" remove latex symbols
let g:tex_conceal = ""

" Set clipboard support.
set clipboard=unnamedplus

" WSL yank support.
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " default location
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
    augroup END
end

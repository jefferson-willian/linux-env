" Load common vimrc.
source ~/.vim/vimrc-common.vim

" Load vimrc expansion.
if filereadable(expand("~/.vim/vimrc-expansion.vim"))
  exe 'source ~/.vim/vimrc-expansion.vim'
endif

" Load user's vimrc.
source ~/.vim/vimrc_user.vim

" Load work's vimrc.
if filereadable(expand("~/.vim/vimrc_work.vim"))
  exe 'source ~/.vim/vimrc_work.vim'
endif

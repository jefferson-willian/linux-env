#!/bin/bash

setup::vim () {
  mkdir -p ~/.vim
  util::make_link_safe ~/.vimrc ../config/vim/vimrc.vim
  util::make_link_safe ~/.vim/plugin.vim ../config/vim/plugin.vim
  util::make_link_safe ~/.vim/vimrc-common.vim ../config/vim/vimrc-common.vim
  util::make_link_safe ~/.vim/help.txt ../config/vim/help.txt

  log::progress "Getting vim-plug"
  readonly VIM_PLUG=~/.vim/autoload/plug.vim
  curl -SsfLo $VIM_PLUG --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  if $(util::file_not_exist $VIM_PLUG) ; then
    log::severe "$VIM_PLUG file missing!"
  fi
  log::progress_done
  
  log::progress "Installing vim plugins"
  vim -u ~/.vim/plugin.vim +'PlugUpdate --sync' +qall &> /dev/null
  vim -u ~/.vim/plugin.vim +'PlugClean!' +qall &> /dev/null
  log::progress_done
}

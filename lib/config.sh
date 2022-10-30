#!/bin/bash

config::setup_vim () {
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

config::setup_tmux () {
  mkdir -p ~/.tmux/plugins
  rm -rf ~/.tmux/plugins/tpm
  util::make_link_safe ~/.tmux.conf ../config/tmux/tmux.conf
  util::make_link_safe ~/.tmux-common.conf ../config/tmux/tmux-common.conf
  util::make_link_safe ~/.tmux/help.txt ../config/tmux/help.txt

  log::progress "Getting tmux-tpm"
  git clone --quiet https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  log::progress_done

  log::progress "Installing tmux plugins"
  ~/.tmux/plugins/tpm/bin/clean_plugins > /dev/null
  ~/.tmux/plugins/tpm/bin/install_plugins > /dev/null
  ~/.tmux/plugins/tpm/bin/update_plugins all > /dev/null
  log::progress_done
}


config::setup_ssh () {
  util::make_link_safe ~/.ssh ../config/ssh
}

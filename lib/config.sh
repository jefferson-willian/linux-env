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

config::setup_git () {
  util::make_link_safe ~/.gitconfig ../config/gitconfig
}

config::setup_bash () {
  util::make_link_safe ~/.bashrc-common ../config/bash/bashrc-common
  util::make_link_safe ~/.bash_aliases ../config/bash/aliases
  util::make_link_safe ~/.gruvbox gruvbox.sh
  mkdir -p ~/.bash-aliases
  util::make_link_safe ~/.bash-aliases/common ../config/bash/aliases-common

  if [[ -z $(cat ~/.bashrc | grep -e "^# Load common bashrc$") ]] ; then
    echo -e "\n# Load common bashrc\nif [[ -f ~/.bashrc-common ]] ; then\n  . ~/.bashrc-common\nfi" >> ~/.bashrc
  fi

  if [[ -z $(cat ~/.bashrc | grep -e "^# Load bashrc expansion$") ]] ; then
    echo -e "\n# Load bashrc expansion\nif [[ -f ~/.bashrc-expansion ]] ; then\n  . ~/.bashrc-expansion\nfi" >> ~/.bashrc
  fi
}

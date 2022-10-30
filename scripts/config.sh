#!/bin/bash

config::make_link () {
  # If config file is already a link then just delete the link.
  if $(util::link_exists $1) ; then
    rm $1
  fi

  # Backup file if it exists
  if $(util::file_exists $1) ; then
    util::get_confirmation \
      "File named $1 already exists. Do you want to create a backup?"
    # Backup and delete file
    if $(util::has_confirmed) ; then
      util::backup_file $1
      rm $1
    else
      log::severe \
        "Can't proceed because file with the same config name exists."
    fi
  fi

  # Backup directory if it exists
  if $(util::directory_exists $1) ; then
    util::get_confirmation \
      "Directory named $1 already exists. Do you want to create a backup?"
    # Backup and delete directory
    if $(util::has_confirmed) ; then
      util::backup_directory $1
      rm -r $1
    else
      log::severe \
        "Can't proceed because directory with the same config name exists."
    fi
  fi

  ln -s $(util::get_path "$2") "$1"
}

config::setup_vim () {
  mkdir -p ~/.vim
  config::make_link ~/.vimrc ../vim/vimrc.vim
  config::make_link ~/.vim/plugin.vim ../vim/plugin.vim
  config::make_link ~/.vim/vimrc-common.vim ../vim/vimrc-common.vim
  config::make_link ~/.vim/help.txt ../vim/help.txt

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
  config::make_link ~/.tmux.conf ../tmux/tmux.conf
  config::make_link ~/.tmux-common.conf ../tmux/tmux-common.conf
  config::make_link ~/.tmux/help.txt ../tmux/help.txt

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
  config::make_link ~/.gitconfig ../config/gitconfig
}

config::setup_bash () {
  config::make_link ~/.bashrc-common ../config/bash/bashrc-common
  config::make_link ~/.bash_aliases ../config/bash/aliases
  config::make_link ~/.gruvbox gruvbox.sh
  mkdir -p ~/.bash-aliases
  config::make_link ~/.bash-aliases/common ../config/bash/aliases-common

  if [[ -z $(cat ~/.bashrc | grep -e "^# Load common bashrc$") ]] ; then
    echo -e "\n# Load common bashrc\nif [[ -f ~/.bashrc-common ]] ; then\n  . ~/.bashrc-common\nfi" >> ~/.bashrc
  fi

  if [[ -z $(cat ~/.bashrc | grep -e "^# Load bashrc expansion$") ]] ; then
    echo -e "\n# Load bashrc expansion\nif [[ -f ~/.bashrc-expansion ]] ; then\n  . ~/.bashrc-expansion\nfi" >> ~/.bashrc
  fi
}

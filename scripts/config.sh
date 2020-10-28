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
  config::make_link ~/.vim/vimrc_user.vim ../vim/vimrc_user.vim
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
  vim -u $(util::get_path ../vim/plugin.vim) +PlugUpdate +qall
  vim -u $(util::get_path ../vim/plugin.vim) +PlugClean! +qall
  log::progress_done
}

config::setup_tmux () {
  config::make_link ~/.tmux.conf ../tmux/tmux.conf
  rm -rf ~/.tmux/plugins
  mkdir -p ~/.tmux/plugins/tpm

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
  config::make_link ~/.gitconfig ../git/gitconfig
}

config::setup_bash () {
  config::make_link ~/.bashrc_user ../bash/bashrc_user
  config::make_link ~/.bash_aliases ../bash/aliases
  config::make_link ~/.bash_aliases_user ../bash/aliases_user

  if [[ -z $(cat ~/.bashrc | grep -e "^# Load user bashrc$") ]] ; then
    echo -e "\n# Load user bashrc\nif [[ -f ~/.bashrc_user ]] ; then\n  . ~/.bashrc_user\nfi" >> ~/.bashrc
  fi

  if [[ -z $(cat ~/.bashrc | grep -e "^# Load work bashrc$") ]] ; then
    echo -e "\n# Load work bashrc\nif [[ -f ~/.bashrc_work ]] ; then\n  . ~/.bashrc_work\nfi" >> ~/.bashrc
  fi
}

#!/bin/bash

config::make_link () {
  log::info "Creating symbolic link for $1"

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
  config::make_link ~/.vimrc ../vim/init.vim
  config::make_link ~/.vim ../vim

  log::info "Getting vim-plug"
  readonly VIM_PLUG=~/.vim/autoload/plug.vim
  curl -SsfLo $VIM_PLUG --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  if $(util::file_not_exist $VIM_PLUG) ; then
    log::severe "$VIM_PLUG file missing!"
  fi
  
  log::info "Installing vim plugins"
  vim -u $(util::get_path ../vim/plugin.vim) -c ":PlugUpdate"
}

config::setup_tmux () {
  config::make_link ~/.tmux.conf ../tmux/tmux.conf
}

config::setup_git () {
  config::make_link ~/.gitconfig ../git/gitconfig
}

config::setup_bash () {
  config::make_link ~/.bashrc_user ../bash/bashrc

  if [[ -z $(cat ~/.bashrc | grep -e "^# Load user bash$") ]] ; then
    log::info "Appending to ~/.bashrc"
    echo -e "\n# Load user bash\nif [[ -z ~/.bashrc_user ]] ; then\n  source ~/.bashrc_user;\nfi" >> ~/.bashrc
  fi
}

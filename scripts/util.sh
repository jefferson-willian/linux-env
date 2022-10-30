#!/bin/bash

################################################################################
#
# PACKAGE MANAGEMENT
#
util::install_package () {
  sudo apt-get -y install $1 > /dev/null
}

util::is_package_installed () {
  [[ ! -z $(dpkg -s "$1" 2> /dev/null) ]]
}
################################################################################
#
# FILE MANAGEMENT
#
util::file_exists () {
  [[ -f $1 ]]
}

util::file_not_exist () {
  [[ ! -f $1 ]]
}

util::directory_exists () {
  [[ -d $1 ]]
}

util::link_exists () {
  [[ -L $1 ]]
}

util::backup_file () {
  backup_filename=$1
  i=0
  while [[ -f $backup_filename ]]; do
    backup_filename="$1.$i.bak"
    i=$((i+1))
  done

  if [[ $1 != $backup_filename ]]; then
    log::info "Created backup file $backup_filename"
    cp "$1" "$backup_filename"
  else
    log::warning "No filename $1 to backup!"
  fi
}

util::backup_directory () {
  backup_dir=$1
  i=0
  while [[ -d $backup_dir ]]; do
    backup_dir="$1.$i.bak"
    i=$((i+1))
  done

  if [[ $1 != $backup_dir ]]; then
    log::info "Created backup directory $backup_dir"
    cp -r "$1" "$backup_dir"
  else
    log::warning "No directory $1 to backup!"
  fi
}

util::make_link_safe () {
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
################################################################################
#
# PATH
#
util::get_path () {
  echo $(readlink -f "$(dirname -- "$(readlink -f -- $BASH_SOURCE)")/$1")
}
################################################################################
#
# USER INTERACTION
#
util::get_confirmation () {
  read -p "$1 " -n 1 -r
  echo    # (optional) move to a new line
}

util::has_confirmed () {
  [[ $REPLY =~ ^[Yy]$ ]]
}

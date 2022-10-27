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

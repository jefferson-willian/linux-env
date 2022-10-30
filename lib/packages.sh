#!/bin/bash

function packages::install_package () {
  readonly has_sudo=$(sudo -n true 2> /dev/null && echo 0 || echo 1)
  if [[ $has_sudo -ne 0 ]]; then
    log::info "Please run as root to install packages"
  fi
  sudo apt-get -y install $1 > /dev/null
}

function packages::is_package_installed () {
  [[ ! -z $(dpkg -s "$1" 2> /dev/null) ]]
}

function packages::install_packages() {
  total=0
  installed=0
  skipped=0

  log::info "Installing packages..."
  while read -r line
  do
    package=$(echo "$line" | awk '{print $1}')
    if [[ ! -z $package ]] && [[ ! "#" = $package ]] ; then
      total=$((total+1))
      if ! $(packages::is_package_installed $package); then
        installed=$((installed+1))
        packages::install_package $package
      else
        skipped=$((skipped+1))
      fi
    fi
  done < "$1"

  log::info "(${installed}/${total}) packages installed."
  log::info "(${skipped}/${total}) packages already installed."
}

#!/bin/bash

function packages::install_package () {
  sudo apt-get -y install $1 > /dev/null
}

function packages::is_package_installed () {
  [[ ! -z $(dpkg -s "$1" 2> /dev/null) ]]
}

function packages::install_packages() {
  while read -r line
  do
    package=$(echo "$line" | awk '{print $1}')
    if [ ! -z $package ] && [ ! "#" = $package ] ; then
      if ! $(packages::is_package_installed $package); then
        log::progress "Installing $package"
        packages::install_package $package
        log::progress_done
      else
        log::info "$package already installed!"
      fi
    fi
  done < "$1"
}

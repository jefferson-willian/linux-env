#!/bin/bash

function packages::install_packages() {
  while read -r line
  do
    package=$(echo "$line" | awk '{print $1}')
    if [ ! -z $package ] && [ ! "#" = $package ] ; then
      if ! $(util::is_package_installed $package); then
        log::progress "Installing $package"
        util::install_package $package
        log::progress_done
      else
        log::info "$package already installed!"
      fi
    fi
  done < "$(dirname -- "$0")/config/packages"
}

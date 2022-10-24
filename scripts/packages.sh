#!/bin/bash

function packages::install_packages() {
  while read -r line
  do
    package=$(echo "$line" | awk '{print $1}')
    if [ ! -z $package ] && [ ! "#" = $package ] ; then
      log::progress "Installing $package"
      if ! $(util::is_package_installed $package); then
        util::install_package $package
      fi
      log::progress_done
    fi
  done < "$(dirname -- "$0")/config/packages"
}

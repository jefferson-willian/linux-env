#!/bin/bash

util::install_package () {
  sudo apt-get -y install $1 > /dev/null
}

util::is_package_installed () {
  [[ ! -z $(dpkg -l | grep -i "$1") ]]
}

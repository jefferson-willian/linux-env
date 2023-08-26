#!/bin/bash

setup::packages () {
  # Can only install packages if apt-get in available
  if [[ ! -z $(command -v apt-get) ]]; then
    packages::install_packages "$(dirname -- "$(readlink -f -- $0)")/config/packages"
  fi
}

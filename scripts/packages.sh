#!/bin/bash

# List of packages to be installed.
readonly PACKAGES=( \
  git \
  vim \
  tmux \
  hstr \
  fonts-hack-ttf \
  ripgrep \
  fzf \
)

function packages::install_packages() {
  for package in "${PACKAGES[@]}"; do
    log::progress "Installing $package"
    if ! $(util::is_package_installed $package); then
      util::install_package $package
    fi
    log::progress_done
  done
}

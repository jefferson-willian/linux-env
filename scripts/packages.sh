#!/bin/bash

# List of packages to be installed.
readonly PACKAGES=( \
  git \
  neovim \
  tmux \
  hstr \
  fonts-hack-ttf \
)

function packages::install_packages() {
  for package in "${PACKAGES[@]}"; do
    if $(util::is_package_installed $package); then
      log::info "$package is already installed!"
    else
      log::info "Installing $package..."
      util::install_package $package
      log::info "Done!"
    fi
  done
}

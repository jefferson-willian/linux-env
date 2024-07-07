#!/bin/bash

setup::terminal () {
  if $(packages::is_package_installed "gnome-terminal"); then
    dconf load /org/gnome/terminal/legacy/profiles:/ < ./config/terminal/gnome-terminal.dconf
  fi
}

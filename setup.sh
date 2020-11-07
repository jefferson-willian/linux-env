#!/bin/bash

set -e

::source () {
  source "$(dirname -- "$(readlink -f -- $BASH_SOURCE)")/$1"
}

::source scripts/log.sh
::source scripts/util.sh
::source scripts/packages.sh
::source scripts/config.sh

if [[ $(id -u) -ne 0 ]] ; then
  log::severe "You need to run the script as super user!"
fi

packages::install_packages

config::setup_git
config::setup_vim
config::setup_tmux
config::setup_bash

set +e

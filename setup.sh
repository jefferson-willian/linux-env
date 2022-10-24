#!/bin/bash

set -e

::source () {
  source "$(dirname -- "$(readlink -f -- $BASH_SOURCE)")/$1"
}

::source scripts/log.sh
::source scripts/util.sh
::source scripts/packages.sh
::source scripts/config.sh

packages::install_packages

config::setup_git
config::setup_vim
config::setup_tmux
config::setup_bash

set +e

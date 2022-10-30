#!/bin/bash

set -e

::source () {
  source "$(dirname -- "$(readlink -f -- $BASH_SOURCE)")/$1"
}

::source lib/log.sh
::source lib/util.sh
::source lib/packages.sh
::source lib/config.sh

packages::install_packages

config::setup_git
config::setup_vim
config::setup_tmux
config::setup_bash

set +e

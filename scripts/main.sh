#!/bin/bash

set -e

::source () {
  source "$(dirname -- "$(readlink -f -- $BASH_SOURCE)")/$1"
}

::source log.sh
::source util.sh
::source packages.sh
::source config.sh

packages::install_packages

config::setup_git
config::setup_vim
config::setup_tmux

set +e

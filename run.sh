#!/bin/bash

set -e

::source () {
  source "$(dirname -- "$(readlink -f -- $BASH_SOURCE)")/$1"
}

::source lib/log.sh
::source lib/util.sh
::source lib/packages.sh
::source lib/config.sh

::source setup/bash.sh

packages::install_packages "$(dirname -- "$(readlink -f -- $0)")/config/packages"

config::setup_git
config::setup_ssh
config::setup_vim
config::setup_tmux
setup::bash

set +e

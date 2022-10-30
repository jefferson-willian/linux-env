#!/bin/bash

set -e

::source () {
  for f in "$@"; do
    source "$(dirname -- "$(readlink -f -- $BASH_SOURCE)")/$f"
  done
}

::source lib/*.sh
::source setup/*.sh

packages::install_packages "$(dirname -- "$(readlink -f -- $0)")/config/packages"

setup::git
setup::ssh
setup::vim
setup::tmux
setup::bash

set +e

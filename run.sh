#!/bin/bash

set -e

::source () {
  files="$(ls $(dirname -- "$(readlink -f -- $BASH_SOURCE)")/$1)"
  for f in $files; do
    source "$f"
  done
}

::source lib/*.sh
::source setup/*.sh

setup::packages
setup::git
setup::vim
setup::tmux
setup::bash

set +e

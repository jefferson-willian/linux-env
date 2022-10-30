#!/bin/bash

set -e

::source () {
  for i in $@; do
    files="$(ls $(dirname -- "$(readlink -f -- $BASH_SOURCE)")/$i)"
    for f in $files; do
      source "$f"
    done
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

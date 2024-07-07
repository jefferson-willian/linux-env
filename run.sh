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

# Install packages
setup::packages

# Set configs for git, vim, tmux, bash and terminal.
setup::git
setup::vim
setup::tmux
setup::bash
setup::terminal

set +e

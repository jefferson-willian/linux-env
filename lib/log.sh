#!/bin/bash

log::info () {
  echo $@
}

log::warning () {
  echo $@
}

log::progress () {
  printf "$@..."
}

log::progress_done () {
  printf "DONE!\n"
}

log::severe () {
  echo "ABORT - $@"
  exit 1
}

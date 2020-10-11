#!/bin/bash

log::info () {
  echo $@
}

log::warning () {
  echo $@
}

log::severe () {
  echo "ABORT - $@"
  exit 1
}

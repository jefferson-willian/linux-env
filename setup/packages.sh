#!/bin/bash

setup::packages () {
  packages::install_packages "$(dirname -- "$(readlink -f -- $0)")/config/packages"
}

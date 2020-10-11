#!/bin/bash

source log.sh
source util.sh
source packages.sh

set -e

packages::install_packages

set +e

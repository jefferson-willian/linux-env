#!/bin/bash

setup::git () {
  util::make_link_safe ~/.gitconfig ../config/gitconfig
}

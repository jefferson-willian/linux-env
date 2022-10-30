#!/bin/bash

setup::bash () {
  util::make_link_safe ~/.bashrc-common ../config/bash/bashrc-common
  util::make_link_safe ~/.bash_aliases ../config/bash/aliases
  mkdir -p ~/.bash-aliases
  util::make_link_safe ~/.bash-aliases/common ../config/bash/aliases-common

  # Script for fixing gruvbox color scheme.
  curl -SsfLo ~/.gruvbox_256palette.sh \
        https://raw.githubusercontent.com/morhetz/gruvbox/master/gruvbox_256palette.sh

  if [[ -z $(cat ~/.bashrc | grep -e "^# Load common bashrc$") ]] ; then
    echo -e "\n# Load common bashrc\nif [[ -f ~/.bashrc-common ]] ; then\n  . ~/.bashrc-common\nfi" >> ~/.bashrc
  fi

  if [[ -z $(cat ~/.bashrc | grep -e "^# Load bashrc expansion$") ]] ; then
    echo -e "\n# Load bashrc expansion\nif [[ -f ~/.bashrc-expansion ]] ; then\n  . ~/.bashrc-expansion\nfi" >> ~/.bashrc
  fi
}

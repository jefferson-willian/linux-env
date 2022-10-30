#!/bin/bash

config::setup_tmux () {
  mkdir -p ~/.tmux/plugins
  rm -rf ~/.tmux/plugins/tpm
  util::make_link_safe ~/.tmux.conf ../config/tmux/tmux.conf
  util::make_link_safe ~/.tmux-common.conf ../config/tmux/tmux-common.conf
  util::make_link_safe ~/.tmux/help.txt ../config/tmux/help.txt

  log::progress "Getting tmux-tpm"
  git clone --quiet https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  log::progress_done

  log::progress "Installing tmux plugins"
  ~/.tmux/plugins/tpm/bin/clean_plugins > /dev/null
  ~/.tmux/plugins/tpm/bin/install_plugins > /dev/null
  ~/.tmux/plugins/tpm/bin/update_plugins all > /dev/null
  log::progress_done
}

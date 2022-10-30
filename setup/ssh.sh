#!/bin/bash

setup::ssh () {
  util::make_link_safe ~/.ssh ../config/ssh
}

#!/bin/sh
#
# run via curl:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/rz3n/terminal/master/install.sh)"
# via wget:
#   sh -c "$(wget -qO- https://raw.githubusercontent.com/rz3n/terminal/master/install.sh)"

set -e

# local settings
FISH_HOME="${HOME}/.config/fish"

# remote settings
REPO="rz3n/terminal"
REMOTE="https://github.com/${REPO}.git"
BRANCH="master"


check_command() {
  command -v "$@" >/dev/null 2>&1
}

msg_error() {
  printf '%s!Error: %s%s\n' "$*" >&2
}

check_dependencies() {
  check_command wget || {
    msg_error "you need to install wget"
    exit 1
  }
  check_command fish || {
    msg_error "you need to install fish"
    exit 1
  }
}

get_fish_config() {
  wget -O $FISH_HOME/alias.fish https://raw.githubusercontent.com/$REPO/$BRANCH/fish/alias.fish
  wget -O $FISH_HOME/colors.fish https://raw.githubusercontent.com/$REPO/$BRANCH/fish/colors.fish
  wget -O $FISH_HOME/config.fish https://raw.githubusercontent.com/$REPO/$BRANCH/fish/config.fish
  wget -O $FISH_HOME/env.fish https://raw.githubusercontent.com/$REPO/$BRANCH/fish/env.fish
}

get_vimrc() {
  wget -O $HOME/.vimrc https://raw.githubusercontent.com/$REPO/$BRANCH/vimrc
}


main() {
  check_dependencies
 
  # fish
  if [ -d "$FISH_HOME" ]; then
    get_fish_config
  else
    echo "creating fish directory"
    mkdir -p $HOME/.config/fish
    get_fish_config
  fi

  # vimrc
  get_fimrc

}


main "$@"

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
  wget -O $FISH_HOME/aliases/alpine.fish https://raw.githubusercontent.com/$REPO/$BRANCH/fish/aliases/alpine.fish
  wget -O $FISH_HOME/aliases/mac.fish https://raw.githubusercontent.com/$REPO/$BRANCH/fish/aliases/mac.fish
  wget -O $FISH_HOME/aliases/manjaro.fish https://raw.githubusercontent.com/$REPO/$BRANCH/fish/aliases/manjaro.fish
  wget -O $FISH_HOME/aliases/ubuntu.fish https://raw.githubusercontent.com/$REPO/$BRANCH/fish/aliases/ubuntu.fish
  wget -O $FISH_HOME/aliases/unix.fish https://raw.githubusercontent.com/$REPO/$BRANCH/fish/aliases/unix.fish
  
  wget -O $FISH_HOME/fish_variables https://raw.githubusercontent.com/$REPO/$BRANCH/fish/fish_variables
  wget -O $FISH_HOME/config.fish https://raw.githubusercontent.com/$REPO/$BRANCH/fish/config.fish
  
  wget -O $FISH_HOME/functions/fish_prompt.fish https://raw.githubusercontent.com/$REPO/$BRANCH/fish/functions/fish_prompt.fish
  wget -O $FISH_HOME/functions/man.fish https://raw.githubusercontent.com/$REPO/$BRANCH/fish/functions/man.fish
}

get_vimrc() {
  wget -O $HOME/.vimrc https://raw.githubusercontent.com/$REPO/$BRANCH/vimrc

  if [ -d "$HOME/.config/nvim" ]; then
    wget -O $HOME/.config/nvim/init.vim https://raw.githubusercontent.com/$REPO/$BRANCH/init.vim
  else
    mkdir -P $HOME/.config/nvim
    wget -O $HOME/.config/nvim/init.vim https://raw.githubusercontent.com/$REPO/$BRANCH/init.vim
  fi

}

get_starship() {
  sh -c "$(curl -fsSL https://starship.rs/install.sh)"
}


main() {
  check_dependencies
 
  # fish
  if [ -d "$FISH_HOME" ]; then
    get_fish_config
  else
    echo "creating fish directory"
    mkdir -P $HOME/.config/fish/{aliases,completions,functions}
    get_fish_config
  fi

  # vimrc
  get_vimrc

  # starship
  get_starship

  fish
}

main "$@"

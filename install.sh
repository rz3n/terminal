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
  check_command curl || {
    msg_error "you need to install curl"
    exit 1
  }
  check_command fish || {
    msg_error "you need to install fish"
    exit 1
  }
}

get_fish_config() {
  mkdir -p $HOME/.config/fish/aliases
  mkdir -p $HOME/.config/fish/completions
  mkdir -p $HOME/.config/fish/functions
    
  curl -L https://raw.githubusercontent.com/$REPO/$BRANCH/fish/aliases/alpine.fish -o $FISH_HOME/aliases/alpine.fish
  curl -L https://raw.githubusercontent.com/$REPO/$BRANCH/fish/aliases/mac.fish -o $FISH_HOME/aliases/mac.fish
  curl -L https://raw.githubusercontent.com/$REPO/$BRANCH/fish/aliases/manjaro.fish -o $FISH_HOME/aliases/manjaro.fish
  curl -L https://raw.githubusercontent.com/$REPO/$BRANCH/fish/aliases/ubuntu.fish -o $FISH_HOME/aliases/ubuntu.fish
  curl -L https://raw.githubusercontent.com/$REPO/$BRANCH/fish/aliases/unix.fish -o $FISH_HOME/aliases/unix.fish
  
  curl -L https://raw.githubusercontent.com/$REPO/$BRANCH/fish/fish_variables -o $FISH_HOME/fish_variables
  curl -L https://raw.githubusercontent.com/$REPO/$BRANCH/fish/config.fish -o $FISH_HOME/config.fish
  
  curl -L https://raw.githubusercontent.com/$REPO/$BRANCH/fish/functions/fish_prompt.fish -o $FISH_HOME/functions/fish_prompt.fish
  curl -L https://raw.githubusercontent.com/$REPO/$BRANCH/fish/functions/man.fish -o $FISH_HOME/functions/man.fish
}

get_vimrc() {
  curl -L https://raw.githubusercontent.com/$REPO/$BRANCH/vimrc -o $HOME/.vimrc

  if [ -d "$HOME/.config/nvim" ]; then
    curl -L https://raw.githubusercontent.com/$REPO/$BRANCH/init.vim -o $HOME/.config/nvim/init.vim
  else
    mkdir -p $HOME/.config/nvim
    curl -L https://raw.githubusercontent.com/$REPO/$BRANCH/init.vim -o $HOME/.config/nvim/init.vim
  fi

}

get_starship() {
  curl -L https://raw.githubusercontent.com/$REPO/$BRANCH/starship.toml -o $HOME/.config/starship.toml
  sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -f
}


main() {
  check_dependencies
 
  # fish
  get_fish_config

  # vimrc
  get_vimrc

  # starship
  get_starship

  fish
}

main "$@"

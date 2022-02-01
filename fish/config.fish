# disable fish greeting
set fish_greeting ""

# ENV
set --export BIN "~/.bin"
set --export EDITOR "/usr/bin/nvim"
set -x FISH ~/.config/fish
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -U fish_user_paths $BIN $fish_user_paths


# Keyboard
if command -v xset > /dev/null
  xset r rate 210 70
end

# OS Selector
switch (uname)
  case Linux
    source $FISH/aliases/unix.fish
    
    switch (lsb_release -si)
      case Alpine
        source $FISH/aliases/alpine.fish

      case Manjaro
        source $FISH/aliases/manjaro.fish

      case Ubuntu
        source $FISH/aliases/ubuntu.fish
    end

  case Darwin
    # test -e {$FISH}/iterm2_shell_integration.fish ; and source {$FISH}/iterm2_shell_integration.fish
    source $FISH/aliases/unix.fish
    source $FISH/aliases/mac.fish

end


# Docker Completion
if test -e {$FISH}/completions/docker.fish] -o -L {$FISH}/completions/docker.fish
  source {$FISH}/completions/docker.fish
else
  curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish -o {$FISH}/completions/docker.fish
  source {$FISH}/completions/docker.fish
  
end


# Load Functions
if test -d $FISH/functions
  for f in $FISH/functions/*.fish
    source $f
  end
end


# Load Completions
if test -d $FISH/completions
  for f in $FISH/completions/*.fish
    source $f
  end
end


# Launch Starship
starship init fish | source


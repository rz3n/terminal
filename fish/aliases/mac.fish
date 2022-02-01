function brew-update --description "Brew update"
  brew update && brew upgrade
end

function brew-clean --description "Brew clean"
  brew cleanup -n
end

# System
alias flush "dscacheutil -flushcache"
alias emptytrash "rm -rfv ~/.Trash
alias cleanup "find . -name '*.DS_Store' -type f -ls -delete"

# Homebrew
alias bc='brew cleanup'
alias bd='brew doctor'
alias bg='brew upgrade --all'
alias bo='brew outdated'
alias brews='brew list -1'
alias bs0='brew services stop'
alias bs1='brew services start'
alias bs='brew services'
alias bsc='brew services cleanup'
alias bsl='brew services list'
alias bsr='brew services restart'
alias bu='brew update'
alias bubc='brew upgrade && brew cleanup'
alias bubo='brew update && brew outdated'
alias bubu='bubo && bubc'

# Finder
alias saf='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder'
alias haf='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'
alias o='open . &'
alias dsstore_bye_bye='find . -name "*.DS_Store" -type f -delete'
alias defr='defaults read'
alias defw='defaults write'

# Check for macOS updates
alias upc='softwareupdate -l'

# Download and install macOS updates
alias upd='softwareupdate -i -a'

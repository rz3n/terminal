function apt-update --description "System Update"
  sudo apt update
  sudo apt dist-upgrade
end

function apt-clean --description "System cleaning"
  sudo apt-get clean
  sudo apt-get autoclean
  sudo apt-get autoremove
  sudo apt-get clean cache
end


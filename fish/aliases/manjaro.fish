alias pacman='sudo pacman'

function pacman-clean --description "System Update"
  sudo paccache -r
  sudo pacman --noconfirm --color always -Scc
  sudo pacman --noconfirm --color always -Rns $(pacman -Qttdq)
  sudo rm -rf /tmp/pamac/*
  #just...
  sudo journalctl --vacuum-time=10d
end

function pacman-update --description "System Cleaning"
  sudo pacman -Syu --color always
end


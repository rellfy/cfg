#!/bin/bash
i() {
  sudo pacman -S --noconfirm --needed $1
}
i_aur() {
  git clone https://aur.archlinux.org/$1.git
  cd $1
  makepkg -si
  cd ..
  rm -rf $1
}
preconfig() {
  sudo dhcpcd
}
install() {
  # Fundamentals
  i "base-devel"
  i "openssh"
  i "vim"
  i "git"
  # Graphics
  i "nvidia"
  i "xorg-server"
  i "xorg-apps"
  i "xorg-xinit"
  # Desktop Environment
  i "plasma"
  i "konsole"
  i "spectacle" # Screenshots.
  # Applications
  i "gimp"
  # TODO only install snapd once
  #i_aur "snapd"
  #systemctl enable --now snapd.socket
  #ln -s /var/lib/snapd/snap /snap
}
install_snaps() {
  snap install chromium
  snap install discord
  snap install spotify
}
postconfig() {
  sudo systemctl enable sddm.service
  sudo systemctl enable dhcpcd
  # Start X
  if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -le 3 ]; then
    exec startx
  fi
  # Start Snapd
  systemctl start snapd.service
}
preconfig
install
install_snaps
postconfig



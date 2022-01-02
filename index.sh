#!/bin/bash
i() {
  sudo dnf install -y $1
}
is_installed() {
  if !(command -v $1 &> /dev/null); then
    return 1;
  fi
  return 0;
}
i_snap() {
  if (is_installed $1); then return 1; fi;
  sudo snap install $1 $2
}
preconfig() {
  sudo dhcpcd
}
install() {
  # Fundamentals
  i "make"
  i "automake"
  i "gcc"
  i "gcc-c++"
  i "kernel-devel"
  i "npm"
  i "snapd"
  sudo systemctl enable --now snapd.socket
  sudo ln -s /var/lib/snapd/snap /snap
}
install_snaps() {
  # Basics
  i_snap "discord"
  i_snap "spotify"
  # Development
  i_snap "rustup" "--classic && sudo rustup install stable"
  i_snap "rider" "--classic"
  i_snap "clion" "--classic"
}
postconfig() {
  echo "done"
}
preconfig
install
install_snaps
postconfig


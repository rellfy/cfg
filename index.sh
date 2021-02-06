#!/bin/bash
i() {
  sudo pacman -S --noconfirm --needed $1
}
is_installed() {
  if !(command -v $1 &> /dev/null); then
    return 1;
  fi
  return 0;
}
i_aur() {
  if (is_installed $2); then return 1; fi;
  git clone https://aur.archlinux.org/$1.git
  cd $1
  makepkg -si
  cd ..
  rm -rf $1
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
  i "base-devel"
  i "wget"
  i "openssh"
  i "vim"
  i "git"
  i "fuse" # Run AppImages.
  # Graphics
  i "nvidia"
  i "xorg-server"
  i "xorg-apps"
  i "xorg-xinit"
  # Desktop Environment
  i "plasma"
  i "konsole"
  i "spectacle" # Screenshots.
  i "libgtk-3.so"
  # Generic dependencies
  i "lib32-gcc-libs"
  i "libpng12"
  i "libpqxx"
  i "npm"
  i "python2"
  i_aur "gconf" "gconf"
  # Applications
  i "gimp"
  if !(is_installed "snap"); then
    i_aur "snapd" "snap"
    sudo systemctl enable --now snapd.socket
    sudo ln -s /var/lib/snapd/snap /snap
  fi
}
install_snaps() {
  # Basics
  i_snap "chromium"
  i_snap "discord"
  i_snap "spotify"
  # Development
  i_snap "rustup" "--classic && sudo rustup install stable"
  i_snap "rider" "--classic"
  i_snap "clion" "--classic"
}
postconfig() {
  sudo systemctl enable sddm.service
  sudo systemctl enable dhcpcd
  # Start X
  if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -le 3 ]; then
    exec startx
  fi
  # Start Snapd
  sudo systemctl start snapd.service
}
preconfig
install
install_snaps
postconfig


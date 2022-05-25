#!/bin/bash

gsettings set org.gnome.desktop.background primary-color '#3464A2'
gsettings set org.gnome.desktop.background secondary-color '#3464A2'
gsettings set org.gnome.desktop.background color-shading-type 'solid'
gsettings set org.gnome.desktop.background draw-background false
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/bitcurator/resources/images/BitCuratorEnv3Logo300px.png'
gsettings set org.gnome.desktop.background draw-background true
gsettings set org.gnome.desktop.background show-desktop-icons true
gsettings set org.gnome.desktop.media-handling automount false
gsettings set org.gnome.desktop.media-handling automount-open false
gsettings set org.gnome.shell enabled-extensions "['ubuntu-appindicators@ubuntu.com', 'ubuntu-dock@ubuntu.com', 'desktop-icons@csoriano', 'apps-menu@gnome-shell-extensions.gcampax.github.com']" 
gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop']"
if [[ $(lsb_release -c -s) == bionic ]]; then
  gsettings set org.gnome.nautilus.desktop home-icon-visible true
  gsettings set org.gnome.nautilus.desktop trash-icon-visible true
  gsettings set org.gnome.nautilus.desktop network-icon-visible true
  gsettings set org.gnome.nautilus.desktop volumes-visible true
  gsettings set org.gnome.shell enable-hot-corners true
  trust=yes
elif [[ $(lsb_release -c -s) == focal ]]; then
  gsettings set org.gnome.shell.extensions.desktop-icons show-trash true
  gsettings set org.gnome.shell.extensions.desktop-icons show-home true
  gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts true
  trust=true
fi
dconf load /org/gnome/terminal/legacy/profiles:/ < /usr/share/bitcurator/resources/terminal-profile.txt
rm /home/$(whoami)/.config/autostart/bitcurator-theme.desktop

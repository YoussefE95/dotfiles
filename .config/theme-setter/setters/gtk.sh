#!/bin/bash
gsettings set org.gnome.desktop.interface gtk-theme "$1-$2-$3" 
gsettings set org.gnome.desktop.interface color-scheme "prefer-$2"
gsettings set org.gnome.desktop.interface icon-theme "$4"
gsettings set org.gnome.desktop.interface font-name "JetBrains Mono SemiBold"

#!/bin/bash
# Update and install packages
paru -Syu && paru -S \
    sddm hyprland hyprlock hyprshot niri awww quickshell-git kitty starship \
    neovim ranger nvtop htop obsidian dropbox discord obs-studio \
    spotify-launcher spicetify-cli dolphin dolphin-plugins okular \
    gwenview ttf-jetbrains-mono ttf-jetbrains-mono-nerd brightnessctl \
    jq python-pipx python-pillow docker docker-buildx ripgrep wl-clipboard \
    gnome-keyring xdg-desktop-portal-kde polkit-kde-agent qt5-wayland \
    qt6-wayland qt6ct zsh zsh-autosuggestions zsh-history-substring-search \
    zsh-syntax-highlighting libappindicator-gtk3 archlinux-xdg-menu \
    xwayland-satellite playerctl pavucontrol-qt systemsettings

# Delete unnecessary folders
sudo rm -rf ~/Documents ~/Music ~/Public ~/Videos ~/Templates ~/Pictures

# Copy config files
sudo rsync -a .config .local .zshrc ~/

# Copy theming scripts
sudo cp .config/theme-setter/bin/* /usr/local/bin/

# Create sym links for local icons
sudo ln -s ~/.local/share/icons/* /usr/share/icons

# Setup sddm
if [ ! -d "/etc/sddm.conf.d" ]; then
    sudo mkdir /etc/sddm.conf.d
fi

if [ ! -d "/usr/share/sddm/themes" ]; then
    sudo mkdir -p /usr/share/sddm/themes
fi

sudo cp .local/share/sddm/default.conf /etc/sddm.conf.d
sudo cp -r .local/share/sddm/themes/dynamic /usr/share/sddm/themes

sudo chown $USER:$USER \
    /usr/share/sddm/themes/dynamic/Main.qml \
    /usr/share/sddm/themes/dynamic/background.jpg

# Set wallpaper
awww img ~/.local/share/wallpaper.jpg \
    --transition-type wipe \
    --transition-angle 30 \
    --transition-step 90

# Set KDE theme
lookandfeeltool -a org.kde.breezedark.desktop
plasma-apply-colorscheme "DynamicTheme"

# Enable systemd services
sudo systemctl enable bluetooth docker sddm

# Add user to Docker group
sudo gpasswd -a $USER docker

# Make zsh default shell
chsh -s $(which zsh)

# Install Spicetify
# spicetify config inject_css 1 replace_colors 1 overwrite_assets 1 \
#   inject_theme_js 1
# spicetify config current_theme Comfy
# spicetify config color_scheme dynamic
# spicetify backup apply

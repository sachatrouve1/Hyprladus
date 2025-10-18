#!/usr/bin/env bash

set -e # exit on any error

# Check if running as root. If root, script will exit
if [[ $EUID -eq 0 ]]; then
    echo "${ERROR}  This script should ${WARNING}NOT${RESET} be executed as root!! Exiting......." | tee -a "$LOG"
    printf "\n%.0s" {1..2}
    exit 1
fi

exec > >(tee -a "$LOG") 2>&1
LOG="$HOME/install.log"

clear

echo "  ______                _           _              _____  _                   "
echo " |  ____|              | |         | |            |  __ \\(_)                 "
echo " | |__   _ __   ___ ___| | __ _  __| |_   _ ___   | |__) |_  ___ ___          "
echo " |  __| | '_ \\ / __/ _ \\ |/ _\` |/ _\` | | | / __|  |  _  /| |/ __/ _ \\    "
echo " | |____| | | | (_|  __/ | (_| | (_| | |_| \\__ \\  | | \\ \\| | (_|  __/     "
echo " |______|_| |_|\\___\\___|_|\\__,_|\\__,_|\\__,_|___/  |_|  \\_\\_|\\___\\___|"
echo "                                                                              "
echo "                                                                              "

mkdir -p ~/.local/share/bin ~/.cache/wal ~/.config/wal ~/Pictures ~/.config ~/etc/greetd ~/Documents ~/Downloads ~/Music ~/Videos

echo "Copying .oh-my-zsh"
cp -r .oh-my-zsh ~/
echo "Copying .bashrc"
cp .bashrc ~/
echo "Copying .zshrc"
cp .zshrc ~/
echo "Copying .p10k.zsh"
cp .p10k.zsh ~/
echo "Copying set_wallpaper.sh"
cp set_wallpaper.sh ~/
echo "Copying rmnot.sh"
cp rmnot.sh ~/
echo "Copying wallpapers"
cp -r Wallpapers/ ~/Pictures/
echo "Copying wal cache"
cp -r cache/wal ~/.cache/wal/
echo "Copying wal config"
cp -r cache/wal ~/.config/wal/
echo "Copying scripts"
cp -r local_share/* ~/.local/share/bin/
echo "Copying cava config"
cp -r config/cava ~/.config/
echo "Copying fastfetch config"
cp -r config/fastfetch ~/.config/
echo "Copying hypr config"
cp -r config/hypr ~/.config/
echo "Copying rofi config"
cp -r config/rofi ~/.config/
echo "Copying waybar"
cp -r config/waybar/ ~/.config/
echo "Copying cursor theme"
cp -r Bibata-Original-Classic usr/share/icons/
cp greetui/config.toml /etc/greetd/


pacman -S --needed --noconfirm git base-devel

tmp_dir=$(mktemp -d)

# YAY INSTALLATION
if ! command -v yay &>/dev/null; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay"

    cd "$tmp_dir/yay" || exit
    makepkg -si --noconfirm

    cd ~ || exit
    rm -rf "$tmp_dir"
else
    echo "yay already installed."
fi

packages=(
    hyprland
    networkmanager
    network-manager-applet
    hyprpicker
    firefox
    waybar
    micro
    kitty
    hyprpolkitagent
    hyprlock
    hypridle
    hyprsunset
    hyprland-qt-support
    hyprqt6engine
    hyprcursor
    hyprutils
    hyprlang
    aquamarine
    hyprgraphics
    hyprland-qtutils
    xdg-desktop-portal-hyprland
    rofi
    thunar
    bat
    btop
    neofetch
    fastfetch
    grim
    slurp
    wl-clipboard
    swww
    swaync
    polkit
    pamixer
    caffeine
    nwg-look
    nwg-displays
    tree
    eza
    zsh
    zsh-completions
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-you-should-use
    zsh-fzf
    zsh-z
    pipewire
    wireplumber
    qt5-wayland
    qt6-wayland
    ttf-jetbrains-mono-nerd
    ttf-nerd-fonts-symbols
    ttf-dejavu
    noto-fonts
    adwaita-icon-theme
    udiskie
    discord
    cava
    blueman
    autocpufreq
    neovim
    feh
    okular
    timeshift
    greetd
    greetd-tuigreet
)

# PACKAGES INSTALLATION

for pkg in "${packages[@]}"; do
    if ! yay -Qi "$pkg" &>/dev/null; then
        echo "Installing $pkg (yay)..."
        yay -S --noconfirm --needed "$pkg" || echo "⚠️ Cannot install $pkg"
    else
        echo "$pkg already installed."
    fi
done

# SERVICES

echo "Enabling services"
systemctl enable NetworkManager.service
systemctl enable greet.service

./set_wallpaper.sh Wallpapers/hypr.png

echo "Hyprladus installation finished!"

read -rp "Do you want to reboot? (Y/n): " answer
if [[ "$answer" == "n" || "$answer" == "N" ]]; then
    echo "Reboot cancelled."
else
    reboot
fi


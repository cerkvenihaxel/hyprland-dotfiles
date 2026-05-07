#!/bin/bash

# ╔══════════════════════════════════════════════════════════════╗
# ║  Hyprland Cyberpunk Dotfiles - Installer                    ║
# ║  Optimizado para laptop HP 4GB RAM                          ║
# ╚══════════════════════════════════════════════════════════════╝

set -e

# Colores para output
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${MAGENTA}"
echo "╔══════════════════════════════════════════════════════════╗"
echo "║     ⚡ HYPRLAND CYBERPUNK INSTALLER ⚡                  ║"
echo "║     Optimizado para 4GB RAM                             ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Verificar que estamos en Arch Linux
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}[ERROR] Este script es solo para Arch Linux${NC}"
    exit 1
fi

# Verificar conexión a internet
if ! ping -c 1 archlinux.org &> /dev/null; then
    echo -e "${RED}[ERROR] Sin conexión a internet${NC}"
    exit 1
fi

echo -e "${CYAN}[1/7] Actualizando sistema...${NC}"
sudo pacman -Syu --noconfirm

echo -e "${CYAN}[2/7] Instalando paquetes base de Hyprland...${NC}"
sudo pacman -S --noconfirm --needed \
    hyprland \
    xdg-desktop-portal-hyprland \
    wezterm \
    wofi \
    waybar \
    dunst \
    polkit-gnome \
    grim \
    slurp \
    wl-clipboard \
    brightnessctl \
    pamixer \
    playerctl \
    network-manager-applet \
    blueman \
    thunar \
    swww \
    hyprpaper \
    hyprlock \
    hypridle

echo -e "${CYAN}[3/7] Instalando fuentes...${NC}"
sudo pacman -S --noconfirm --needed \
    ttf-ubuntu-nerd \
    ttf-jetbrains-mono-nerd \
    noto-fonts \
    noto-fonts-emoji

echo -e "${CYAN}[4/7] Instalando utilidades de optimización...${NC}"
sudo pacman -S --noconfirm --needed \
    zram-generator

echo -e "${CYAN}[5/7] Instalando yay (AUR helper) si no existe...${NC}"
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    cd /tmp/yay-bin
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay-bin
fi

echo -e "${CYAN}[6/7] Instalando paquetes AUR...${NC}"
yay -S --noconfirm --needed \
    waypaper \
    hyprpicker \
    wlogout

echo -e "${CYAN}[7/7] Copiando dotfiles...${NC}"

# Crear directorios necesarios
mkdir -p ~/.config/hypr
mkdir -p ~/.config/wezterm
mkdir -p ~/.config/wofi
mkdir -p ~/.config/waybar
mkdir -p ~/.config/dunst
mkdir -p ~/.config/swww
mkdir -p ~/.config/hypr/wallpapers
mkdir -p ~/.config/wlogout

# Copiar configuraciones
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp "$SCRIPT_DIR/config/hypr/hyprland.conf" ~/.config/hypr/
cp "$SCRIPT_DIR/config/hypr/hyprlock.conf" ~/.config/hypr/
cp "$SCRIPT_DIR/config/hypr/hypridle.conf" ~/.config/hypr/
cp "$SCRIPT_DIR/config/wezterm/wezterm.lua" ~/.config/wezterm/
cp "$SCRIPT_DIR/config/wofi/config" ~/.config/wofi/
cp "$SCRIPT_DIR/config/wofi/style.css" ~/.config/wofi/
cp "$SCRIPT_DIR/config/waybar/config.jsonc" ~/.config/waybar/
cp "$SCRIPT_DIR/config/waybar/style.css" ~/.config/waybar/
cp "$SCRIPT_DIR/config/dunst/dunstrc" ~/.config/dunst/

# Configurar zram para optimizar RAM
echo -e "${YELLOW}[OPT] Configurando zram (swap comprimida en RAM)...${NC}"
sudo tee /etc/systemd/zram-generator.conf > /dev/null <<EOF
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
EOF

# Habilitar servicios
sudo systemctl enable --now systemd-zram-setup@zram0.service 2>/dev/null || true

echo -e "${GREEN}"
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  ✅ INSTALACIÓN COMPLETADA                              ║"
echo "║                                                         ║"
echo "║  Reinicia y selecciona Hyprland en tu display manager   ║"
echo "║  o ejecuta: Hyprland                                    ║"
echo "║                                                         ║"
echo "║  KEYBINDS PRINCIPALES:                                  ║"
echo "║  SUPER + ENTER    → WezTerm                             ║"
echo "║  SUPER + D        → Wofi (launcher)                     ║"
echo "║  SUPER + Q        → Cerrar ventana                      ║"
echo "║  SUPER + W        → Selector de wallpapers              ║"
echo "║  SUPER + L        → Bloquear pantalla                   ║"
echo "║  SUPER + SHIFT+E  → Logout menu                         ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

#!/bin/bash

# ╔══════════════════════════════════════════════════════════════╗
# ║  Hyprland Cyberpunk Dotfiles - Updater                      ║
# ║  Sincroniza configs sin reinstalar paquetes                 ║
# ╚══════════════════════════════════════════════════════════════╝

set -e

CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config/hypr-backup-$(date +%Y%m%d_%H%M%S)"

echo -e "${MAGENTA}"
echo "╔══════════════════════════════════════════════════════════╗"
echo "║     ⚡ HYPRLAND CYBERPUNK UPDATER ⚡                     ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# ─── FUNCIONES ────────────────────────────────────────────────

show_help() {
    echo -e "${CYAN}Uso: ./update.sh [opciones]${NC}"
    echo ""
    echo "  --all          Actualizar todas las configs"
    echo "  --hypr         Solo Hyprland configs"
    echo "  --wezterm      Solo WezTerm config"
    echo "  --wofi         Solo Wofi config"
    echo "  --waybar       Solo Waybar config"
    echo "  --dunst        Solo Dunst config"
    echo "  --packages     Solo actualizar paquetes"
    echo "  --no-backup    No crear backup antes de actualizar"
    echo "  --diff         Mostrar diferencias antes de copiar"
    echo "  --help         Mostrar esta ayuda"
    echo ""
    echo -e "${YELLOW}Sin argumentos se actualiza todo con backup.${NC}"
}

backup_configs() {
    if [ "$NO_BACKUP" = true ]; then
        return
    fi
    echo -e "${YELLOW}[BACKUP] Guardando configs actuales en: $BACKUP_DIR${NC}"
    mkdir -p "$BACKUP_DIR"
    [ -d ~/.config/hypr ] && cp -r ~/.config/hypr "$BACKUP_DIR/" 2>/dev/null || true
    [ -d ~/.config/wezterm ] && cp -r ~/.config/wezterm "$BACKUP_DIR/" 2>/dev/null || true
    [ -d ~/.config/wofi ] && cp -r ~/.config/wofi "$BACKUP_DIR/" 2>/dev/null || true
    [ -d ~/.config/waybar ] && cp -r ~/.config/waybar "$BACKUP_DIR/" 2>/dev/null || true
    [ -d ~/.config/dunst ] && cp -r ~/.config/dunst "$BACKUP_DIR/" 2>/dev/null || true
    echo -e "${GREEN}[BACKUP] ✓ Backup creado${NC}"
}

show_diff() {
    local src="$1"
    local dst="$2"
    if [ -f "$dst" ]; then
        if ! diff -q "$src" "$dst" > /dev/null 2>&1; then
            echo -e "${YELLOW}─── Cambios en: $dst ───${NC}"
            diff --color=always "$dst" "$src" 2>/dev/null || true
            echo ""
        fi
    else
        echo -e "${GREEN}[NUEVO] $dst${NC}"
    fi
}

copy_config() {
    local src="$1"
    local dst="$2"
    local dir=$(dirname "$dst")
    mkdir -p "$dir"
    if [ -f "$src" ]; then
        cp "$src" "$dst"
        echo -e "  ${GREEN}✓${NC} $dst"
    else
        echo -e "  ${RED}✗${NC} No encontrado: $src"
    fi
}

update_hypr() {
    echo -e "${CYAN}[UPDATE] Hyprland configs...${NC}"
    mkdir -p ~/.config/hypr/wallpapers
    if [ "$SHOW_DIFF" = true ]; then
        show_diff "$SCRIPT_DIR/config/hypr/hyprland.conf" ~/.config/hypr/hyprland.conf
        show_diff "$SCRIPT_DIR/config/hypr/hyprlock.conf" ~/.config/hypr/hyprlock.conf
        show_diff "$SCRIPT_DIR/config/hypr/hypridle.conf" ~/.config/hypr/hypridle.conf
    fi
    copy_config "$SCRIPT_DIR/config/hypr/hyprland.conf" ~/.config/hypr/hyprland.conf
    copy_config "$SCRIPT_DIR/config/hypr/hyprlock.conf" ~/.config/hypr/hyprlock.conf
    copy_config "$SCRIPT_DIR/config/hypr/hypridle.conf" ~/.config/hypr/hypridle.conf
}

update_wezterm() {
    echo -e "${CYAN}[UPDATE] WezTerm config...${NC}"
    mkdir -p ~/.config/wezterm
    if [ "$SHOW_DIFF" = true ]; then
        show_diff "$SCRIPT_DIR/config/wezterm/wezterm.lua" ~/.config/wezterm/wezterm.lua
    fi
    copy_config "$SCRIPT_DIR/config/wezterm/wezterm.lua" ~/.config/wezterm/wezterm.lua
}

update_wofi() {
    echo -e "${CYAN}[UPDATE] Wofi config...${NC}"
    mkdir -p ~/.config/wofi
    if [ "$SHOW_DIFF" = true ]; then
        show_diff "$SCRIPT_DIR/config/wofi/config" ~/.config/wofi/config
        show_diff "$SCRIPT_DIR/config/wofi/style.css" ~/.config/wofi/style.css
    fi
    copy_config "$SCRIPT_DIR/config/wofi/config" ~/.config/wofi/config
    copy_config "$SCRIPT_DIR/config/wofi/style.css" ~/.config/wofi/style.css
}

update_waybar() {
    echo -e "${CYAN}[UPDATE] Waybar config...${NC}"
    mkdir -p ~/.config/waybar
    if [ "$SHOW_DIFF" = true ]; then
        show_diff "$SCRIPT_DIR/config/waybar/config.jsonc" ~/.config/waybar/config.jsonc
        show_diff "$SCRIPT_DIR/config/waybar/style.css" ~/.config/waybar/style.css
    fi
    copy_config "$SCRIPT_DIR/config/waybar/config.jsonc" ~/.config/waybar/config.jsonc
    copy_config "$SCRIPT_DIR/config/waybar/style.css" ~/.config/waybar/style.css
}

update_dunst() {
    echo -e "${CYAN}[UPDATE] Dunst config...${NC}"
    mkdir -p ~/.config/dunst
    if [ "$SHOW_DIFF" = true ]; then
        show_diff "$SCRIPT_DIR/config/dunst/dunstrc" ~/.config/dunst/dunstrc
    fi
    copy_config "$SCRIPT_DIR/config/dunst/dunstrc" ~/.config/dunst/dunstrc
}

update_packages() {
    echo -e "${CYAN}[UPDATE] Verificando paquetes...${NC}"
    local PACKAGES=(
        hyprland xdg-desktop-portal-hyprland wezterm wofi waybar dunst
        polkit-gnome grim slurp wl-clipboard brightnessctl pamixer
        playerctl network-manager-applet blueman thunar swww hyprpaper
        hyprlock hypridle ttf-ubuntu-nerd ttf-jetbrains-mono-nerd
        noto-fonts noto-fonts-emoji zram-generator
    )

    local MISSING=()
    for pkg in "${PACKAGES[@]}"; do
        if ! pacman -Qi "$pkg" &> /dev/null; then
            MISSING+=("$pkg")
        fi
    done

    if [ ${#MISSING[@]} -gt 0 ]; then
        echo -e "${YELLOW}  Instalando paquetes faltantes: ${MISSING[*]}${NC}"
        sudo pacman -S --noconfirm --needed "${MISSING[@]}"
    else
        echo -e "${GREEN}  ✓ Todos los paquetes están instalados${NC}"
    fi

    # AUR packages
    if command -v yay &> /dev/null; then
        local AUR_PACKAGES=(waypaper hyprpicker wlogout)
        local AUR_MISSING=()
        for pkg in "${AUR_PACKAGES[@]}"; do
            if ! pacman -Qi "$pkg" &> /dev/null; then
                AUR_MISSING+=("$pkg")
            fi
        done
        if [ ${#AUR_MISSING[@]} -gt 0 ]; then
            echo -e "${YELLOW}  Instalando AUR faltantes: ${AUR_MISSING[*]}${NC}"
            yay -S --noconfirm --needed "${AUR_MISSING[@]}"
        else
            echo -e "${GREEN}  ✓ Todos los paquetes AUR están instalados${NC}"
        fi
    fi
}

reload_services() {
    echo -e "${CYAN}[RELOAD] Recargando servicios...${NC}"
    # Recargar waybar
    if pgrep waybar > /dev/null; then
        killall waybar 2>/dev/null || true
        sleep 0.5
        waybar &disown
        echo -e "  ${GREEN}✓${NC} Waybar recargado"
    fi
    # Recargar dunst
    if pgrep dunst > /dev/null; then
        killall dunst 2>/dev/null || true
        dunst &disown
        echo -e "  ${GREEN}✓${NC} Dunst recargado"
    fi
    # Hyprland se recarga automáticamente al detectar cambios en el config
    echo -e "  ${GREEN}✓${NC} Hyprland se recarga automáticamente"
}

# ─── PARSEAR ARGUMENTOS ──────────────────────────────────────

NO_BACKUP=false
SHOW_DIFF=false
UPDATE_ALL=true
UPDATE_HYPR=false
UPDATE_WEZTERM=false
UPDATE_WOFI=false
UPDATE_WAYBAR=false
UPDATE_DUNST=false
UPDATE_PACKAGES=false

if [ $# -gt 0 ]; then
    UPDATE_ALL=false
    for arg in "$@"; do
        case $arg in
            --all) UPDATE_ALL=true ;;
            --hypr) UPDATE_HYPR=true ;;
            --wezterm) UPDATE_WEZTERM=true ;;
            --wofi) UPDATE_WOFI=true ;;
            --waybar) UPDATE_WAYBAR=true ;;
            --dunst) UPDATE_DUNST=true ;;
            --packages) UPDATE_PACKAGES=true ;;
            --no-backup) NO_BACKUP=true ;;
            --diff) SHOW_DIFF=true ;;
            --help) show_help; exit 0 ;;
            *) echo -e "${RED}Opción desconocida: $arg${NC}"; show_help; exit 1 ;;
        esac
    done
fi

# ─── EJECUTAR ────────────────────────────────────────────────

# Pull cambios del repo si es git
if [ -d "$SCRIPT_DIR/.git" ]; then
    echo -e "${CYAN}[GIT] Obteniendo últimos cambios...${NC}"
    git -C "$SCRIPT_DIR" pull --rebase 2>/dev/null && \
        echo -e "  ${GREEN}✓${NC} Repo actualizado" || \
        echo -e "  ${YELLOW}⚠${NC} No se pudo hacer pull (sin conexión o conflictos)"
fi

backup_configs

if [ "$UPDATE_ALL" = true ]; then
    update_packages
    update_hypr
    update_wezterm
    update_wofi
    update_waybar
    update_dunst
else
    [ "$UPDATE_PACKAGES" = true ] && update_packages
    [ "$UPDATE_HYPR" = true ] && update_hypr
    [ "$UPDATE_WEZTERM" = true ] && update_wezterm
    [ "$UPDATE_WOFI" = true ] && update_wofi
    [ "$UPDATE_WAYBAR" = true ] && update_waybar
    [ "$UPDATE_DUNST" = true ] && update_dunst
fi

reload_services

echo -e "${GREEN}"
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  ✅ ACTUALIZACIÓN COMPLETADA                            ║"
echo "║  Backup en: $BACKUP_DIR"
echo "╚══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

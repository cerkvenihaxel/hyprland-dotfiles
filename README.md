# ⚡ Hyprland Cyberpunk Dotfiles

Configuración de Hyprland con estética **cyberpunk/neon** optimizada para laptops con recursos limitados (4GB RAM).

## 🎨 Paleta de Colores

| Color | Hex | Uso |
|-------|-----|-----|
| Magenta Neon | `#ff00ff` | Bordes activos, acentos principales |
| Cyan Neon | `#00ffff` | Texto destacado, bordes secundarios |
| Rosa Neon | `#ff0055` | Alertas, errores |
| Verde Neon | `#00ff9f` | Éxito, CPU |
| Azul Neon | `#00aaff` | Memoria, info |
| Amarillo Neon | `#ffb800` | Warnings, temperatura |
| Fondo Oscuro | `#0d0d1a` | Background principal |
| Fondo Secundario | `#1a1a2e` | Paneles, cards |

## 📦 Componentes

| Componente | Paquete |
|-----------|---------|
| Window Manager | Hyprland |
| Terminal | WezTerm |
| Launcher | Wofi |
| Bar | Waybar |
| Notificaciones | Dunst |
| Wallpaper daemon | swww |
| Wallpaper selector | waypaper |
| Lock screen | Hyprlock |
| Idle manager | Hypridle |
| Screenshots | grim + slurp |
| Logout | wlogout |

## ⌨️ Keybindings Principales

| Atajo | Acción |
|-------|--------|
| `SUPER + Enter` | Terminal (WezTerm) |
| `SUPER + D` | Launcher (Wofi) |
| `SUPER + Q` | Cerrar ventana |
| `SUPER + F` | Fullscreen |
| `SUPER + V` | Floating toggle |
| `SUPER + W` | Selector de wallpapers |
| `SUPER + L` | Bloquear pantalla |
| `SUPER + B` | Navegador |
| `SUPER + E` | Explorador de archivos |
| `SUPER + SHIFT + E` | Menú de logout |
| `SUPER + 1-0` | Cambiar workspace |
| `SUPER + SHIFT + 1-0` | Mover ventana a workspace |
| `Print` | Screenshot (selección) |
| `SHIFT + Print` | Screenshot (pantalla completa) |

## 🚀 Optimizaciones para 4GB RAM

1. **zram**: Swap comprimida en RAM con zstd (más eficiente que swap en disco)
2. **VFR activado**: Variable Frame Rate reduce uso de GPU cuando no hay cambios
3. **Blur mínimo**: 1 pass con size 4 (balance visual/rendimiento)
4. **Animaciones rápidas**: Duración de 3ms, sin animaciones de resize
5. **Swallowing**: WezTerm absorbe ventanas de apps lanzadas desde terminal
6. **WezTerm LowPower**: WebGPU en modo bajo consumo, scrollback reducido
7. **Waybar ligero**: Solo módulos esenciales, intervalos de actualización largos
8. **Hypridle agresivo**: Suspende a los 15 min, apaga pantalla a los 5.5 min

## 📥 Instalación

```bash
git clone <este-repo> ~/hyprland-dotfiles
cd ~/hyprland-dotfiles
chmod +x install.sh
./install.sh
```

## 🖼️ Wallpapers

Usa `SUPER + W` para abrir **waypaper** y seleccionar wallpapers.
Los wallpapers se guardan en `~/.config/hypr/wallpapers/`.

Para descargar wallpapers cyberpunk:
```bash
# Buscar wallpapers en archlinux.org/art o usar waypaper para gestionar
```

## 📁 Estructura

```
~/.config/
├── hypr/
│   ├── hyprland.conf      # Config principal
│   ├── hyprlock.conf      # Lock screen
│   ├── hypridle.conf      # Idle/power management
│   └── wallpapers/        # Tus wallpapers
├── wezterm/
│   └── wezterm.lua        # Terminal config
├── wofi/
│   ├── config             # Launcher config
│   └── style.css          # Launcher theme
├── waybar/
│   ├── config.jsonc       # Bar config
│   └── style.css          # Bar theme
└── dunst/
    └── dunstrc            # Notifications
```

## 🔧 Post-instalación

1. Coloca un wallpaper en `~/.config/hypr/wallpapers/default.png`
2. Reinicia o ejecuta `Hyprland` desde TTY
3. Ajusta el layout del teclado en `hyprland.conf` si no usas `latam`
4. Configura tu display manager (SDDM/GDM) para ofrecer Hyprland como opción

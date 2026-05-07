# ⚡ Hyprland Cyberpunk Dotfiles

Configuración de Hyprland con estética **cyberpunk/neon** optimizada para laptops con recursos limitados (4GB RAM).

## 📥 Instalación

```bash
git clone <este-repo> ~/hyprland-dotfiles
cd ~/hyprland-dotfiles
chmod +x install.sh update.sh
./install.sh
```

## 🔄 Actualizar Configs

Cuando hagas cambios en el repo, solo ejecuta:

```bash
cd ~/hyprland-dotfiles
./update.sh
```

El updater automáticamente:
1. Hace `git pull` para obtener los últimos cambios
2. Crea un backup de tus configs actuales
3. Copia las nuevas configs
4. Verifica paquetes faltantes
5. Recarga waybar y dunst (Hyprland se recarga solo)

### Opciones de update.sh

```bash
./update.sh --all          # Actualizar todo (default)
./update.sh --hypr         # Solo Hyprland
./update.sh --wezterm      # Solo WezTerm
./update.sh --wofi         # Solo Wofi
./update.sh --waybar       # Solo Waybar
./update.sh --dunst        # Solo Dunst
./update.sh --packages     # Solo verificar/instalar paquetes
./update.sh --diff         # Mostrar diferencias antes de copiar
./update.sh --no-backup    # Sin backup (más rápido)

# Combinaciones:
./update.sh --hypr --waybar --diff
```

---

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

---

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

---

## 🪟 Tiling en Hyprland

Hyprland usa el layout **dwindle** por defecto (divide el espacio como un árbol binario). Cada ventana nueva ocupa la mitad del espacio disponible.

### Keybindings de Tiling

| Atajo | Acción |
|-------|--------|
| `SUPER + Enter` | Abrir terminal (se posiciona automáticamente) |
| `SUPER + Q` | Cerrar ventana activa |
| `SUPER + V` | Toggle floating (sacar/meter del tiling) |
| `SUPER + F` | Fullscreen (ventana ocupa todo) |
| `SUPER + P` | Pseudo-tile (ventana mantiene su tamaño preferido) |
| `SUPER + J` | Toggle split (cambiar dirección de división H/V) |

### Mover Foco entre Ventanas

| Atajo | Acción |
|-------|--------|
| `SUPER + ←` | Foco a la izquierda |
| `SUPER + →` | Foco a la derecha |
| `SUPER + ↑` | Foco arriba |
| `SUPER + ↓` | Foco abajo |

### Mover Ventanas en el Tiling

| Atajo | Acción |
|-------|--------|
| `SUPER + SHIFT + ←` | Mover ventana a la izquierda |
| `SUPER + SHIFT + →` | Mover ventana a la derecha |
| `SUPER + SHIFT + ↑` | Mover ventana arriba |
| `SUPER + SHIFT + ↓` | Mover ventana abajo |

### Redimensionar Ventanas

| Atajo | Acción |
|-------|--------|
| `SUPER + CTRL + ←` | Reducir ancho (-30px) |
| `SUPER + CTRL + →` | Aumentar ancho (+30px) |
| `SUPER + CTRL + ↑` | Reducir alto (-30px) |
| `SUPER + CTRL + ↓` | Aumentar alto (+30px) |

### Mouse en Tiling

| Atajo | Acción |
|-------|--------|
| `SUPER + Click izq + arrastrar` | Mover ventana (la saca a floating) |
| `SUPER + Click der + arrastrar` | Redimensionar ventana |
| `SUPER + Scroll` | Cambiar workspace |

### Cómo funciona Dwindle

```
┌──────────────────────────────┐
│              1               │  ← Primera ventana (ocupa todo)
└──────────────────────────────┘

┌──────────────┬───────────────┐
│              │               │  ← Segunda ventana (divide en 2)
│      1       │       2       │
│              │               │
└──────────────┴───────────────┘

┌──────────────┬───────────────┐
│              │       2       │
│      1       ├───────────────┤  ← Tercera (divide la mitad derecha)
│              │       3       │
└──────────────┴───────────────┘

┌──────────────┬───────────────┐
│              │       2       │
│      1       ├───────┬───────┤  ← Cuarta (divide la esquina)
│              │   3   │   4   │
└──────────────┴───────┴───────┘
```

Usa `SUPER + J` para cambiar si la siguiente ventana divide horizontal o verticalmente.

---

## 🪟 Tiling/Splits en WezTerm

WezTerm tiene su propio sistema de paneles (splits) dentro de una sola ventana.

### Keybindings de WezTerm

| Atajo | Acción |
|-------|--------|
| `CTRL + SHIFT + T` | Nueva pestaña |
| `CTRL + SHIFT + W` | Cerrar pestaña |
| `CTRL + SHIFT + C` | Copiar |
| `CTRL + SHIFT + V` | Pegar |
| `CTRL + SHIFT + F` | Fullscreen |
| `CTRL + SHIFT + "` | Split horizontal (panel abajo) |
| `CTRL + SHIFT + %` | Split vertical (panel a la derecha) |
| `CTRL + SHIFT + Z` | Zoom panel (toggle fullscreen del panel) |
| `CTRL + SHIFT + ←/→/↑/↓` | Mover foco entre paneles |
| `ALT + SHIFT + ←/→/↑/↓` | Redimensionar panel activo |

### Ejemplo de Splits en WezTerm

```
┌─────────────────────────────────────┐
│  Tab 1  │  Tab 2  │  Tab 3         │  ← Pestañas abajo
├──────────────────┬──────────────────┤
│                  │                  │
│   Panel 1        │   Panel 2       │  ← CTRL+SHIFT+%
│   (vim)          │   (htop)        │
│                  │                  │
├──────────────────┴──────────────────┤
│                                     │
│   Panel 3 (terminal general)        │  ← CTRL+SHIFT+"
│                                     │
└─────────────────────────────────────┘
```

### Tip: Combinar ambos

- Usa **Hyprland tiling** para organizar ventanas de diferentes apps (browser, terminal, file manager)
- Usa **WezTerm splits** cuando necesitas múltiples terminales visibles a la vez sin crear ventanas nuevas
- `SUPER + V` saca una ventana del tiling si necesitas que flote encima

---

## ⌨️ Todos los Keybindings

### Aplicaciones

| Atajo | Acción |
|-------|--------|
| `SUPER + Enter` | Terminal (WezTerm) |
| `SUPER + D` | Launcher (Wofi) |
| `SUPER + Q` | Cerrar ventana |
| `SUPER + F` | Fullscreen |
| `SUPER + V` | Floating toggle |
| `SUPER + W` | Selector de wallpapers (waypaper) |
| `SUPER + L` | Bloquear pantalla |
| `SUPER + B` | Navegador |
| `SUPER + E` | Explorador de archivos (Thunar) |
| `SUPER + SHIFT + E` | Menú de logout |
| `SUPER + SHIFT + Q` | Salir de Hyprland |

### Workspaces

| Atajo | Acción |
|-------|--------|
| `SUPER + 1-0` | Cambiar a workspace 1-10 |
| `SUPER + SHIFT + 1-0` | Mover ventana a workspace 1-10 |
| `SUPER + Scroll` | Siguiente/anterior workspace |

### Media y Hardware

| Atajo | Acción |
|-------|--------|
| `XF86AudioRaiseVolume` | Subir volumen (+5%) |
| `XF86AudioLowerVolume` | Bajar volumen (-5%) |
| `XF86AudioMute` | Mute toggle |
| `XF86AudioPlay` | Play/Pause |
| `XF86AudioNext/Prev` | Siguiente/anterior canción |
| `XF86MonBrightnessUp` | Subir brillo (+5%) |
| `XF86MonBrightnessDown` | Bajar brillo (-5%) |

### Screenshots

| Atajo | Acción |
|-------|--------|
| `Print` | Screenshot de selección (al clipboard) |
| `SHIFT + Print` | Screenshot de pantalla completa |

---

## 🚀 Optimizaciones para 4GB RAM

1. **zram**: Swap comprimida en RAM con zstd (más eficiente que swap en disco)
2. **VFR activado**: Variable Frame Rate reduce uso de GPU cuando no hay cambios
3. **Blur mínimo**: 1 pass con size 4 (balance visual/rendimiento)
4. **Animaciones rápidas**: Duración de 3ms, sin animaciones de resize
5. **Swallowing**: WezTerm absorbe ventanas de apps lanzadas desde terminal
6. **WezTerm LowPower**: WebGPU en modo bajo consumo, scrollback reducido a 3000 líneas
7. **Waybar ligero**: Solo módulos esenciales, intervalos de actualización de 5-10s
8. **Hypridle agresivo**: Suspende a los 15 min, apaga pantalla a los 5.5 min
9. **VRR**: Variable Refresh Rate para reducir consumo de GPU

---

## 🖼️ Wallpapers

Usa `SUPER + W` para abrir **waypaper** y seleccionar wallpapers.
Los wallpapers se guardan en `~/.config/hypr/wallpapers/`.

---

## 📁 Estructura del Repo

```
hyprland-dotfiles/
├── install.sh              # Instalación completa (primera vez)
├── update.sh               # Actualizar configs (cambios posteriores)
├── README.md
└── config/
    ├── hypr/
    │   ├── hyprland.conf   # Config principal + keybindings
    │   ├── hyprlock.conf   # Lock screen cyberpunk
    │   └── hypridle.conf   # Power management
    ├── wezterm/
    │   └── wezterm.lua     # Terminal config + colores
    ├── wofi/
    │   ├── config          # Launcher opciones
    │   └── style.css       # Launcher theme neon
    ├── waybar/
    │   ├── config.jsonc    # Bar módulos
    │   └── style.css       # Bar theme neon
    └── dunst/
        └── dunstrc         # Notificaciones
```

## 🔧 Workflow

```bash
# Primera instalación en la laptop:
git clone <repo> ~/hyprland-dotfiles
cd ~/hyprland-dotfiles
./install.sh

# Después de hacer cambios en el repo (desde cualquier PC):
cd ~/hyprland-dotfiles
./update.sh

# Solo actualizar una parte:
./update.sh --waybar --diff

# Ver qué cambió antes de aplicar:
./update.sh --diff
```

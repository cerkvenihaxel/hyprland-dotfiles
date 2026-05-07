-- ╔══════════════════════════════════════════════════════════════╗
-- ║  WezTerm Config - Cyberpunk Neon Theme                      ║
-- ║  Optimizado para bajo consumo de RAM                        ║
-- ╚══════════════════════════════════════════════════════════════╝

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ─── FUENTE ──────────────────────────────────────────────────
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" })
config.font_size = 11.0
config.line_height = 1.1

-- ─── COLORES CYBERPUNK ───────────────────────────────────────
config.colors = {
    foreground = "#e0e0e0",
    background = "#0d0d1a",
    cursor_bg = "#ff00ff",
    cursor_fg = "#0d0d1a",
    cursor_border = "#ff00ff",
    selection_fg = "#0d0d1a",
    selection_bg = "#00ffff",

    ansi = {
        "#1a1a2e",  -- black
        "#ff0055",  -- red
        "#00ff9f",  -- green
        "#ffb800",  -- yellow
        "#00aaff",  -- blue
        "#ff00ff",  -- magenta
        "#00ffff",  -- cyan
        "#e0e0e0",  -- white
    },
    brights = {
        "#4a4a6a",  -- bright black
        "#ff3377",  -- bright red
        "#33ffb5",  -- bright green
        "#ffcc33",  -- bright yellow
        "#33bbff",  -- bright blue
        "#ff33ff",  -- bright magenta
        "#33ffff",  -- bright cyan
        "#ffffff",  -- bright white
    },

    tab_bar = {
        background = "#0a0a14",
        active_tab = {
            bg_color = "#1a1a2e",
            fg_color = "#00ffff",
        },
        inactive_tab = {
            bg_color = "#0d0d1a",
            fg_color = "#4a4a6a",
        },
        inactive_tab_hover = {
            bg_color = "#1a1a2e",
            fg_color = "#ff00ff",
        },
    },
}

-- ─── VENTANA ─────────────────────────────────────────────────
config.window_background_opacity = 0.92
config.window_padding = {
    left = 12,
    right = 12,
    top = 8,
    bottom = 8,
}
config.window_decorations = "NONE"
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

-- ─── OPTIMIZACIONES DE RENDIMIENTO ──────────────────────────
config.front_end = "OpenGL"
config.enable_wayland = true
config.max_fps = 60
config.animation_fps = 30
config.cursor_blink_rate = 500
config.enable_scroll_bar = false
config.scrollback_lines = 3000  -- Reducido para ahorrar RAM

-- ─── KEYBINDINGS ─────────────────────────────────────────────
config.keys = {
    -- Clipboard
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

    -- Tabs
    { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
    { key = "f", mods = "CTRL|SHIFT", action = wezterm.action.ToggleFullScreen },

    -- Splits (tiling dentro de WezTerm)
    { key = "\"", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "%", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

    -- Navegar entre paneles
    { key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
    { key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },

    -- Redimensionar paneles
    { key = "LeftArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
    { key = "RightArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
    { key = "UpArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
    { key = "DownArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },

    -- Zoom panel (toggle)
    { key = "z", mods = "CTRL|SHIFT", action = wezterm.action.TogglePaneZoomState },

    -- Cerrar panel actual
    { key = "x", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}

return config

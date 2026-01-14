local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_domain = 'WSL:Ubuntu'

config.color_scheme = 'Aura (Gogh)'
config.font = wezterm.font('JetBrains Mono')
config.font_size = 12
config.window_background_opacity = 1
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 10000

config.keys = {
  -- split pane
  { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Up' } },
  { key = 'a', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Left' } },
  { key = 's', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Down' } },
  { key = 'd', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Right' } },

  -- pane navigation
  { key = 'w', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'a', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 's', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'd', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },

  -- close pane
  { key = 'q', mods = 'ALT', action = wezterm.action.CloseCurrentPane { confirm = true } },
}

return config
local wezterm = require 'wezterm'
local config = {}

-- Appearance
config.hide_tab_bar_if_only_one_tab = true

-- Fonts
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 14.0

-- Colorscheme
config.color_scheme = 'Everforest Dark (Gogh)'

return config

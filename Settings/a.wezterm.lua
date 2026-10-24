-- Pull in the wezterm API
local wezterm = require 'wezterm'
-- =============================



-- This will hold the configuration.
local config = wezterm.config_builder()

-- Changing the color scheme:
-- config.color_scheme = 'SeaShells'
-- config.color_scheme = 'PencilDark'
-- config.color_scheme = 'Dracula'
-- config.color_scheme = 'Pandora'
-- config.color_scheme = 'ollie'
-- config.color_scheme = 'Obsidian'
-- config.color_scheme = 'Red Planet'
-- config.color_scheme = 'Relaxed'
-- config.color_scheme = 'Royal'
-- config.color_scheme = 'SeaShells'
-- config.color_scheme = 'Seti'
-- config.color_scheme = 'Shaman'
-- config.color_scheme = 'Slate'
-- config.color_scheme = 'Spacedust'
-- config.color_scheme = 'Spiderman'
-- config.color_scheme = 'Symfonic'
config.color_scheme = 'UnderTheSea'
--config.color_scheme = 'WildCherry'


-- Changing the font:
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14

-- Changing windows top and size:
config.window_decorations = "TITLE | RESIZE"

-- Changing window opacity:
config.window_background_opacity = 0.5
config.macos_window_background_blur = 10

-- Hide the tab bar if there is only one tab
config.hide_tab_bar_if_only_one_tab = true

-- =============================
-- Return the configuration to wezterm
return config


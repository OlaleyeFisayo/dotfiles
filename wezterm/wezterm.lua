local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- WSL Configuration
config.default_domain = "WSL:Ubuntu"
config.default_cwd = "~"

-- Appearances
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_background_image = wezterm.config_dir .. '/assets/bg-gradient.jpg'
config.window_background_image_hsb = {
  brightness = 0.08,
}
config.colors = {
  cursor_bg = "white",
  cursor_border = "white",
}

-- Keybindings
config.keys = {
  {
    key = "t",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
}

-- Your other config options
config.font_size = 10
config.line_height = 1.2
config.animation_fps = 60
config.cursor_blink_rate = 800
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"
config.automatically_reload_config = true

return config

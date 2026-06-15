local wezterm = require('wezterm')

local theme = '{{theme_wezterm}}'

local config = {
  color_scheme = theme,

  font_size = 8,
  font = wezterm.font('JetBrainsMono Nerd Font'),

  default_cursor_style = 'BlinkingBar',

  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  show_new_tab_button_in_tab_bar = false,
}

return config

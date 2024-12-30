local wezterm = require('wezterm')

local config = {
  color_scheme = 'Catppuccin Mocha',

  font_size = 8,
  font = wezterm.font('JetBrainsMono Nerd Font'),

  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,
  show_new_tab_button_in_tab_bar = false,
  default_cursor_style = 'BlinkingBar',
}

return config

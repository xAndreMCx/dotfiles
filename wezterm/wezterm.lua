local wezterm = require('wezterm')

local function merge_tables(...)
  local merged = {}
  for _, tbl in ipairs({ ... }) do
    for key, value in pairs(tbl) do
      merged[key] = value
    end
  end
  return merged
end

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.font_size = 8
config.font = wezterm.font('JetBrainsMono Nerd Font')

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

config.default_cursor_style = 'BlinkingBar'
config.audible_bell = 'Disabled'

config = merge_tables(config, require('keybinds'))

return config

local wezterm = require('wezterm')

local config = {
  disable_default_key_bindings = true,
  leader = { key = ' ', mods = 'SHIFT', timeout_milliseconds = 3000 },
  keys = {
    -- {
    --   key = 'p',
    --   mods = 'LEADER',
    --   action = wezterm.action.ActivateCommandPalette,
    -- },
    -- {
    --   key = 'l',
    --   mods = 'LEADER',
    --   action = wezterm.action.ShowLauncher,
    -- },
    -- font size
    {
      key = '=',
      mods = 'CTRL',
      action = wezterm.action.IncreaseFontSize,
    },
    {
      key = '-',
      mods = 'CTRL',
      action = wezterm.action.DecreaseFontSize,
    },
    {
      key = '0',
      mods = 'CTRL',
      action = wezterm.action.ResetFontSize,
    },

    {
      key = 'L',
      mods = 'ALT|CTRL',
      action = wezterm.action.ShowDebugOverlay,
    },
  },
}

return config

local wezterm = require('wezterm')
local config = {
  disable_default_key_bindings = true,
  leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 5000 },
  keys = {
    {
      key = 't',
      mods = 'LEADER',
      action = wezterm.action.SpawnTab('CurrentPaneDomain'),
    },
    {
      key = 'q',
      mods = 'LEADER',
      action = wezterm.action.CloseCurrentPane({ confirm = false }),
    },
    {
      key = 'v',
      mods = 'LEADER',
      action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },
    {
      key = 'h',
      mods = 'LEADER',
      action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },

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
      mods = 'ALT',
      action = wezterm.action.ShowDebugOverlay,
    },
  },
}

-- tab switching
for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

return config

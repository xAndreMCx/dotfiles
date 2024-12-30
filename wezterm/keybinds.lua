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
      key = 'h',
      mods = 'LEADER',
      action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },
    {
      key = 'v',
      mods = 'LEADER',
      action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },
  },
}

for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

return config

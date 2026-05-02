local wezterm = require('wezterm')
local resurrect = wezterm.plugin.require('https://github.com/MLFlexer/resurrect.wezterm')

local config = {
  disable_default_key_bindings = true,
  leader = { key = ' ', mods = 'SHIFT', timeout_milliseconds = 3000 },
  keys = {
    {
      key = 'p',
      mods = 'LEADER',
      action = wezterm.action.ActivateCommandPalette,
    },
    {
      key = 'l',
      mods = 'LEADER',
      action = wezterm.action.ShowLauncher,
    },
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

    -- resurrect
    {
      key = 'w',
      mods = 'LEADER',
      action = wezterm.action_callback(function(win, pane)
        resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
      end),
    },
    {
      key = 'r',
      mods = 'LEADER',
      action = wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
          local type = string.match(id, '^([^/]+)') -- match before '/'
          id = string.match(id, '([^/]+)$') -- match after '/'
          id = string.match(id, '(.+)%..+$') -- remove file extention
          local opts = {
            close_open_tabs = true,
            window = pane:window(),
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
            relative = true,
            restore_text = true,
          }
          local state = resurrect.state_manager.load_state(id, 'workspace')
          wezterm.mux.rename_workspace(win:active_workspace(), id)
          resurrect.workspace_state.restore_workspace(state, opts)
        end)
      end),
    },
    {
      key = 'd',
      mods = 'LEADER',
      action = wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id)
          resurrect.state_manager.delete_state(id)
        end, {
          title = 'Delete State',
          description = 'Select State to Delete and press Enter = accept, Esc = cancel, / = filter',
          fuzzy_description = 'Search State to Delete: ',
          is_fuzzy = true,
        })
      end),
    },
    {
      key = 'n',
      mods = 'LEADER',
      action = wezterm.action.PromptInputLine({
        description = wezterm.format({
          { Attribute = { Intensity = 'Bold' } },
          { Foreground = { AnsiColor = 'Fuchsia' } },
          { Text = 'Rename Workspace: ' },
        }),
        action = wezterm.action_callback(function(window, pane, line)
          if line and #line > 0 then
            wezterm.mux.rename_workspace(window:active_workspace(), line)
          end
        end),
      }),
    },
  },
}

-- tab switching
for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

return config

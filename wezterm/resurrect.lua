local wezterm = require('wezterm')
local resurrect = wezterm.plugin.require('https://github.com/MLFlexer/resurrect.wezterm')

local M = {}

M.setup = function()
  wezterm.on('gui-startup', resurrect.state_manager.resurrect_on_gui_startup)

  wezterm.time_since_last_tick = 0
  wezterm.on('update-status', function(window, pane)
    local name = window:active_workspace()
    if name == 'default' then
      return
    end

    local now = os.time()
    if not wezterm.last_save_time or now - wezterm.last_save_time > 300 then
      local state = resurrect.workspace_state.get_workspace_state()
      resurrect.state_manager.save_state(state)
      wezterm.last_save_time = now
    end
  end)

  wezterm.on('window-closed', function(window)
    local name = window:active_workspace()

    if name ~= 'default' then
      local state = resurrect.workspace_state.get_workspace_state()
      resurrect.state_manager.save_state(state)
    end
  end)
end

return M

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
config.audible_bell = 'Disabled'

-- Allow Wayland/Hyprland to settle window geometry before Zellij queries PTY dimensions
config.default_prog = { 'sh', '-c', 'sleep 0.05 && exec zellij "$@"', '--' }

local keybinds = require('keybinds')
local appearance = require('appearance')
local config_full = merge_tables(config, keybinds, appearance)

return config_full

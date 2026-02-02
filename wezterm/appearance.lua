local wezterm = require('wezterm')

local LEFT_EDGE = wezterm.nerdfonts.ple_left_half_circle_thick
local RIGHT_EDGE = wezterm.nerdfonts.ple_right_half_circle_thick
local theme = 'Tokyo Night'
local colors = wezterm.get_builtin_color_schemes()[theme]

local config = {
  color_scheme = theme,

  font_size = 8,
  font = wezterm.font('JetBrainsMono Nerd Font'),

  default_cursor_style = 'BlinkingBar',

  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,
  show_new_tab_button_in_tab_bar = false,
}

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local edge_background = colors.tab_bar.background
  local background = colors.tab_bar.inactive_tab.bg_color
  local foreground = colors.tab_bar.inactive_tab.fg_color

  if tab.is_active then
    background = colors.tab_bar.active_tab.bg_color
    foreground = colors.tab_bar.active_tab.fg_color
  elseif hover then
    background = colors.tab_bar.inactive_tab_hover.bg_color
    foreground = colors.tab_bar.inactive_tab_hover.fg_color
  end

  local edge_foreground = background

  local title = tab_title(tab)

  -- ensure that the titles fit in the available space,
  -- and that we have room for the edges.
  title = wezterm.truncate_right(title, max_width - 4)

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = LEFT_EDGE },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = ' ' .. title .. ' ' },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = RIGHT_EDGE },
  }
end)

return config

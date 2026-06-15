local terminal = "wezterm start --always-new-process"
local file_browser = "pcmanfm-qt"
local launcher = "rofi -show drun"
local calculator = "rofi -show calc -modi calc"
local web_browser = "firefox"

-- Launch apps
hl.bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + E", hl.dsp.exec_cmd(file_browser))
hl.bind("SUPER + R", hl.dsp.exec_cmd(launcher))
hl.bind("SUPER + B", hl.dsp.exec_cmd(web_browser))
hl.bind("SUPER + CTRL + Return", hl.dsp.exec_cmd(calculator))

hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close())
hl.bind("SUPER + M", hl.dsp.exit())
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + F", hl.dsp.window.fullscreen())

-- Group keybinds
hl.bind("SUPER + G", hl.dsp.group.toggle())
hl.bind("SUPER + TAB", hl.dsp.group.move_window())
hl.bind("SUPER + SHIFT + TAB", hl.dsp.group.move_window({ forward = false }))

-- Move focus with vim keys
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))

-- Move focus with arrow keys
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

-- screenshots
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | tee "$HOME/pictures/screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png" | wl-copy'))
hl.bind("SUPER + SHIFT + CTRL + S", hl.dsp.exec_cmd("grim ~/pictures/screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png && notify-send 'Screenshot saved'"))

for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0

  -- Switch workspaces
  hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind("SUPER + ALT + " .. key, hl.dsp.focus({ workspace = i + 10 }))

  -- Move active window to workspace
  hl.bind("SUPER + SHIFT +" .. key, hl.dsp.window.move({ workspace = i }))
  hl.bind("SUPER + ALT + SHIFT +" .. key, hl.dsp.window.move({ workspace = i + 10 }))
end

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })

-- Macros
hl.bind("SUPER + ALT + F1", hl.dsp.exec_cmd("~/.config/scripts/spam_click.py 40 0"))
hl.bind("SUPER + ALT + F1", hl.dsp.exec_cmd("~/.config/scripts/spam_click.py 40 1"))

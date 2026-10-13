hl.config({
  input = {
    kb_model = "",
    kb_layout = "us",
    kb_variant = "",
    kb_options = "",
    kb_rules = "",
    kb_file = "",

    numlock_by_default = true,
    resolve_binds_by_sym = false,
    repeat_rate = 50,
    repeat_delay = 500,
    sensitivity = 0,
    accel_profile = "flat",
    force_no_accel = false,
    left_handed = false,
    scroll_factor = 1.0,
    natural_scroll = false,
    follow_mouse = 1,
    mouse_refocus = true,
    float_switch_override_focus = 1,
    special_fallthrough = false,
    off_window_axis_events = 1,

    touchpad = {
      disable_while_typing = false,
      natural_scroll = true,
      scroll_factor = 0.5,
      clickfinger_behavior = true,
      tap_to_click = true,
      drag_lock = 0,
    },

    tablet = {
      transform = 0,
      output = "current",
      region_posistion = { 0, 0 },
      region_size = { 1920, 1080 },
    },
  },

  gestures = {
    workspace_swipe_distance = 100,
  },
})

--{% if device == "laptop" %}
hl.device({
  name = "msft0001:01-06cb:ce2d-touchpad",
  sensitivity = 0.6,
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.gesture({
  fingers = 4,
  direction = "left",
  action = function()
    hl.exec_cmd("playerctl previous")
  end,
})

hl.gesture({
  fingers = 4,
  direction = "right",
  action = function()
    hl.exec_cmd("playerctl next")
  end,
})

--{% endif -%}

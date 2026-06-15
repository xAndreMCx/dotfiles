hl.window_rule({
  name = "picture_in_picure",
  match = {
    title = "^Picture-in-Picture$",
  },
  float = true,
  pin = true,
  size = { "(0.25*monitor_w)", "(0.25*monitor_h)" },
  move = { "(0.75*monitor_w)-10", "(0.75*monitor_h)-10" },
})

hl.layer_rule({
  name = "volume_osd",
  match = {
    namespace = "^VoluemOSD$",
  },
  animation = "slide",
})

hl.layer_rule({
  name = "power_menu_blur",
  match = {
    namespace = "^power_menu$",
  },
  blur = true,
  no_anim = true,
})

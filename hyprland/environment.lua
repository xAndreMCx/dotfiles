-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("TERMINAL", "wezterm")

--{%- if device == "desktop" %}
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
--{% endif %}
--
hl.env("TERMINAL", "wezterm")
hl.env("XCURSOR_SIZE", "20")
hl.env("XCURSOR_THEME", "BreezeX-RosePine-Linux")

hl.env("HYPRCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")

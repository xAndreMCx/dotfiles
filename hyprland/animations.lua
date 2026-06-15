hl.config({
  animations = {
    enabled = true,
  },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("ease_out_expo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("ease_in_expo", { type = "bezier", points = { { 0.7, 0 }, { 0.84, 0 } } })
hl.curve("ease_in_out_expo", { type = "bezier", points = { { 0.87, 0 }, { 0.13, 1 } } })

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almost_linear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" })
-- hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "slide" })
-- hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almost_linear" })
-- hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almost_linear" })
--
hl.animation({ leaf = "global", enabled = true, speed = 30, bezier = "default" })

hl.animation({ leaf = "windowsIn", enabled = true, speed = 1, bezier = "ease_in_expo", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1, bezier = "ease_out_expo", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, bezier = "ease_in_out_expo" })

hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1, bezier = "almost_linear", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1, bezier = "almost_linear", style = "slide" })

hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almost_linear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almost_linear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })

hl.animation({ leaf = "zoomFactor", enabled = true, speed = 1, bezier = "quick" })

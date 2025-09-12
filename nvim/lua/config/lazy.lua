-- Setup lazy.nvim
local lazy = require('lazy')

lazy.setup({
  spec = {
    { import = 'plugins' },
  },

  install = { missing = true },
  ui = {
    size = { width = 0.8, height = 0.8 },
    backdrop = 40,
  },
  checker = { enabled = true },
  rocks = { hererocks = false, enabled = false },
})

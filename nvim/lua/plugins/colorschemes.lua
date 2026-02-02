return {
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  --   opts = {
  --     flavor = 'mocha',
  --     transparent_background = false,
  --     integrations = {
  --       which_key = true,
  --     },
  --   },
  --   init = function()
  --     vim.cmd.colorscheme('catppuccin-mocha')
  --   end,
  -- },

  {
    'folke/tokyonight.nvim',
    name = 'tokyonight',
    -- priority = 1000,
    init = function()
      vim.cmd.colorscheme('tokyonight-night')

      -- You can configure highlights by doing something like:
      vim.cmd.hi('Comment gui=none')
    end,
  },
  --
  -- {
  --   'Mofiqul/dracula.nvim',
  --   name = 'dracula',
  --   -- priority = 1000,
  --   init = function()
  --     vim.cmd.colorscheme('dracula')
  --   end,
  -- },
}

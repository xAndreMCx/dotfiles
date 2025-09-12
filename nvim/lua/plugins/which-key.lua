-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  name = 'which-key',
  event = 'VimEnter',
  opts = {
    icons = {
      mappings = true,
    },

    -- Document existing key chains
    spec = {
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>g', group = '[G]it Hunk', mode = { 'n', 'v' } },
    },
  },
}

return {
  {
    'hat0uma/csvview.nvim',
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      parser = {
        comments = { '#', '//' },
      },
      keymaps = {
        -- Text objects for selecting fields (e.g. cif to change cell, dif to delete cell)
        textobject_field_inner = { 'if', mode = { 'o', 'x' } },
        textobject_field_outer = { 'af', mode = { 'o', 'x' } },
        -- Excel-like navigation inside table view
        jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
        jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
        jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
        jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
      },
      view = {
        display_mode = 'border', -- 'border' (uses │) or 'highlight'
      },
    },
    cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
    keys = {
      { '<leader>tc', '<cmd>CsvViewToggle<CR>', desc = '[T]oggle [C]SV View', ft = { 'csv', 'tsv' } },
    },
    init = function()
      -- Automatically enable CSV view when opening CSV/TSV files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'csv', 'tsv' },
        desc = 'Enable CSV view',
        callback = function()
          vim.schedule(function()
            require('csvview').enable()
          end)
        end,
      })
    end,
  },
}

return {
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {},
    build = function()
      require('typst-preview').update()
    end,

    keys = {
      { '<leader>tp', ':TypstPreviewToggle<CR>', 'n', desc = '[T]oggle Typst [p]review', silent = true },
    },
  },
}
-- vim.keymap.set('n', '<leader>tp', ':TypstPreview', { desc = '[T]oggle Typst [p]review' })

return {
  'Bekaboo/dropbar.nvim',
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    bar = {
      sources = function(buf, win)
        local sources = require('dropbar.sources')
        local utils = require('dropbar.utils')

        return {
          utils.source.fallback({
            sources.lsp,
            sources.treesitter,
            sources.markdown,
          }),
        }
      end,
    },
  },
}

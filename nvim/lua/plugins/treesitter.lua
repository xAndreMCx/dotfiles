return {
  'nvim-treesitter/nvim-treesitter',
  name = 'treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'asm',
      'bash',
      'c',
      'cpp',
      'css',
      'csv',
      'diff',
      'doxygen',
      'fish',
      'html',
      'hyprlang',
      'json',
      'jsonc',
      'lua',
      'luadoc',
      'make',
      'markdown',
      'markdown_inline',
      'python',
      'scss',
      'vim',
      'vimdoc',
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}

return {
  'folke/todo-comments.nvim',
  name = 'todo-comments',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = true,
    -- TODO:  set the colors to match colorscheme
    --        set custom signs
  },
}

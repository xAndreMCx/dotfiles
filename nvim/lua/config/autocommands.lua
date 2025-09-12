local augroup = vim.api.nvim_create_augroup('auto_group', { clear = true })

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto resize splits when window resizes
vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Resize split panes when vim resizes',
  group = augroup,
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- Enable spell check
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text', 'tex', 'typst' },
  callback = function()
    vim.opt_local.spell = true
  end,
})

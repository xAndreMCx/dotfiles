-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Splitting & Resizing
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { desc = 'Split window vertically', silent = true })
vim.keymap.set('n', '<leader>h', ':split<CR>', { desc = 'Split window horizontally', silent = true })
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase window height', silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease window height', silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width', silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width', silent = true })

-- Move lines up/down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down', silent = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up', silent = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down', silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up', silent = true })

-- Better indenting in visual mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Toggle word wrap
vim.keymap.set('n', '<leader>tw', ':set wrap!<CR>', { desc = '[T]oggle word [w]rap', silent = true })

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Move to next buffer', silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = 'Move to previous buffer', silent = true })
vim.keymap.set('n', '<leader>x', ':bdelete!<CR>', { desc = 'Close current buffer', silent = true })
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', { desc = 'Create new buffer', silent = true })

-- Spell check
vim.keymap.set('n', '<leader>ts', function()
  vim.wo.spell = not vim.wo.spell
  print('Spell check: ' .. (vim.wo.spell and 'ON' or 'OFF'))
end, { desc = 'Toggle spell check' })

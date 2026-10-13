return {
  {
    'ledger/vim-ledger',
    -- Lazy load only on ledger files
    ft = 'ledger',
    init = function()
      -- Optional: Configure the column where amounts will align
      -- 60 is a common standard, adjust as needed
      vim.g.ledger_align_at = 60

      -- Optional: Automatically align amounts when saving the file
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.ledger',
        command = 'LedgerAlign',
      })
    end,
  },
}

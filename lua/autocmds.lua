-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Auto-add missing imports on save for TypeScript
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Add missing imports on save (TypeScript)',
  group = vim.api.nvim_create_augroup('ts-auto-import', { clear = true }),
  pattern = { '*.ts', '*.tsx' },
  callback = function()
    vim.lsp.buf.code_action {
      apply = true,
      context = {
        only = { 'source.addMissingImports.ts' },
        diagnostics = {},
      },
    }
  end,
})

-- Diagnostic config
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = true,
  virtual_lines = false,
  jump = { float = true },
}

-- vim: ts=2 sts=2 sw=2 et

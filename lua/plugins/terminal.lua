return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<C-\\>', desc = 'Toggle terminal' },
      { '<leader>cc', desc = 'Claude Code' },
    },
    opts = {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = '<C-\\>',
      direction = 'float',
      float_opts = {
        border = 'rounded',
        width = function() return math.floor(vim.o.columns * 0.85) end,
        height = function() return math.floor(vim.o.lines * 0.85) end,
      },
      shade_terminals = true,
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)

      -- Dedicated Claude Code terminal
      local Terminal = require('toggleterm.terminal').Terminal
      local claude = Terminal:new {
        cmd = 'claude',
        direction = 'float',
        hidden = true,
        float_opts = {
          border = 'rounded',
          width = function() return math.floor(vim.o.columns * 0.9) end,
          height = function() return math.floor(vim.o.lines * 0.9) end,
        },
        on_open = function(term)
          -- ESC should not close the terminal (Claude Code uses it)
          vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<Esc>', '<Esc>', { noremap = true, silent = true })
        end,
      }

      vim.keymap.set('n', '<leader>cc', function() claude:toggle() end, { desc = '[C]laude [C]ode' })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et

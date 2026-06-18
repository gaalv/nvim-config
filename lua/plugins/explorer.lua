return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1000,
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      explorer = { enabled = true },
      picker = {
        sources = {
          explorer = {
            layout = {
              layout = {
                position = 'left',
                width = 30,
              },
            },
          },
        },
      },
    },
    keys = {
      { '<leader>e', function() Snacks.explorer() end, desc = '[E]xplorer' },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et

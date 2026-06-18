return {
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    ---@module 'obsidian'
    ---@type obsidian.config.ClientOpts
    opts = {
      workspaces = {
        {
          name = 'notes',
          path = '~/Documents/ObsidianVault',
        },
      },

      notes_subdir = 'inbox',

      new_notes_location = 'notes_subdir',

      -- Zettelkasten-style note IDs
      ---@param title string|nil
      ---@return string
      note_id_func = function(title)
        local suffix = ''
        if title ~= nil then
          suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        else
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. '-' .. suffix
      end,

      templates = {
        folder = 'templates',
      },

      -- Sync via obsidian-headless (works without the app)
      sync = {
        enable = true,
      },

      daily_notes = {
        folder = 'daily',
        date_format = '%Y-%m-%d',
        template = nil,
      },

      ui = {
        enable = true,
        checkboxes = {
          [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
          ['x'] = { char = '', hl_group = 'ObsidianDone' },
        },
      },
    },
    keys = {
      { '<leader>no', '<cmd>ObsidianOpen<cr>', desc = '[N]otes: [O]pen in Obsidian' },
      { '<leader>nn', '<cmd>ObsidianNew<cr>', desc = '[N]otes: [N]ew note' },
      { '<leader>ns', '<cmd>ObsidianSearch<cr>', desc = '[N]otes: [S]earch' },
      { '<leader>nq', '<cmd>ObsidianQuickSwitch<cr>', desc = '[N]otes: [Q]uick Switch' },
      { '<leader>nd', '<cmd>ObsidianDailies<cr>', desc = '[N]otes: [D]ailies' },
      { '<leader>nt', '<cmd>ObsidianTemplate<cr>', desc = '[N]otes: Insert [T]emplate' },
      { '<leader>nl', '<cmd>ObsidianLinks<cr>', desc = '[N]otes: [L]inks' },
      { '<leader>nb', '<cmd>ObsidianBacklinks<cr>', desc = '[N]otes: [B]acklinks' },
      { '<leader>nc', '<cmd>ObsidianToggleCheckbox<cr>', desc = '[N]otes: Toggle [C]heckbox' },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et

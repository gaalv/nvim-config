return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
    config = function()
      local lualine = require 'lualine'

      local conditions = {
        buffer_not_empty = function() return vim.fn.empty(vim.fn.expand '%:t') ~= 1 end,
        hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
      }

      local config = {
        options = {
          component_separators = '',
          section_separators = '',
          theme = 'catppuccin',
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }

      local function ins_left(component) table.insert(config.sections.lualine_c, component) end
      local function ins_right(component) table.insert(config.sections.lualine_x, component) end

      ins_left {
        function() return '' end,
        color = function()
          local mode_color = {
            n = '#f38ba8',
            i = '#a6e3a1',
            v = '#89b4fa',
            [''] = '#89b4fa',
            V = '#89b4fa',
            c = '#cba6f7',
            R = '#f5c2e7',
            t = '#f38ba8',
          }
          return { fg = mode_color[vim.fn.mode()] or '#cdd6f4' }
        end,
        padding = { right = 1 },
      }

      ins_left {
        'filename',
        cond = conditions.buffer_not_empty,
      }

      ins_left {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
      }

      ins_left { function() return '%=' end }

      ins_right {
        function()
          local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
          local clients = vim.lsp.get_clients()
          if next(clients) == nil then return '' end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return ''
        end,
        icon = '󰧑',
      }

      ins_right {
        'branch',
        icon = '',
      }

      ins_right {
        'diff',
        symbols = { added = ' ', modified = ' ', removed = ' ' },
        cond = conditions.hide_in_width,
      }

      ins_right {
        function() return os.date '%H:%M' end,
        icon = '',
      }

      lualine.setup(config)
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et

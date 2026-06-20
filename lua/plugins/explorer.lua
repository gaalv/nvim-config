return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = '[E]xplorer' },
    },
    opts = {
      reload_on_bufenter = true,
      hijack_cursor = true,
      hijack_netrw = true,
      sync_root_with_cwd = true,
      hijack_unnamed_buffer_when_opening = true,
      auto_reload_on_write = true,
      diagnostics = {
        enable = false,
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      actions = {
        open_file = {
          quit_on_open = true,
          resize_window = true,
        },
      },
      update_focused_file = {
        enable = true,
      },
      view = {
        centralize_selection = true,
        adaptive_size = false,
        side = 'right',
        preserve_window_proportions = true,
        width = 40,
      },
      renderer = {
        full_name = false,
        indent_markers = {
          enable = false,
        },
        root_folder_label = ':t',
        highlight_git = true,
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
        git_clean = false,
        no_buffer = false,
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 400,
      },
    },
    config = function(_, opts)
      local nvimtree = require 'nvim-tree'

      local function keybindings(bufnr)
        local api = require 'nvim-tree.api'
        local function map(key, fn, desc)
          vim.keymap.set('n', key, fn, { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true })
        end

        api.config.mappings.default_on_attach(bufnr)

        map('P', api.node.open.preview, 'Preview')
        map('s', api.node.open.vertical_no_picker, 'Open Vertical')
        map('S', api.node.open.horizontal_no_picker, 'Open Horizontal')
      end

      opts.on_attach = keybindings
      nvimtree.setup(opts)

      -- Auto open when opening a directory
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('nvim-tree-open', { clear = true }),
        callback = function(args)
          vim.schedule(function()
            local file = args.file
            local is_directory = vim.fn.isdirectory(file) == 1
            if is_directory then
              vim.cmd.cd(file)
              require('nvim-tree.api').tree.open()
            end
          end)
        end,
      })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et

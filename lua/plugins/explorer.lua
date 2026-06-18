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
                width = 40,
              },
            },
            -- Recursively open single-child directories (like VSCode compact folders)
            actions = {
              recursive_toggle = function(picker, item)
                local Actions = require 'snacks.explorer.actions'
                local Tree = require 'snacks.explorer.tree'

                local get_children = function(node)
                  local children = {}
                  for _, child in pairs(node.children) do
                    table.insert(children, child)
                  end
                  return children
                end

                local refresh = function() Actions.update(picker, { refresh = true }) end

                ---@param node snacks.picker.explorer.Node
                local function toggle_recursive(node)
                  Tree:toggle(node.path)
                  refresh()
                  vim.schedule(function()
                    local children = get_children(node)
                    if #children ~= 1 then return end
                    local child = children[1]
                    if not child.dir then return end
                    toggle_recursive(child)
                  end)
                end

                local node = Tree:node(item.file)
                if not node then return end

                if node.dir then
                  toggle_recursive(node)
                else
                  picker:action 'confirm'
                end
              end,
            },
            win = {
              list = {
                keys = {
                  ['<CR>'] = 'recursive_toggle',
                },
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

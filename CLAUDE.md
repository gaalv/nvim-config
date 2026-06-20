# CLAUDE.md

## Project overview

Modular Neovim configuration using lazy.nvim as plugin manager. Focused on TypeScript/React, Go, and agentic coding with AI tools. Inspired by Lazar Nikolov's setup.

## Architecture

- `init.lua` — bootstraps lazy.nvim, loads `options`, `keymaps`, `autocmds`, and all plugins from `lua/plugins/`
- `lua/options.lua` — vim options (leader key is space, nerd font enabled, 2-space indent)
- `lua/keymaps.lua` — global keymaps (window navigation, diagnostics, terminal escape)
- `lua/autocmds.lua` — autocommands (yank highlight, diagnostics config)
- `lua/plugins/*.lua` — each file returns a lazy.nvim plugin spec table

## Conventions

- All plugin files return a table: `return { { 'author/plugin', ... } }`
- Keymaps use `<leader>` prefix grouped by feature: `s` (search), `g` (git), `c` (code), `d` (debug), `n` (notes), `t` (toggle)
- Descriptions follow `[X]keyword` pattern for which-key display
- Plugins should lazy-load via `event`, `ft`, `cmd`, or `keys` when possible
- LSPs go in `lua/plugins/lsp.lua` via the `servers` table
- TypeScript uses vtsls (NOT ts_ls)
- Theme is Catppuccin Mocha — lualine uses catppuccin theme
- Format with stylua (config in `.stylua.toml`: 2 spaces, 120 col width, single quotes)
- End every lua file with `-- vim: ts=2 sts=2 sw=2 et`
- macOS only

## Adding a new plugin

1. Create `lua/plugins/<name>.lua`
2. Return a lazy.nvim spec table
3. Use lazy-loading (`ft`, `event`, `cmd`, or `keys`)
4. Keymaps should include `desc` for which-key

## Adding a new LSP

1. Add to `servers` table in `lua/plugins/lsp.lua`
2. Add formatter to `lua/plugins/format.lua` if needed

## Testing changes

```bash
# Symlink if not already done
ln -s ~/www/personal/nvim-config ~/.config/nvim

# Open and check for errors
nvim

# Check health
:checkhealth

# Check plugin status
:Lazy

# Check LSP status
:LspInfo

# Check Mason installs
:Mason
```

## Dependencies

- Neovim >= 0.10, Git, Nerd Font, make, Node.js, Go, lazygit
- Obsidian vault path configured in `lua/plugins/notes.lua`
- Anthropic API key for avante.nvim: `export ANTHROPIC_API_KEY=...`
